// Language: dart

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    Sizes.setSizes(_width, _height);

    return Scaffold(
        body: SafeArea(
      child: Container(
          // margin: EdgeInsets.all(0),
          // padding: EdgeInsets.all(0),
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_01.png"),
                  fit: BoxFit.cover)),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
              height: 3 * Sizes.padding,
            ),
            Container(
              width: Sizes.width * 0.8,
              height: 60,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: SizedBox(
                height: Sizes.padding,
              ),
            ),
            SizedBox(height: Sizes.boxSeparation),
            const Text("¡Bienvenido!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: Sizes.padding,
            ),
            Container(
              width: Sizes.width * 0.72,
              child: const Text(
                  "Aqui podrás gestionar todos tus tramites de tu cuenta Credidiunsa",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(
              height: 2 * Sizes.padding,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
              child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Número de documento",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Sizes.border / 2),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Escribe",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Sizes.boxSeparation),
                              focusedBorder: null,
                              disabledBorder: null),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      const Text("Contraseña",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Sizes.border / 2),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Escribe",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Sizes.boxSeparation),
                              focusedBorder: null,
                              disabledBorder: null),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                            checkColor: Colors.white,
                            focusColor: Colors.white,
                          ),
                          const Text("Recuérdame",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          const Expanded(
                              child: SizedBox(
                            width: 0,
                          )),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("/resetPassword01");
                            },
                            child: const Text("Olvidé mi contraseña",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2 * Sizes.boxSeparation,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.padding),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff7b8084),
                            borderRadius: BorderRadius.circular(Sizes.border),
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/house");
                              },
                              child: const Text(
                                "Ingresar",
                                style: TextStyle(
                                    color: Color(0xffb8b8b8), fontSize: 18),
                              )))
                    ]),
              ),
            ),
            SizedBox(
              height: 2 * Sizes.padding,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff0077cd)),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/createAccount");
                  },
                  child: const Text("No tengo cuenta, quiero crearla",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            )
          ])),
    ));
  }
}
