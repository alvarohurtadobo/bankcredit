// ignore_for_file: unused_import, library_private_types_in_public_api
import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/widgets/appbar2.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  _PoliticsPrivacyPageState createState() => _PoliticsPrivacyPageState();
}

class _PoliticsPrivacyPageState extends State<PrivacyPage> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar2(),
      body: Container(
        color: const Color(0xffE8E8E8),
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: ListView(
          children: [
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            const Text("Política de",
                style: TextStyle(
                    color: Color(0xff0F62A4),
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            const Text("Privacidad",
                style: TextStyle(color: Color(0xff0F62A4), fontSize: 20)),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            Container(
              padding: EdgeInsets.all(2 * Sizes.boxSeparation),
              decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(2 * Sizes.boxSeparation))),
              // ignore: prefer_const_literals_to_create_immutables
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<BackendResponse>(
                        future: API.getPrivacy(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String myText = snapshot.data!.myBody["Texto"];
                            return Text(myText);
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
