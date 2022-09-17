// ignore_for_file: file_names
RegExp emailReg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

bool isGoodEmail(String email){
  return emailReg.hasMatch(email);
}