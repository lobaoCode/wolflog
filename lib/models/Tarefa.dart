import 'package:flutter/semantics.dart';

class Tarefa{
  String txtTarefa;
  String txtPacote;

  Tarefa(String txtTarefa, String txtPacote){
    this.txtPacote = txtPacote;
    this.txtTarefa = txtTarefa;
  }

  @override
  String toString() {
    return txtTarefa;
  }
}