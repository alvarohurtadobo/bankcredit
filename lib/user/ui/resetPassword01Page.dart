// Language: dart

import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:credidiunsa_app/user/model/restauration.dart';
import 'package:credidiunsa_app/user/model/user.dart';

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.all(Sizes.padding),
                child: GestureDetector(
                  onTap: () async {
                    bool confirm = true;
                    // print("Appbar back $confirm");
                    if (confirm) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 1.5 * Sizes.padding,
                    width: 1.5 * Sizes.padding,
                    decoration: BoxDecoration(
                        color: const Color(0xff0077CD),
                        borderRadius: BorderRadius.all(
                            Radius.circular(1.5 * Sizes.padding / 2))),
                    child: Icon(
                      Icons.arrow_back,
                      size: 1.5 * Sizes.padding,
                      color: Colors.white,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(Sizes.padding),
              child: const Text(
                  "Enviaremos un código por mensaje de texto al celular que tenemos registrado"),
            ),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            Column(
                children: myRestaurations
                    .map<Widget>((e) => myRestaurationTypeButton(e))
                    .toList())
          ],
        ),
      ]),
    );
  }

  Widget myRestaurationTypeButton(Restauration myRest) {
    bool loading = false;
    IconData myIcon = Icons.phone_android;
    switch (myRest.id) {
      case 1:
        myIcon = Icons.email_outlined;
        break;
      case 2:
        myIcon = Icons.phone_android;
        break;
      case 3:
        myIcon = Icons.whatsapp;
        break;
      default:
        myIcon = Icons.phone_android;
    }
    return GestureDetector(
      onTap: () {
        if (loading) {
          return;
        }
        loading = true;
        chosenRestaurationId = myRest.id;
        API
            .generateOTPOlvidePass(notLoggedDocument, chosenRestaurationId)
            .then((res) {
          loading = false;
          if (res.idError == 0) {
            Navigator.of(context).pushNamed("/resetPassword02");
          }
          if (res.idError == 1) {
            print("SHOW ERROR");
            simpleAlertDialog(context, "¡Lo sentimos!", res.message,
                buttonLabel: "Quiero ir al chat", action: () {
              customLaunchUrl("https://m.me/CredidiunsaHn");
            });
          }
        });
      },
      onLongPress: () {
        chosenRestaurationId = myRest.id;
        Navigator.of(context).pushNamed("/resetPassword02");
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Sizes.padding, vertical: Sizes.boxSeparation),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(Sizes.border / 2), //border corner radius
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
        child: ListTile(
          leading: Icon(
            myIcon,
            color: const Color(0xff0077cd),
          ),
          title: Text(
            myRest.mediumLabel,
            style: const TextStyle(color: Color(0xff0077cd)),
          ),
          subtitle: Text(myRest.destiny),
          trailing: const Icon(
            Icons.arrow_circle_right_sharp,
            color: Color(0xff0077cd),
          ),
        ),
      ),
    );
  }
}
