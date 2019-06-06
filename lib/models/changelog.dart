
import 'package:wolflog/models/Tarefa.dart';

class Changelog{
  List<String> _pacotes;
  List<Tarefa> _txtTarefas;

  Changelog(){
    _txtTarefas = new List();
    _pacotes = new List();
  }

  List get Pacotes{
    return this._pacotes;
  }
  List get TxtTarefas{
    return this._txtTarefas;
  }
  set Pacotes (List pacotes){
    this._pacotes = pacotes;
  }
  void addTarefa(Tarefa tarefa){
    this._txtTarefas.add(tarefa);
  }
}