class User {
  int id = 0;
  String firstName = "";
  String secondName = "";
  String firstSurname = "";
  String secondSurname = "";
  String email = "";
  String phone = "";
  String password = "";
  int idIdentification = 0;
  String identification = "";

  User.empty();
  
  User(
      {required this.firstName,
      required this.secondName,
      required this.firstSurname,
      required this.secondSurname,
      required this.email,
      required this.phone,
      required this.password,
      required this.identification,
      this.idIdentification = 1}) {
    id = 1;
  }

  Map<String, dynamic> toBackendMap() {
    return {
      "Usuario": identification,
      "IdIdentificacion": idIdentification,
      "Identificacion": identification,
      "PrimerNombre": firstName,
      "SegundoNombre": secondName,
      "PrimerApellido": firstSurname,
      "SegundoApellido": secondSurname,
      "Correo": email,
      "Celular": phone,
      "IdPerfil": 1
    };
  }

  User.fromBackendResponse(Map<String, dynamic> backendResponse) {
    firstName = backendResponse["PrimerNombre"] ?? "";
    secondName = backendResponse["SegundoNombre"] ?? "";
    firstSurname = backendResponse["PrimerApellido"] ?? "";
    secondSurname = backendResponse["SegundoApellido"] ?? "";
    email = backendResponse["email"] ?? "";
    phone = backendResponse["Celular"] ?? "";
    idIdentification = backendResponse["IdIdentificacion"] ?? 1;
    identification = backendResponse["Identificacion"] ?? 1;
  }
}

User currentUser = User.empty();
