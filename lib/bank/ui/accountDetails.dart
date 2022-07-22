import 'package:flutter/material.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/bank/model/movement.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';

List<String> months = [
  "Enero",
  "Febrero",
  "Marzo",
  "Abril",
  "Mayo",
  "Junio",
  "Julio",
  "Agosto",
  "Septiempre",
  "Octubre",
  "Noviembre",
  "Diciembre"
];

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({Key? key}) : super(key: key);

  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  bool historicMovementActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      drawer: MyDrawer(),
      body: Container(
        color: const Color(0xffE8E8E8),
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: ListView(
          children: [
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            const Text("Detalles de la cuenta",
                style: TextStyle(
                    color: Color(0xff0077CD),
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            // SizedBox(
            //   height: Sizes.boxSeparation,
            // ),
            const Text("movimientos de compras",
                style: TextStyle(
                    color: Color(0xff0077CD),
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            const Text("Selecciona el tipo de información que deseas ver:"),
            SizedBox(
              height: Sizes.padding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes.boxSeparation, vertical: 0),
                    width: (Sizes.width - 3 * Sizes.padding) / 2,
                    decoration: BoxDecoration(
                        color: const Color(0xffE8E8E8),
                        borderRadius: BorderRadius.circular(Sizes.border / 2),
                        border: Border.all(color: const Color(0xff7A8084))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            historicMovementActive = true;
                          });
                        },
                        child: const Text(
                          "Histórico movimientos",
                          style:
                              TextStyle(color: Color(0xff7A8084), fontSize: 12),
                        ))),
                SizedBox(
                  width: Sizes.boxSeparation,
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                    width: (Sizes.width - 3 * Sizes.padding) / 2,
                    decoration: BoxDecoration(
                        color: const Color(0xffE8E8E8),
                        borderRadius: BorderRadius.circular(Sizes.border / 2),
                        border: Border.all(color: const Color(0xff7A8084))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            historicMovementActive = false;
                          });
                        },
                        child: const Text(
                          "Detalle cuota",
                          style:
                              TextStyle(color: Color(0xff7A8084), fontSize: 12),
                        )))
              ],
            ),
            SizedBox(
              height: Sizes.padding,
            ),
            historicMovementActive
                ? Column(
                    children: [
                      carousel(),
                      SizedBox(
                        height: Sizes.padding,
                      ),
                      FutureBuilder<BackendResponse>(
                          future: API.getMovements(currentUser.identification),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              BackendResponse myRes = snapshot.data!;
                              if (myRes.status == 200) {
                                List<Movement> myMovements =
                                    myRes.myBody["Lista"].map<Movement>((res) {
                                  return Movement.fromBackendResponse(res);
                                }).toList();
                                myMovements.sort((a,b)=>-a.datetimeProcess.compareTo(b.datetimeProcess));
                                List<MonthYear> existingMonthYears =
                                    Movement.existingMonthYears(myMovements);
                                print(existingMonthYears);
                                List<Widget> myTiles = [];
                                for (MonthYear monthYear
                                    in existingMonthYears) {
                                  myTiles.add(monthTile(
                                      monthYear.month, monthYear.year));
                                  List<Movement> auxMovements = myMovements
                                      .where((element) =>
                                          element.datetimeProcess.month ==
                                              monthYear.month &&
                                          element.datetimeProcess.year ==
                                              monthYear.year)
                                      .toList();

                                  myTiles.addAll(auxMovements.map((mov) {
                                    return movementTile(mov);
                                  }));
                                }
                                return Column(
                                  children: myTiles,
                                );
                              }
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          })
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget paymentButton(BuildContext context, String name) {
    return Container(
      margin: EdgeInsets.all(Sizes.padding / 2),
      height: Sizes.height / 10,
      width: Sizes.width / 3.2,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage("assets/demo/$name"))),
    );
  }

  Widget carousel() {
    return SizedBox(
      height: Sizes.tileHeightCard + 2 * Sizes.boxSeparation,
      width: Sizes.width - 2 * Sizes.padding,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [reportButton(0), reportButton(1), reportButton(2)],
      ),
    );
  }

  Widget monthTile(int month, int year) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        decoration: const BoxDecoration(
            color: Color(0xff0077CD),
            border: Border(bottom: BorderSide(color: Color(0xff7A8084)))),
        height: Sizes.tileHeightMedium,
        width: Sizes.width - 2 * Sizes.padding,
        child: Text(
          "${months[month % 12]} de $year",
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  Widget movementTile(Movement movement) {
    print("Processing ${movement.idProduct}, ${movement.dateString}");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xff7A8084)))),
      height: Sizes.tileHeightMedium,
      width: Sizes.width - 2 * Sizes.padding,
      child: Row(children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: Sizes.boxSeparation),
          width: 0.10 * Sizes.width,
          child: Text(movement.idProduct.toString(),
              style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff0F62A4),
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: Sizes.boxSeparation),
          width: 0.25 * Sizes.width,
          child: Text(movement.type.toString(),
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: Sizes.boxSeparation),
          width: 0.08 * Sizes.width,
          child: const Text("TI:",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal)),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: Sizes.boxSeparation),
          width: 0.14 * Sizes.width,
          child: Text(movement.tax,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal)),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: Sizes.boxSeparation),
            width: 0.2 * Sizes.width,
            child: Text("L${movement.value}",
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal)),
          ),
        )
      ]),
    );
  }

  Widget reportButton(int type) {
    String text = "Descargar histórico";
    String iconPath = "assets/icons/downloadIcon.png";
    switch (type) {
      case 0:
        text = "Descargar histórico";
        iconPath = "assets/icons/downloadIcon.png";
        break;
      case 1:
        text = "Constancia saldo cero";
        iconPath = "assets/icons/paperIcon.png";
        break;
      case 2:
        text = "Referencia comercial";
        iconPath = "assets/icons/papersIcon.png";
        break;
      default:
        text = "Descargar histórico";
        iconPath = "assets/icons/downloadIcon.png";
    }
    return Container(
      alignment: Alignment.center,
      height: Sizes.tileHeightCard + 2 * Sizes.boxSeparation,
      width: Sizes.width / 3,
      margin: EdgeInsets.only(right: 2 * Sizes.boxSeparation),
      padding: EdgeInsets.symmetric(vertical: Sizes.boxSeparation),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.boxSeparation),
          )),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Sizes.tileHeightSmall,
              width: Sizes.tileHeightSmall,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(iconPath))),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xffFF6A1B),
                fontSize: 18,
              ),
            )
          ]),
    );
  }
}
