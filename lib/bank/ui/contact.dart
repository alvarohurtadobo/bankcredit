
// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:credidiunsa_app/bank/model/socialMedia.dart';
import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String whatsappLink = "";
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
            const Text("Contáctanos",
                style: TextStyle(
                    color: Color(0xff0077CD),
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            SizedBox(
              height: 2 * Sizes.boxSeparation,
            ),
            const Text("Tu nos importas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text(
              "Queremos hacerte la vida mucho más fácil, por eso tenemos dispuesto para ti, varios canales de atención donde podrás contactarnos de forma directa.",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            Container(
              width: double.infinity,
              height: Sizes.height / 4.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2 * Sizes.boxSeparation),
                      topRight: Radius.circular(2 * Sizes.boxSeparation)),
                  image: const DecorationImage(
                      image: AssetImage("assets/demo/image_01.png"),
                      fit: BoxFit.cover)),
            ),
            GestureDetector(
              onTap: () {
                try {
                  print("Launchuing $whatsappLink");
                  // customLaunchUrl(whatsappLink);
                  String number = whatsappLink.split("/").last;
                  if (Platform.isIOS) {
                    customLaunchUrl(
                        "whatsapp://wa.me/$number");
                  } else {
                    customLaunchUrl(
                        "whatsapp://send?phone=$number");
                  }
                } catch (err) {
                  print("TOO FAST");
                }
              },
              child: Container(
                height: Sizes.height / 3.2 / 5,
                decoration: BoxDecoration(
                    color: const Color(0xff0077CD),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2 * Sizes.boxSeparation),
                        bottomRight: Radius.circular(2 * Sizes.boxSeparation))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: Sizes.height / 3.2 / 5 * 0.8,
                        height: Sizes.height / 3.2 / 5 * 0.8,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/whatsapp.png"),
                                fit: BoxFit.cover))),
                    const Text(
                      "WhatsApp",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2 * Sizes.boxSeparation,
            ),
            const Text("También puedes seguirnos en nuestras redes sociales",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 2 * Sizes.boxSeparation,
            ),
            FutureBuilder<BackendResponse>(
                future: API.getContact(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<SocialMedia> myMedia = snapshot.data?.myBody["Lista"]
                        .map<SocialMedia>(
                            (elem) => SocialMedia.fromBackendResponse(elem))
                        .toList();
                    SocialMedia myWhatsappMedia = myMedia
                        .lastWhere((element) => element.name == "Whatsapp");
                    whatsappLink = myWhatsappMedia.link;
                    myMedia
                        .removeWhere((element) => element.name == "Whatsapp");
                    return SizedBox(
                      height: Sizes.width / 4 * 1.2,
                      width: Sizes.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: myMedia
                              .map((e) => socialMediaButton(context, e))
                              .toList()),
                    );
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

  Widget socialMediaButton(BuildContext context, SocialMedia myMedia) {
    String name = myMedia.name;
    String label = myMedia.user;
    String url = myMedia.link;
    return GestureDetector(
      onTap: () {
        customLaunchUrl(url);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 1.5 * Sizes.boxSeparation,
        ),
        height: Sizes.width / 4 * 1.2,
        width: Sizes.width / 3.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Sizes.width / 4,
              width: Sizes.width / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/${name.toLowerCase()}.png"))),
            ),
            Text(label,
                style: const TextStyle(
                    color: Color(0xff0F62A4), fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
