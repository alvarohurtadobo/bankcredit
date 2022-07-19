import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:flutter/material.dart';

class PoliticsPage extends StatefulWidget {
  const PoliticsPage({Key? key}) : super(key: key);

  @override
  _PoliticsPageState createState() => _PoliticsPageState();
}

class _PoliticsPageState extends State<PoliticsPage> {
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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(2 * Sizes.boxSeparation))),
              // ignore: prefer_const_literals_to_create_immutables
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("POLITICA DE PRODUCTO CREDIDIUNSA",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(""),
                    Text("Objetivo",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        "Dar a conocer las características del medio de pago CrediDiunsa."),
                    Text(""),
                    Text("Condiciones de uso",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        "•	CrediDiunsa es el método de pago de las tiendas Diunsa del tipo “Venta A Plazos” dirigido a personas naturales. "),
                    Text(
                        "•	Toda persona natural que ingrese su solicitud de habilitación del medio de pago CrediDiunsa debe pasar por el proceso de aprobación, cumpliendo con las políticas de otorgamiento de venta a plazos establecidas por Diunsa para el medio de pago."),
                    Text(
                        "•	Al momento de ser aprobada la solicitud CrediDiunsa, se asigna un cupo o monto límite para que el cliente pueda realizar sus compras a plazos dentro de Diunsa."),
                    Text(
                        "•	El valor de mínimo para realizar una compra a plazos es de L 1,500.00 para primera compra y recompra."),
                    Text(
                        "•	Una vez habilitado el cupo para compras con CrediDiunsa, se podrá utilizar para adquirir a plazos cualquier producto de las tiendas DIUNSA a nivel nacional cumpliendo con el valor de compra mínima."),
                    Text(
                        "•	Los plazos habilitados para el medio de pago CrediDiunsa son únicamente de 6, 12, 18, 24 y 36 meses."),
                    Text(
                        "•	CrediDiunsa maneja el método de saldos revolventes por lo que puede ser utilizado en repetidas ocasiones y se renueva su disponible en la medida que el cliente vaya efectuando sus pagos de forma inmediata."),
                    Text(
                        "•	Al momento de que un cliente de CrediDiunsa realiza más de una compra, se consolida su saldo (capital anterior + nueva compra) con la opción de mantener o cambiar el plazo de pago."),
                    Text(
                        "•	Toda la documentación (Contrato, Plan de Pagos, Autorización a Centrales de Riesgo Privadas y Pagaré) derivada de comprar con el medio de pago CrediDiunsa, se entregara  al cliente de forma digital por medio de un  SMS enviado al teléfono celular brindado por el cliente, este mensaje contiene un link del acceso a los diferentes documentos, este acceso cumple con los estándares de seguridad. En caso de extraviar el SMS con el link, el cliente titular de la cuenta puede abocarse al área de Servicio al Cliente de CrediDiunsa donde le brindaran una copia o reenvío de los documentos. Los únicos documentos entregados en físico al cliente al momento de la compra serán; Copia de factura y Plan de pagos."),
                    Text(
                        "•	Para cualquier consulta referente a la cuenta, están a disposición del cliente las áreas de Servicio al Cliente CrediDiunsa en todas nuestras tiendas a nivel nacional, o por  WhatsApp al 504 31904365"),
                    Text(
                        "•	Todas las ofertas exclusivas para el medio de pago CrediDiunsa son marcadas como “Hoy o Nunca”, las cuales están sujetas a un plazo mínimo de 12 meses, en caso de pago anticipado, el cliente deberá pagar el valor de la oferta general del articulo."),
                    Text(
                        "•	Toda promoción estará sujeta a restricciones, las que pueden solicitarse al personal de ventas que asista la compra o las áreas de Servicio al Cliente de CrediDiunsa."),
                    Text(
                        "•	CrediDiunsa es un medio de pago, por lo que, en caso de tener inconvenientes con su artículo (reclamos, devoluciones, o similar) será atendido por el área de Servicio al Cliente DIUNSA, bajo los lineamientos y políticas establecidos en DIUNSA. Siempre y cuando la resolución no sea cancelar la compra; él cliente siempre debe cumplir con el pago de su cuota de acuerdo a su plan de pagos, de lo contrario caerá en incumplimiento de pago (mora)."),
                    Text(
                        "•	CrediDiunsa hace uso del Sistema de Amortización Francés que consiste en una cuota fija durante todo el periodo definido al momento de la compra (plazo escogido por el cliente)."),
                    Text(
                        "•	El cupo o monto límite aprobado para compras es para uso exclusivo del titular de la cuenta con CrediDiunsa, por lo que se recomienda utilizarlo para beneficio personal y prevenir afectaciones por uso de terceros."),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
