import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';

import '../../common/widgets/summaryCard.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({Key? key}) : super(key: key);

  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
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
            Text("Selecciona el tipo de información que deseas ver:"),
            SizedBox(
              height: Sizes.padding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation, vertical: 0),
                    width: (Sizes.width - 3 * Sizes.padding) / 2,
                    decoration: BoxDecoration(
                        color: const Color(0xffE8E8E8),
                        borderRadius: BorderRadius.circular(Sizes.border/2),
                        border: Border.all(color: const Color(0xff7A8084))),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/login");
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
                    padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                    width: (Sizes.width - 3 * Sizes.padding) / 2,
                    decoration: BoxDecoration(
                        color: const Color(0xffE8E8E8),
                        borderRadius: BorderRadius.circular(Sizes.border/2),
                        border: Border.all(color: const Color(0xff7A8084))),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/login");
                        },
                        child: const Text(
                          "Detalle cuota",
                          style:
                              TextStyle(color: Color(0xff7A8084), fontSize: 12),
                        )))
              ],
            )
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
}
