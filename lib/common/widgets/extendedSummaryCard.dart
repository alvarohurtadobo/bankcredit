import 'package:credidiunsa_app/common/model/cuotaMensual.dart';
import 'package:credidiunsa_app/common/model/currencyFormatter.dart';
import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';

Widget extendedSummaryCard(CuotaMensual cuotaMensual,
    {Color myColor = const Color(0xff0F62A4), double scale = 1}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
    width: Sizes.width * scale,
    // height: Sizes.height / 6.2,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(2 * Sizes.boxSeparation)),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Sizes.padding,
          ),
          Text(
            "Tu cuota",
            style: TextStyle(
                color: myColor, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   height: Sizes.boxSeparation,
          // ),
          Text("mensual actual es",
              style: TextStyle(
                  color: myColor, fontSize: 21, fontWeight: FontWeight.normal)),
          SizedBox(
            height: Sizes.boxSeparation,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Sizes.boxSeparation, horizontal: 3 * Sizes.padding),
            decoration: BoxDecoration(
                color: myColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(Sizes.padding / 3))),
            child: Text(currencyFormatter.format(cuotaMensual.cuota),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5*Sizes.boxSeparation,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Intereses de mora",
          //       style: TextStyle(fontSize: Sizes.font10),
          //     ),
          //     Text(
          //       currencyFormatter.format(cuotaMensual.debtInterest),
          //       style: TextStyle(fontSize: Sizes.font10),
          //     ),
          //   ],
          // ),
          // const Divider(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Intereses corrientes",
          //       style: TextStyle(fontSize: Sizes.font10),
          //     ),
          //     Text(
          //       currencyFormatter.format(cuotaMensual.normalInterest),
          //       style: TextStyle(fontSize: Sizes.font10),
          //     ),
          //   ],
          // ),
          // const Divider(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Seguro",
          //       style: TextStyle(fontSize: Sizes.font10),
          //     ),
          //     Text(
          //       currencyFormatter.format(cuotaMensual.insurance),
          //       style: TextStyle(fontSize: Sizes.font10),
          //     ),
          //   ],
          // ),
          // const Divider(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Capital",
          //       style: TextStyle(fontSize: Sizes.font10),
          //     ),
          //     Text(
          //       currencyFormatter.format(cuotaMensual.capital),
          //       style: TextStyle(fontSize: Sizes.font10),
          //     ),
          //   ],
          // ),
          // const Divider(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Total",
          //       style: TextStyle(
          //           fontSize: Sizes.font10, color: const Color(0xff0077CD)),
          //     ),
          //     Text(
          //       currencyFormatter.format(cuotaMensual.total),
          //       style: TextStyle(
          //           fontSize: Sizes.font10, color: const Color(0xff0077CD)),
          //     ),
          //   ],
          // ),
          // const Divider(),
        ],
      ),
    ),
  );
}
