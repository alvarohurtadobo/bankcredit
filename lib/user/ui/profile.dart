import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar(context),
      body: Container(
        color: Color(0xffF2F2F2),
        padding: EdgeInsets.all(Sizes.padding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Sizes.height / 8,
                width: Sizes.width,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Stack(
                    children: [
                      Container(
                        height: Sizes.height / 8,
                        width: Sizes.height / 8,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/demo/avatar.png"),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        right: 0.7 * Sizes.padding,
                        bottom: 0.7 * Sizes.padding,
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
                  Container(
                    height: Sizes.height / 8,
                    width: Sizes.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Mi Perfil",
                            style: TextStyle(
                                color: Color(0xff0F62A4),
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                        Text("Maria Camila Pérez",
                            style: TextStyle(
                                color: Color(0xff0F62A4),
                                fontWeight: FontWeight.normal,
                                fontSize: 18))
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              Container(
                width: Sizes.width,
                height: Sizes.height / 20,
                child: Row(
                  children: const [
                    Icon(
                      Icons.person,
                      color: Color(0xff0F62A4),
                    ),
                    Text("Nombre", style: TextStyle(color: Color(0xff0077cd))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(Sizes.border / 2),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Maria Camila Pérez Alarcón",
                      hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              Container(
                width: Sizes.width,
                height: Sizes.height / 20,
                child: Row(
                  children: const [
                    Icon(
                      Icons.email,
                      color: Color(0xff0F62A4),
                    ),
                    Text("Correo Electrónico",
                        style: TextStyle(color: Color(0xff0077cd))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(Sizes.border / 2),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "prueba@gmail.com",
                      hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              Container(
                width: Sizes.width,
                height: Sizes.height / 20,
                child: Row(
                  children: const [
                    Icon(
                      Icons.smartphone,
                      color: Color(0xff0F62A4),
                    ),
                    Text("Teléfono",
                        style: TextStyle(color: Color(0xff0077cd))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(Sizes.border / 2),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "987-987-567",
                      hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 0,
              )),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff0077CD),
                    borderRadius: BorderRadius.circular(Sizes.border),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/home");
                      },
                      child: const Text(
                        "Modificar Información",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )))
            ]),
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
