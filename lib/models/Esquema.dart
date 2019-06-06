class Esquema {
  List<String> pacotes;
  int idGrupo;
  String titulo;

  Esquema({
    this.titulo,
    this.pacotes,
  });
  

  List get Pacotes{
    return this.pacotes;
  }

  set Pacotes(List pacotes){
    this.pacotes = pacotes;
  }

  String get Titulo{
    return this.titulo;
  }

  set Titulo(String titulo){
    this.titulo = titulo;
  }
}
