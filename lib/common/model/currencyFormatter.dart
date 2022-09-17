// ignore_for_file: file_names
import 'package:intl/intl.dart';

var currencyFormatter = NumberFormat.currency(
    locale: "en_US", symbol: "L", customPattern: "L#,###,###,##0.0#");

var numberFormatter = NumberFormat("#,###,###,##0.#");
var doubleFormatter = NumberFormat("#,###,###,##0.00");
