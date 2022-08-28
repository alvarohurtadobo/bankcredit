class PaymentMethod{
  int id = 0;
  String name ="";
  String link ="";
  String image ="";
  bool status = false;
  DateTime controlDate = DateTime.now();

  PaymentMethod.fromBackendResponse(Map<String, dynamic> response) {
    id = response["Id"] ?? 0;
    name = response["Nombre"] ?? "";
    link = response["link"] ?? "";
    image = response["Imgen"] ?? "";
    status = response["IdEstado"] ?? false;
    controlDate = DateTime.tryParse(response["FechaControl"]) ?? DateTime.now();
  }
}

List<PaymentMethod> myPayments = [];