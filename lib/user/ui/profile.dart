import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  StreamController myControl = StreamController<String>();

  bool isLoading = false;
  late Timer myTimer;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = currentUser.getName();
    lastNameController.text = currentUser.getLastName();
    emailController.text = currentUser.email;
    phoneController.text = currentUser.phone;
    myTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      imageCache.clear();
      // print("Click with pic url ${currentUser.pictureUrl}");
      myControl.sink.add(currentUser.pictureUrl);
      setState(() {});
    });
  }

  @override
  void dispose() {
    myTimer.cancel();
    myControl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("Building with pic url ${currentUser.pictureUrl}");
    return Scaffold(
      //  drawer: MyDrawer(),
      appBar: myAppBar(context),
      drawer: MyDrawer(),
      body: Container(
        color: const Color(0xffF2F2F2),
        padding: EdgeInsets.all(Sizes.padding),
        child: Form(
          key: formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushNamed("/updateProfilePicture");
                  },
                  child: SizedBox(
                    height: Sizes.height / 8,
                    width: Sizes.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              StreamBuilder(
                                  initialData: currentUser.pictureUrl,
                                  stream: myControl.stream,
                                  builder: (context, snapshot) {
                                    String? url = currentUser.pictureUrl;
                                    if (snapshot.hasData) {
                                      url = snapshot.data as String;
                                    }
                                    return Container(
                                      key: ValueKey(new Random().nextInt(100)),
                                      padding:
                                          EdgeInsets.all(Sizes.boxSeparation),
                                      child: Container(
                                        height: Sizes.height / 8 -
                                            2 * Sizes.boxSeparation,
                                        width: Sizes.height / 8 -
                                            2 * Sizes.boxSeparation,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    Sizes.height / 16)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  url,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                    );
                                  }),
                              Positioned(
                                right: 0.5 * Sizes.padding,
                                bottom: 0.5 * Sizes.padding,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Sizes.padding / 2))),
                                  height: Sizes.padding,
                                  width: Sizes.padding,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: Sizes.padding * 0.7,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: Sizes.padding,
                          ),
                          SizedBox(
                            height: Sizes.height / 8,
                            width: Sizes.width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Mi Perfil",
                                    style: TextStyle(
                                        color: Color(0xff0F62A4),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24)),
                                Text(currentUser.getFullName(),
                                    style: const TextStyle(
                                        color: Color(0xff0F62A4),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18))
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                newCard(context, type: 0),
                newCard(context, type: 1),
                const Expanded(
                    child: SizedBox(
                  height: 0,
                )),
              ]),
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

  Widget newCard(BuildContext context, {int type = 0}) {
    // type : 0 (email), 1 (phone)
    return GestureDetector(
      onTap: () {
        String finalRoute = type == 0 ? "/updateEmail" : "/updatePhone";
        Navigator.of(context).pushNamed(finalRoute);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Sizes.boxSeparation),
        padding: EdgeInsets.symmetric(vertical: Sizes.padding),
        // height: Sizes.height * 0.12,
        width: Sizes.width - 2 * Sizes.padding,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(Sizes.boxSeparation))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Sizes.padding,
            ),
            Icon(
              type == 0 ? Icons.email_outlined : Icons.smartphone,
              color: const Color(0xff0077CD),
            ),
            SizedBox(
              width: Sizes.boxSeparation,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type == 0 ? "Correo electrónico" : "Teléfono",
                    style: TextStyle(
                      color: const Color(0xff0077CD),
                      fontSize: Sizes.font10,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    type == 0 ? currentUser.email : currentUser.phone,
                    style: TextStyle(fontSize: Sizes.font10),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Sizes.boxSeparation,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
              width: 1.2 * Sizes.padding,
              child: Container(
                width: 1.2 * Sizes.padding,
                height: 1.2 * Sizes.padding,
                decoration: BoxDecoration(
                    color: const Color(0xff0077CD),
                    borderRadius:
                        BorderRadius.all(Radius.circular(0.6 * Sizes.padding))),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: Sizes.padding,
                ),
              ),
            ),
            SizedBox(
              width: Sizes.padding,
            ),
          ],
        ),
      ),
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
