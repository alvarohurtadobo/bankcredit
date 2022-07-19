// Language: dart

import 'package:sms_autofill/sms_autofill.dart';

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';

class ResetPassword02Page extends StatefulWidget {
  const ResetPassword02Page({Key? key}) : super(key: key);

  @override
  _ResetPassword02PageState createState() => _ResetPassword02PageState();
}

class _ResetPassword02PageState extends State<ResetPassword02Page> {
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
              "Por favor ingresa el código que enviamos or mensaje de texto"),
        ),
        Padding(
            padding: EdgeInsets.all(Sizes.padding),
            child: PinFieldAutoFill(
                // decoration: // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
                // currentCode: // prefill with a code
                onCodeSubmitted: (value) {
                  Navigator.of(context).pushNamed("/home");
                }, //code submitted callback
                onCodeChanged: (value) {
                  print("Current value is $value");
                }, //code changed callback
                codeLength: 4 //code length, default 6
                )),
      ]),
    );
  }
}
