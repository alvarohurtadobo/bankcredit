// ignore_for_file: unused_import, library_private_types_in_public_api
import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PoliticsPage extends StatefulWidget {
  const PoliticsPage({Key? key}) : super(key: key);

  @override
  _PoliticsPageState createState() => _PoliticsPageState();
}

class _PoliticsPageState extends State<PoliticsPage> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar(context),
      body: Container(
        color: const Color(0xffE8E8E8),
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: ListView(
          children: [
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            const Text("Política de",
                style: TextStyle(
                    color: Color(0xff0F62A4),
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            const Text("productos de CrediDiunsa",
                style: TextStyle(color: Color(0xff0F62A4), fontSize: 20)),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            Container(
              padding: EdgeInsets.all(2 * Sizes.boxSeparation),
              decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(2 * Sizes.boxSeparation))),
              // ignore: prefer_const_literals_to_create_immutables
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<BackendResponse>(
                        future: API.getTermsOfUse(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String myText = snapshot.data!.myBody["HTML"];
                            Widget html = Html(data: myText);
                            return html;
                          }
/*                              
   data: """<html>
 <head>
 </head>
 <body>
   <div style="font-size: 12px; line-height: 18px; white-space: pre;"><font color="#000000" style="background-color: rgb(255, 255, 254);">
 </font><p class="MsoNormal" align="center" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: center;"><b><span lang="ES-HN" style="font-size:14.0pt;line-height:107%;mso-ansi-language:
 ES-HN">POLITICA DE PRODUCTO CREDIDIUNSA </span></b><b style="text-align: justify;"><span lang="ES-HN" style="font-size:12.0pt;line-height:107%;mso-ansi-language:
 ES-HN">&nbsp;</span></b></p><font color="#000000" style="background-color: rgb(255, 255, 254);">
 </font><p class="MsoNormal" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify;"><b><span lang="ES-HN">Objetivo</span></b></p><p class="MsoNormal" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify;"><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;mso-ansi-language:ES-HN">Dar a conocer
 las características del medio de pago CrediDiunsa.</span></p><p class="MsoNormal" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify;"><b><span lang="ES-HN">Condiciones de uso</span></b></p><p class="MsoListParagraphCxSpFirst" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">CrediDiunsa es el método de pago de
 las tiendas Diunsa del tipo “Venta A Plazos” dirigido a personas naturales. </span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">Toda persona natural que ingrese su
 solicitud de habilitación del medio de pago CrediDiunsa debe pasar por el
 proceso de aprobación, cumpliendo con las políticas de otorgamiento de venta a
 plazos establecidas por Diunsa para el medio de pago.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">Al momento de ser aprobada la
 solicitud CrediDiunsa, se asigna un cupo o monto límite para que el cliente
 pueda realizar sus compras a plazos dentro de Diunsa.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">El valor de mínimo para realizar una
 compra a plazos es de L 1,500.00 para primera compra y recompra.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">Una vez habilitado el cupo para
 compras con CrediDiunsa, se podrá utilizar para adquirir a plazos cualquier
 producto de las tiendas DIUNSA a nivel nacional cumpliendo con el valor de
 compra mínima.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">Los plazos habilitados para el medio
 de pago CrediDiunsa son únicamente de 6, 12, 18, 24 y 36 meses.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">CrediDiunsa maneja el método de
 saldos revolventes por lo que puede ser utilizado en repetidas ocasiones y se
 renueva su disponible en la medida que el cliente vaya efectuando sus pagos de
 forma inmediata.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">Al momento de que un cliente de
 CrediDiunsa realiza más de una compra, se consolida su saldo (capital anterior
 + nueva compra) con la opción de mantener o cambiar el plazo de pago.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">Toda la documentación (Contrato, Plan
 de Pagos, Autorización a Centrales de Riesgo Privadas y Pagaré) derivada de
 comprar con el medio de pago CrediDiunsa, se entregara &nbsp;al cliente de forma digital por medio de un &nbsp;SMS enviado al teléfono celular brindado por
 el cliente, este mensaje contiene un link del acceso a los diferentes
 documentos, este acceso cumple con los estándares de seguridad. En caso de
 extraviar el SMS con el link, el cliente titular de la cuenta puede abocarse al
 área de Servicio al Cliente de CrediDiunsa donde le brindaran una copia o
 reenvío de los documentos. Los únicos documentos entregados en físico al
 cliente al momento de la compra serán; Copia de factura y Plan de pagos.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">Para cualquier consulta referente a
 la cuenta, están a disposición del cliente las áreas de Servicio al Cliente
 CrediDiunsa en todas nuestras tiendas a nivel nacional, o por&nbsp; WhatsApp al 504 31904365</span></p><p class="MsoListParagraphCxSpMiddle" style="text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-size: 10pt; line-height: 107%; font-family: Symbol;"><font color="#000000" style="background-color: yellow;">·</font><span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;"><font color="#000000" style=""><span style="background-color: yellow;">&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </font></span></span><!--[endif]--><span lang="ES-HN" style="background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-size: 10pt; line-height: 107%;"><font color="#000000" style="">Todas
 las ofertas exclusivas para el medio de pago CrediDiunsa son marcadas como <b style="">“Hoy o Nunca”</b>, las cuales están sujetas
 a un plazo mínimo de 12 meses, en caso de pago anticipado, el cliente deberá
 pagar el valor de la oferta general del articulo.</font></span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">Toda promoción estará sujeta a restricciones,
 las que pueden solicitarse al personal de ventas que asista la compra o las
 áreas de Servicio al Cliente de CrediDiunsa.</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">CrediDiunsa es un medio de pago, por
 lo que, en caso de tener inconvenientes con su artículo (reclamos,
 devoluciones, o similar) será atendido por el área de Servicio al Cliente <b>DIUNSA,</b> bajo los lineamientos y
 políticas establecidos en <b>DIUNSA</b>. Siempre
 y cuando la resolución no sea cancelar la compra; él cliente siempre debe
 cumplir con el pago de su cuota de acuerdo a su plan de pagos, de lo contrario
 caerá en incumplimiento de pago (mora).</span></p><p class="MsoListParagraphCxSpMiddle" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:10.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">CrediDiunsa hace uso del Sistema de
 Amortización Francés que consiste en una cuota fija durante todo el periodo
 definido al momento de la compra (plazo escogido por el cliente).</span></p><p class="MsoListParagraphCxSpLast" style="background-color: rgb(255, 255, 254); color: rgb(0, 0, 0); text-align: justify; text-indent: -18pt;"><!--[if !supportLists]--><span lang="ES-HN" style="font-size:12.0pt;line-height:107%;font-family:Symbol;mso-fareast-font-family:
 Symbol;mso-bidi-font-family:Symbol;mso-ansi-language:ES-HN">·<span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span></span><!--[endif]--><span lang="ES-HN" style="font-size:10.0pt;
 line-height:107%;mso-ansi-language:ES-HN">El cupo o monto límite aprobado para
 compras es para uso exclusivo del titular de la cuenta con CrediDiunsa, por lo
 que se recomienda utilizarlo para beneficio personal y prevenir afectaciones
 por uso de terceros.</span></p><font color="#000000" style="background-color: rgb(255, 255, 254);">
 </font></div>
 </html>""";
 );

 */

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                    // Text("POLITICA DE PRODUCTO CREDIDIUNSA",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: Sizes.font10)),
                    // const Text(""),
                    // Text("Objetivo",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: Sizes.font10)),
                    // Text(
                    //     "Dar a conocer las características del medio de pago CrediDiunsa.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // const Text(""),
                    // Text("Condiciones de uso",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: Sizes.font10)),
                    // Text(
                    //     "•	CrediDiunsa es el método de pago de las tiendas Diunsa del tipo “Venta A Plazos” dirigido a personas naturales. ",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Toda persona natural que ingrese su solicitud de habilitación del medio de pago CrediDiunsa debe pasar por el proceso de aprobación, cumpliendo con las políticas de otorgamiento de venta a plazos establecidas por Diunsa para el medio de pago.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Al momento de ser aprobada la solicitud CrediDiunsa, se asigna un cupo o monto límite para que el cliente pueda realizar sus compras a plazos dentro de Diunsa.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	El valor de mínimo para realizar una compra a plazos es de L 1,500.00 para primera compra y recompra.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Una vez habilitado el cupo para compras con CrediDiunsa, se podrá utilizar para adquirir a plazos cualquier producto de las tiendas DIUNSA a nivel nacional cumpliendo con el valor de compra mínima.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Los plazos habilitados para el medio de pago CrediDiunsa son únicamente de 6, 12, 18, 24 y 36 meses.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	CrediDiunsa maneja el método de saldos revolventes por lo que puede ser utilizado en repetidas ocasiones y se renueva su disponible en la medida que el cliente vaya efectuando sus pagos de forma inmediata.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Al momento de que un cliente de CrediDiunsa realiza más de una compra, se consolida su saldo (capital anterior + nueva compra) con la opción de mantener o cambiar el plazo de pago.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Toda la documentación (Contrato, Plan de Pagos, Autorización a Centrales de Riesgo Privadas y Pagaré) derivada de comprar con el medio de pago CrediDiunsa, se entregara  al cliente de forma digital por medio de un  SMS enviado al teléfono celular brindado por el cliente, este mensaje contiene un link del acceso a los diferentes documentos, este acceso cumple con los estándares de seguridad. En caso de extraviar el SMS con el link, el cliente titular de la cuenta puede abocarse al área de Servicio al Cliente de CrediDiunsa donde le brindaran una copia o reenvío de los documentos. Los únicos documentos entregados en físico al cliente al momento de la compra serán; Copia de factura y Plan de pagos.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Para cualquier consulta referente a la cuenta, están a disposición del cliente las áreas de Servicio al Cliente CrediDiunsa en todas nuestras tiendas a nivel nacional, o por  WhatsApp al 504 31904365",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Todas las ofertas exclusivas para el medio de pago CrediDiunsa son marcadas como “Hoy o Nunca”, las cuales están sujetas a un plazo mínimo de 12 meses, en caso de pago anticipado, el cliente deberá pagar el valor de la oferta general del articulo.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	Toda promoción estará sujeta a restricciones, las que pueden solicitarse al personal de ventas que asista la compra o las áreas de Servicio al Cliente de CrediDiunsa.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	CrediDiunsa es un medio de pago, por lo que, en caso de tener inconvenientes con su artículo (reclamos, devoluciones, o similar) será atendido por el área de Servicio al Cliente DIUNSA, bajo los lineamientos y políticas establecidos en DIUNSA. Siempre y cuando la resolución no sea cancelar la compra; él cliente siempre debe cumplir con el pago de su cuota de acuerdo a su plan de pagos, de lo contrario caerá en incumplimiento de pago (mora).",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	CrediDiunsa hace uso del Sistema de Amortización Francés que consiste en una cuota fija durante todo el periodo definido al momento de la compra (plazo escogido por el cliente).",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                    // Text(
                    //     "•	El cupo o monto límite aprobado para compras es para uso exclusivo del titular de la cuenta con CrediDiunsa, por lo que se recomienda utilizarlo para beneficio personal y prevenir afectaciones por uso de terceros.",
                    //     style: TextStyle(fontSize: Sizes.font10)),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
