import 'package:intl/intl.dart';

var currencyFormatter = NumberFormat.currency(
    locale: "en_US", symbol: "L", customPattern: "\$#,###,###,##0.0#");

var numberFormatter = NumberFormat("#,###,###,##0.#");
var doubleFormatter = NumberFormat("#,###,###,##0.00");
