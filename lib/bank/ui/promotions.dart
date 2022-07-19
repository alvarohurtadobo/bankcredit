import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({Key? key}) : super(key: key);

  @override
  _PromotionsPageState createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar(context),
      body: Container(
        color: const Color(0xffE8E8E8),
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: ListView(
          children: [
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            const Text("Promociones",
                style: TextStyle(
                    color: Color(0xff0F62A4),
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            const Text("y novedades",
                style: TextStyle(color: Color(0xff0F62A4), fontSize: 20)),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            SizedBox(
              height: Sizes.height / 5,
              width: double.infinity,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                longCard(context, name: "assets/demo/image_02.png"),
                longCard(context, name: "assets/demo/image_03.png"),
              ]),
            ),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            SizedBox(
              height: Sizes.height / 5,
              width: double.infinity,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                mediumCard(context, name: "assets/demo/image_04.png"),
                mediumCard(context, name: "assets/demo/image_05.png"),
                mediumCard(context, name: "assets/demo/image_06.png"),
              ]),
            ),
            // SizedBox(
            //   height: 1*Sizes.boxSeparation,
            // ),
            Container(
                height: Sizes.height / 2,
                width: Sizes.width * 1.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/demo/image_07.png"),
                        fit: BoxFit.contain)))
          ],
        ),
      ),
    );
  }

  Widget longCard(BuildContext context,
      {String name = "assets/demo/image_02.png"}) {
    return Container(
      height: Sizes.height / 5,
      width: Sizes.width / 1.4,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(name), fit: BoxFit.cover)),
    );
  }

  Widget mediumCard(BuildContext context,
      {String name = "assets/demo/image_04.png"}) {
    return Container(
      height: Sizes.height / 5,
      width: Sizes.width / 2.8,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(name), fit: BoxFit.fill)),
    );
  }
}
