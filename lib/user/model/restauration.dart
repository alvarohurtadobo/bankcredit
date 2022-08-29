class Restauration {
  int id = 0;
  String medium = "";
  String mediumLabel = "";
  String destiny = "";

  Restauration.fromBackendResponse(Map<String, dynamic> response) {
    id = response["IdMedio"];
    medium = response["Medio"] ?? "";
    destiny = response["Destino"] ?? "";
    if (medium == "Corre") {
      mediumLabel = "Correo electrónico";
    }
    if (medium == "SMS") {
      mediumLabel = "Mensaje de texto";
    }
    if (medium == "Whats") {
      mediumLabel = "Mensaje de whatsapp";
    }
  }
}

List<Restauration> myRestaurations = [];
int chosenRestaurationId = 0;
