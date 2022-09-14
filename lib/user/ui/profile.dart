import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/model/sesion.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';

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

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = currentUser.getName();
    lastNameController.text = currentUser.getLastName();
    emailController.text = currentUser.email;
    phoneController.text = currentUser.phone;
  }

  @override
  void dispose() {
    myControl.close();
    updatedEmail = false;
    updatedPhone = false;
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
                    Navigator.of(context)
                        .pushNamed("/updateProfilePicture")
                        .then((_) => setState(() {}));
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
                                            image: pathToRecentlyUpdatedImage ==
                                                    ""
                                                ? DecorationImage(
                                                    image: NetworkImage(url),
                                                    fit: BoxFit.cover)
                                                : DecorationImage(
                                                    image: FileImage(File(
                                                        pathToRecentlyUpdatedImage)),
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
                (updatedEmail || updatedPhone)
                    ? successUpdateTile()
                    : Container(),
                (updatedEmail || updatedPhone)
                    ? SizedBox(
                        height: 3 * Sizes.boxSeparation,
                      )
                    : Container(),
                ((updatedEmail && !updatedPhone) ||
                        !updatedEmail && updatedPhone)
                    ? Text(
                        "¿Quieres actualizar otro dato de contacto?",
                        style: TextStyle(
                            color: const Color(0xff201F1F),
                            fontSize: Sizes.font10),
                      )
                    : Container(),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                updatedEmail ? Container() : newCard(context, type: 0),
                updatedPhone ? Container() : newCard(context, type: 1),
                const Expanded(
                    child: SizedBox(
                  height: 0,
                )),
                (updatedEmail || updatedPhone)
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.padding),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff0077CD),
                          borderRadius: BorderRadius.circular(Sizes.border),
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Volver al inicio",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )))
                    : Container(),
              ]),
        ),
      ),
    );
  }

  Widget successUpdateTile() {
    return Container(
      height: Sizes.tileHeightLarge,
      width: Sizes.width - 2 * Sizes.padding,
      padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(1.5 * Sizes.boxSeparation),
          ),
          color: const Color(0xff5BC36C)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (Sizes.width - 4 * Sizes.padding) * 0.85,
            child: Text(
              "Tu dato de contacto ha sido modificado con éxito.",
              style: TextStyle(color: Colors.white, fontSize: Sizes.font10),
            ),
          ),
          Container(
              height: 1.6 * Sizes.padding,
              width: 1.6 * Sizes.padding,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.padding * 0.8),
                  ),
                  color: Colors.white),
              child: Icon(
                Icons.check,
                size: Sizes.padding,
                color: const Color(0xff5BC36C),
              ))
        ],
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
        Navigator.of(context)
            .pushNamed(finalRoute)
            .then((value) => {setState(() {})});
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
