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
}
