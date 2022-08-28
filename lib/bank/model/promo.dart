class Promo {
  int id = 0;
  int idType = 0;
  String type = "";
  String image = "";
  String link = "";
  bool status = false;
  DateTime controlDate = DateTime.now();

  Promo.fromBackendResponse(Map<String, dynamic> myResponse) {
    id = myResponse["Id"];
    idType = myResponse["IdTipo"];
    type = myResponse["Tipo"] ?? "Promoción";
    image = myResponse["Imagen"] ?? "";
    link = myResponse["link"];
    status = myResponse["IdEstado"];
    controlDate =
        DateTime.tryParse(myResponse["FechaControl"]) ?? DateTime.now();
  }
}

List<Promo> myPromos = [];
List<Promo> myNovelties = [];