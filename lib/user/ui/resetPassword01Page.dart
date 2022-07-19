// Language: dart

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';

class ResetPassword01Page extends StatefulWidget {
  const ResetPassword01Page({Key? key}) : super(key: key);

  @override
  _ResetPassword01PageState createState() => _ResetPassword01PageState();
}

class _ResetPassword01PageState extends State<ResetPassword01Page> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    Sizes.setSizes(_width, _height);

    return Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          height: Sizes.height * 0.18,
          padding: EdgeInsets.all(Sizes.padding),
          decoration: BoxDecoration(
              color: const Color(0xff0077cd),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.border),
                  bottomRight: Radius.circular(Sizes.border))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Restablecer",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("tus credenciales de ingreso",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
        SizedBox(
          height: Sizes.boxSeparation,
        ),
        Padding(
          padding: EdgeInsets.all(Sizes.padding),
          child: const Text(
              "Enviaremos un código por mensaje de texto al celular que tenemos registrado"),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/resetPassword02");
          },
          child: Container(
            margin: EdgeInsets.all(Sizes.padding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  Sizes.border / 2), //border corner radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: const Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
                //you can set more BoxShadow() here
              ],
            ),
            child: const ListTile(
              leading: Icon(
                Icons.phone_android,
                color: Color(0xff0077cd),
              ),
              title: Text(
                "Mensaje de Texto",
                style: TextStyle(color: Color(0xff0077cd)),
              ),
              subtitle: Text("******56"),
              trailing: Icon(
                Icons.arrow_circle_right_sharp,
                color: Color(0xff0077cd),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
