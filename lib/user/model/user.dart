class User {
  int id = 0;
  String firstName = "";
  String secondName = "";
  String firstSurname = "";
  String secondSurname = "";
  String email = "";
  String phone = "";
  String password = "";
  int? idIdentification;
  String identification = "";

  String pictureUrl = "";

  User.empty(){
    idIdentification =1;
  }

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
      "Id": 1,
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
    email = backendResponse["Correo"] ?? "";
    phone = backendResponse["Celular"] ?? "";
    idIdentification = backendResponse["IdIdentificacion"] ?? 1;
    identification = backendResponse["Identificacion"] ?? 1;
    pictureUrl = backendResponse["FotoPerfil"] ?? "";
  }

  String getName() {
    if (secondName != "") {
      return "$firstName $secondName";
    }
    return firstName;
  }

  String getLastName() {
    if (secondSurname != "") {
      return "$firstSurname $secondSurname";
    }
    return firstSurname;
  }

  void setNames(String names) {
    if (names.contains(" ")) {
      firstName = names.split(" ")[0];
      secondName = names.split(" ").sublist(1).join(" ");
    }
  }

  String getFullName() {
    return "${getName()} ${getLastName()}";
  }

  void setLastNames(String surnames) {
    if (surnames.contains(" ")) {
      firstSurname = surnames.split(" ")[0];
      secondSurname = surnames.split(" ").sublist(1).join(" ");
    }
  }
}

User currentUser = User.empty();

String filePathTemporal = "";
String notLoggedDocument = "";