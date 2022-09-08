import 'package:credidiunsa_app/bank/model/paymentMethod.dart';
import 'package:credidiunsa_app/common/model/cuotaMensual.dart';
import 'package:credidiunsa_app/common/model/currencyFormatter.dart';
import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import '../../common/widgets/summaryCard.dart';
import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  late PaymentMethod payNow;

  @override
  void initState() {
    API.getPaymentMethods().then((resp) {
      if (resp.status == 200) {
        myPayments = resp.myBody["Lista"]
            .map<PaymentMethod>(
                (elem) => PaymentMethod.fromBackendResponse(elem))
            .toList();
        setState(() {
          payNow = myPayments.firstWhere((element) => element.id == 1);
          myPayments.remove(payNow);
          print("Length is ${myPayments.length}");
        });
      }
    });
    super.initState();
  }

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
            FutureBuilder<BackendResponse>(
                future: API.getCuota(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    BackendResponse? myRes = snapshot.data;
                    print("myRes is $myRes");
                    double cuota =
                        CuotaMensual.fromBackendResponse(myRes!.myBody).cuota;
                    print("Couta is $cuota");
                    return summaryCard("Tu cuota", "mensual actual es",
                        currencyFormatter.format(cuota));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            Container(
              height: Sizes.height / 3.2 / 5,
              decoration: BoxDecoration(
                  color: const Color(0xffFF6A1B),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(2 * Sizes.boxSeparation),
                      bottomRight: Radius.circular(2 * Sizes.boxSeparation))),
              child: GestureDetector(
                onTap: () {
                  try {
                    print("Launch ${payNow.link}");
                    customLaunchUrl(payNow.link);
                  } catch (err) {
                    print("TOO FAST");
                  }
                },
                child: Center(
                    child: Text("Quiero Pagar ahora",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: Sizes.font8))),
              ),
            ),
            SizedBox(
              height: 5 * Sizes.boxSeparation,
            ),
            const Text("También puedes hacer tus pagos de froma presencial en:",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 5 * Sizes.boxSeparation,
            ),
            myPayments.isEmpty
                ? Container()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          paymentButton(context, myPayments[0]),
                          paymentButton(context, myPayments[1]),
                        ],
                      )
                    ],
                  ),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            myPayments.isEmpty
                ? Container()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          paymentButton(context, myPayments[2]),
                          paymentButton(context, myPayments[3]),
                        ],
                      )
                    ],
                  ),
            SizedBox(
              height: 2 * Sizes.boxSeparation,
            ),
            Row(
              children: [
                SizedBox(
                  width: (Sizes.width-2*Sizes.padding)*0.1,
                  child: const Icon(
                    Icons.warning,
                    color: Color(0xffE07117),
                  ),
                ),
                SizedBox(
                  width: (Sizes.width-2*Sizes.padding)*0.05,
                ),
                SizedBox(
                  width: (Sizes.width-2*Sizes.padding)*0.85,
                  child: Text("Paga a tiempo y evita recargas en tus cuotas.",
                      maxLines: 2, style: TextStyle(fontSize: Sizes.font10)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget paymentButton(BuildContext context, PaymentMethod payment) {
    String name = payment.name.toLowerCase();
    if (name.contains(" ")) {
      List<String> arrayName = name.split(" ");
      name = arrayName[arrayName.length - 1];
    }
    name = "assets/images/$name.png";
    print("Prepared card for $name");
    return GestureDetector(
      onTap: () {
        customLaunchUrl(payment.link);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Sizes.padding / 2),
        height: Sizes.height / 10,
        width: Sizes.width / 2 - 1.5 * Sizes.padding,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage(name))),
      ),
    );
  }
}
