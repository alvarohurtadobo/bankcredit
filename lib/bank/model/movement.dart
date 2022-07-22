class Movement {
  int id = 0;
  int idProduct = 0;
  String dateString = "";
  String datetimeProcessString = "";
  String type = "";
  int idVisor = 0;
  String canal = "";
  String branchOffice = "";
  int term = 0;
  String tax = "";
  String value = "";
  String applicationDatetimeString = "";
  String status = "";

  // Auxiliar
  DateTime datetimeProcess = DateTime.now();

  static List<MonthYear> existingMonthYears(List<Movement> myMovements) {
    List<MonthYear> monthYears = [];
    for (Movement movement in myMovements) {
      List<int> years = monthYears.map((e) => e.year).toList();
      List<int> months = monthYears.map((e) => e.month).toList();
      if (years.contains(movement.datetimeProcess.year) &&
          months.contains(movement.datetimeProcess.month)) {
        //included
      } else {
        monthYears.add(MonthYear(
            movement.datetimeProcess.month, movement.datetimeProcess.year));
      }
    }
    print("Have ${monthYears.length} month years");
    return monthYears;
  }

  Movement.fromBackendResponse(Map<String, dynamic> response) {
    id = response["Id"] ?? 0;
    idProduct = response["IdProducto"] ?? 0;
    dateString = response["Fecha"] ?? "";
    datetimeProcessString = response["FechaProceso"] ?? "";
    type = response["Tipo"] ?? "";
    idVisor = response["IdVisor"] ?? 0;
    canal = response["Canal"] ?? "";
    branchOffice = response["Sucursal"] ?? "";
    term = response["Plazo"] ?? 0;
    tax = response["TasaInteres"] ?? "";
    value = response["Valor"] ?? "";
    applicationDatetimeString = response["FechaAplicacion"] ?? "";
    status = response["Estado"] ?? "";
    try {
      datetimeProcess = DateTime.parse(datetimeProcessString);
    } catch (err) {
      print("Unable to convert datetime");
      datetimeProcess = DateTime.now();
    }
  }
}

class MonthYear {
  int month = 0;
  int year = 0;
  MonthYear(this.month, this.year);

  @override
  String toString() {
    return "MY: $month, $year";
  }
}
