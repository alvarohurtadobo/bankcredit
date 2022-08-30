import 'package:credidiunsa_app/bank/model/city.dart';
import 'package:credidiunsa_app/common/repository/api.dart';

Future<bool> getCities() async {
  BackendResponse myRes = await API.getCatalog();
  if (myRes.idError != 0) {
    return false;
  }
  if (!myRes.myBody.containsKey("Lista")) {
    return false;
  }
  bool arrived = false;
  for (Map<String, dynamic> item in myRes.myBody["Lista"]) {
    if (item.containsKey("TipoCatalogo")) {
      if (item["TipoCatalogo"] == "Ciudad Reporte") {
        if (item.containsKey("Catalogo")) {
          arrived = true;
          myCities = item["Catalogo"]
              .map<City>((elem) => City.fromBackendResponse(elem))
              .toList();
          print("Got ${myCities.length} cities, arrived: $arrived");
        }
      }
    }
  }

  return arrived;
}
