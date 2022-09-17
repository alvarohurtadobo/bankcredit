// ignore_for_file: file_names

String convertToSecMin(int seconds) {
  int minutes = (seconds / 60).floor();
  return "${minutes.toString().padLeft(2, "0")}:${(seconds - minutes * 60).toString().padLeft(2, "0")}";
}
