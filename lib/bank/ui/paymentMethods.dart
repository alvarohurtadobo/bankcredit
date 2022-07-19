import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';

import '../../common/widgets/summaryCard.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
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
            const Text("Medios de pago",
                style: TextStyle(
                    color: Color(0xff0077CD),
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            // SizedBox(
            //   height: Sizes.boxSeparation,
            // ),
            const Text("Conoce dónde hacer tus pagos",
                style: TextStyle(
                    color: Color(0xff0077CD),
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            summaryCard("Tu cuota", "mensual actual es", "L 40,000.00"),
            Container(
              height: Sizes.height / 3.2 / 5,
              decoration: BoxDecoration(
                  color: const Color(0xffFF6A1B),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(2 * Sizes.boxSeparation),
                      bottomRight: Radius.circular(2 * Sizes.boxSeparation))),
              child: Center(
                  child: Text("Quiero Pagar ahora",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))),
            ),
            SizedBox(
              height: 5 * Sizes.boxSeparation,
            ),
            const Text("También puedes hacer tus pagos de froma presencial en:",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 5 * Sizes.boxSeparation,
            ),
            Center(
              child: Wrap(
                children: [
                  paymentButton(context, "image_08.png"),
                  paymentButton(context, "image_09.png"),
                  paymentButton(context, "image_10.png"),
                  paymentButton(context, "image_11.png"),
                ],
              ),
            ),
            SizedBox(
              height: 2 * Sizes.boxSeparation,
            ),
            Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Color(0xffE07117),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Paga a tiempo y evita recargas en tus cuotas.",
                    style: TextStyle(fontSize: 15)),
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
