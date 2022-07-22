// Language: dart

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    Sizes.setSizes(_width, _height);

    return Scaffold(
      body: ListView(children: [
        Container(
          width: double.infinity,
          height: Sizes.height * 0.18,
          padding: EdgeInsets.all(Sizes.padding),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_02.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("¡Crea tu cuenta!",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("Ingresa la información",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
          color: const Color(0xfff2f2f2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3*Sizes.boxSeparation,
              ),
              Container(
                width: Sizes.width * 0.6,
                height: 40,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.cover)),
              ),
              const Text("Nombres",
                  style: TextStyle(color: Color(0xff0077cd))),
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
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              const Text("Apellidos",
                  style: TextStyle(color: Color(0xff0077cd))),
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
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              const Text("Tipo de documento",
                  style: TextStyle(color: Color(0xff0077cd))),
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
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              const Text("Número de documento",
                  style: TextStyle(color: Color(0xff0077cd))),
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
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              const Text("Correo electrónico",
                  style: TextStyle(color: Color(0xff0077cd))),
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
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              const Text("Teléfono",
                  style: TextStyle(color: Color(0xff0077cd))),
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
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              const Text("Contraseña",
                  style: TextStyle(color: Color(0xff0077cd))),
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
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ),
              const Text("Confirmar contraseña",
                  style: TextStyle(color: Color(0xff0077cd))),
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
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
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
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed("/resetPassword01");
                    },
                    child: const Text(
                        "Acepto condiciones y políticas de privacidad",
                        style: TextStyle(
                            color: Color(0xff0077cd),
                            fontSize: 14,
                            decoration: TextDecoration.underline)),
                  )
                ],
              ),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff7b8084),
                    borderRadius: BorderRadius.circular(Sizes.border),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/login");
                      },
                      child: const Text(
                        "Crear cuenta",
                        style:
                            TextStyle(color: Color(0xffb8b8b8), fontSize: 18),
                      ))),
                      SizedBox(
                height: 3*Sizes.boxSeparation,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
