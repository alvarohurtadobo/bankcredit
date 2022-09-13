
import 'package:credidiunsa_app/bank/model/promo.dart';
import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:flutter/material.dart';

Widget promoCard(BuildContext context, Promo myPromo) {
    print("Displaying image ${myPromo.image}");
    return GestureDetector(
      onTap: () {
        customLaunchUrl(myPromo.link);
      },
      child: Container(
        margin: EdgeInsets.only(right: Sizes.boxSeparation),
        height: Sizes.height / 5,
        width: myPromo.idType == 1 ? Sizes.width / 1.4 : Sizes.width / 2.8,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(myPromo.image), fit: BoxFit.cover)),
      ),
    );
  }