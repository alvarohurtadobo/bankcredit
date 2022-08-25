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
              height: 2 * Sizes.boxSeparation,
            ),
            SizedBox(
              height: Sizes.height / 5,
              width: double.infinity,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                mediumCard(context, name: "assets/demo/image_04.png"),
                mediumCard(context, name: "assets/demo/image_05.png"),
                mediumCard(context, name: "assets/demo/image_04.png"),
              ]),
            ),
            // SizedBox(
            //   height: 1*Sizes.boxSeparation,
            // ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal:Sizes.boxSeparation, vertical: Sizes.padding*0.7),
              child: Text(
                "Latest from DIUNSA",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Sizes.font10),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: Sizes.width * 0.7 * 0.7,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  newsBox(
                      "¡Estamos preparados para cualquier entrenamiento!",
                      "DIUNSA",
                      "45K views",
                      "2 weeks ago",
                      "assets/demo/image_12.png"),
                  newsBox(
                      "¡Estamos preparados para cualquier entrenamiento!",
                      "DIUNSA",
                      "45K views",
                      "2 weeks ago",
                      "assets/demo/image_12.png"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget newsBox(String title, String author, String views, String releaseDate,
      String assetImage) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
      color: Colors.white,
      width: Sizes.width * 0.7,
      height: Sizes.width * 0.7 * 0.7,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: Sizes.width * 0.7,
          height: Sizes.width * 0.7 * 0.7 * 0.7,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(assetImage), fit: BoxFit.cover)),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: Sizes.boxSeparation),
          child: Row(
            children: [
              Container(
                width: Sizes.width * 0.7 * 0.7 * 0.15,
                height: Sizes.width * 0.7 * 0.7 * 0.15,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/demo/image_13.png"))),
              ),
              SizedBox(
                width: Sizes.width * 0.7 * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold),),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(author),
                        Text(views),
                        Text(releaseDate),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
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
      margin: EdgeInsets.only(right: Sizes.padding),
      height: Sizes.height / 5,
      width: Sizes.width / 2.8,
      decoration: BoxDecoration(
        // color: Colors.yellow,
          image: DecorationImage(image: AssetImage(name), fit: BoxFit.contain)),
    );
  }
}
