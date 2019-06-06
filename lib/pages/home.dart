import 'package:flutter/material.dart';
import 'package:wolflog/models/Esquema.dart';
import 'package:wolflog/models/Tarefa.dart';
import 'package:wolflog/models/changelog.dart';
import 'package:wolflog/models/listaEsquemas.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wolflog/widget/fancyFab.dart';
import 'package:pdf/pdf.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Esquema> _listEsquemas = listaEsquemas;
  final txtTarefaControler = TextEditingController();
  List<String> _listPacotes = [];
  String TXTPACOTE;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Tarefa tarefa;
  Changelog changelog = new Changelog();
  

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WolfLog'),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _lblTarefa(),
          _txtTarefa(),
          _drpDwnPacotes(),
        ],
      ),
      floatingActionButton: FancyFab(
        onPressedAdd: () {
          addTarefa();
        },
        onPressedShared: () {
          compartilharChangeLog();
        },
      ),
      drawer: _tlaEsquemas(),
    );
  }


  void addTarefa() {
    if (txtTarefaControler.text != '' && TXTPACOTE != '') {
      setState(() {
        tarefa = new Tarefa (txtTarefaControler.text, TXTPACOTE);
        changelog.addTarefa(tarefa);
        txtTarefaControler.text = '';
      });
    }
  }

  String relatorio(){
    String rel = "ChangeLog\n\n";

    for (String p in _listPacotes){
      rel = rel  + p + "\n";
      for (Tarefa t in changelog.TxtTarefas){
        if(t.txtPacote == p){
          rel = rel + "\t" + t.txtTarefa + "\n";
        }
      }
      rel = rel + "\n";
    }
    rel = rel + "\nCriado por WolfLog";
    return rel;
  }

  void compartilharChangeLog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("WolfLog"),
          content: new Text(relatorio()),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]
        );
      }
    );
  }

  Widget _drpDwnPacotes() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: DropdownButton(
          hint: Text("Escolha o Pacote da tarefa"),
          value: TXTPACOTE,
          onChanged: (newValue) {
            setState(() {
              TXTPACOTE = newValue;
            });
          },
          items: _listPacotes.map((pacote) {
            return DropdownMenuItem(
              child: Text(pacote),
              value: pacote,
            );
          }).toList(),
        ));
  }

  Widget _tlaEsquemas() {
    return Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          new DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
              child: new Text(
                'Esquemas',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            decoration: new BoxDecoration(color: Colors.cyan),
          ),
          ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: _listEsquemas.map((esquema) {
                return Card(
                    child: ListTile(
                  title: Text(esquema.titulo),
                  subtitle: Text(esquema.Pacotes.toString()),
                  leading: Icon(Icons.change_history),
                  onTap: () {
                    setState(() {
                      changelog = new Changelog();
                      TXTPACOTE = null;
                      _listPacotes = esquema.Pacotes;
                      Navigator.pop(context);
                    });
                  },
                ));
              }).toList())
        ],
      ),
    );
  }

  Widget _txtTarefa() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        controller: txtTarefaControler,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Tarefa',
            icon: new Icon(
              Icons.assignment,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _lblTarefa() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new Text(
        'Nova Tarefa',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
      ),
    );
  }

  Widget _btnAdd() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(
        Icons.add,
        color: Colors.black,
      ),
      foregroundColor: Colors.white,
    );
  }
}
