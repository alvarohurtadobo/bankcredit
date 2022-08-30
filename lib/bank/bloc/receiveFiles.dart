import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:credidiunsa_app/common/repository/api.dart';

void displayFile(BackendResponse myResponse) async {
  String base64file = myResponse.myBody["Archivo"] ?? "";
  if (base64file != "") {
    Uint8List bytes = base64.decode(base64file);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.pdf");
    print("PDF file is ${file.path}");
    await file.writeAsBytes(bytes);
    // await OpenFile.open(file.path);
    file.openRead();
  }
}
