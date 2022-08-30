import 'package:credidiunsa_app/bank/bloc/receiveFiles.dart';
import 'package:credidiunsa_app/common/model/cuotaMensual.dart';
import 'package:credidiunsa_app/common/model/currencyFormatter.dart';
import 'package:credidiunsa_app/common/widgets/extendedSummaryCard.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
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
  bool historicMovementActive = true;
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
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: Sizes.boxSeparation, vertical: 0),
                    width: (Sizes.width - 3 * Sizes.padding) / 2,
                    decoration: BoxDecoration(
                        color: historicMovementActive
                            ? const Color(0xff0077CD)
                            : const Color(0xffE8E8E8),
                        borderRadius: BorderRadius.circular(Sizes.border / 2),
                        border: Border.all(color: const Color(0xff7A8084))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            historicMovementActive = true;
                          });
                        },
                        child: Text(
                          "Histórico movimientos",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: historicMovementActive
                                  ? Colors.white
                                  : const Color(0xff7A8084),
                              fontSize: Sizes.font10 * 0.95),
                        ))),
                SizedBox(
                  width: Sizes.boxSeparation,
                ),
                Container(
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                    width: (Sizes.width - 3 * Sizes.padding) / 2,
                    decoration: BoxDecoration(
                        color: historicMovementActive
                            ? const Color(0xffE8E8E8)
                            : const Color(0xff0077CD),
                        borderRadius: BorderRadius.circular(Sizes.border / 2),
                        border: Border.all(color: const Color(0xff7A8084))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            historicMovementActive = false;
                          });
                        },
                        child: Text(
                          "Detalle cuota",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: historicMovementActive
                                  ? const Color(0xff7A8084)
                                  : Colors.white,
                              fontSize: Sizes.font10),
                        )))
              ],
            ),
            SizedBox(
              height: Sizes.padding,
            ),
            Container(
                // padding:
                //     EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                width: (Sizes.width - 2 * Sizes.padding),
                decoration: BoxDecoration(
                    color: const Color(0xffFF6A1B),
                    borderRadius: BorderRadius.circular(Sizes.border / 2),
                    border: Border.all(color: const Color(0xffFF6A1B))),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/documents");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Documentos",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: Sizes.font10),
                        ),
                        SizedBox(
                          width: Sizes.boxSeparation,
                        ),
                        Image.asset(
                          "assets/icons/download.png",
                          width: Sizes.padding,
                          height: Sizes.padding,
                        )
                      ],
                    ))),
            SizedBox(
              height: Sizes.padding,
            ),
            historicMovementActive
                ? Column(
                    children: [
                      FutureBuilder<BackendResponse>(
                          future: API.getMovements(currentUser.identification),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              BackendResponse myRes = snapshot.data!;
                              print("Response has error ${myRes.message}");
                              if (myRes.idError == 0) {
                                List<Movement> myMovements =
                                    myRes.myBody["Lista"].map<Movement>((res) {
                                  return Movement.fromBackendResponse(res);
                                }).toList();
                                myMovements.sort((a, b) => -a.datetimeProcess
                                    .compareTo(b.datetimeProcess));
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

                                  auxMovements.sort((a, b) =>
                                      a.datetimeProcess.day -
                                      b.datetimeProcess.day);

                                  myTiles.addAll(auxMovements.map((mov) {
                                    return movementTile(mov);
                                  }));
                                }
                                return Column(
                                  children: myTiles,
                                );
                              } else {
                                simpleAlertDialog(
                                    context, "Error", myRes.message);
                              }
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          })
                    ],
                  )
                : FutureBuilder<BackendResponse>(
                    future: API.getCuota(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        BackendResponse myRes = snapshot.data!;
                        if (myRes.idError == 0) {
                          CuotaMensual myCuota =
                              CuotaMensual.fromBackendResponse(myRes.myBody);
                          return extendedSummaryCard(myCuota);
                        } else {
                          simpleAlertDialog(context, "Error", myRes.message);
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })
          ],
        ),
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
      padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xff7A8084)))),
      height: Sizes.tileHeightMedium,
      width: Sizes.width - 2 * Sizes.boxSeparation,
      child: Row(children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: Sizes.boxSeparation),
          width: 0.10 * Sizes.width,
          child: Text(movement.datetimeProcess.day.toString(),
              style: TextStyle(
                  fontSize: Sizes.font10,
                  color: const Color(0xff0F62A4),
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: Sizes.boxSeparation),
          width: 0.28 * Sizes.width,
          child: Text(movement.type.toString(),
              style: TextStyle(
                  fontSize: Sizes.font10,
                  color: Colors.black,
                  fontWeight: FontWeight.normal)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: Sizes.boxSeparation),
          width: 0.06 * Sizes.width,
          child: Text("TI:",
              maxLines: 1,
              style: TextStyle(
                  fontSize: Sizes.font10,
                  color: Colors.black,
                  fontWeight: FontWeight.normal)),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: Sizes.boxSeparation),
          width: 0.14 * Sizes.width,
          child: Text(movement.tax,
              style: TextStyle(
                  fontSize: Sizes.font10,
                  color: Colors.black,
                  fontWeight: FontWeight.normal)),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: Sizes.boxSeparation),
            width: 0.21 * Sizes.width,
            child: Text(currencyFormatter.format(double.parse(movement.value)),
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: Sizes.font10,
                    color: Colors.black,
                    fontWeight: FontWeight.normal)),
          ),
        )
      ]),
    );
  }
}
