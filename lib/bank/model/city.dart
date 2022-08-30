class City {
  int id = 0;
  String description = "";
  int order = 0;
  int idFiltro = 0;

  City.fromBackendResponse(Map<String, dynamic> res){
    id = res["Id"]??0;
    description = res["Descripcion"]??"";
    order = res["Orden"] ??0;
    idFiltro = res["IdFiltro"]??0;
  }
}

List<City> myCities = [];