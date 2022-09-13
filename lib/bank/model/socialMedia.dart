
class SocialMedia {
  int id = 0;
  String name = "";
  String link = "";
  String image = "";
  String user = "";
  bool status = true;
  DateTime controlDate = DateTime.now();

  SocialMedia(id, name, link, image, user, status);

  SocialMedia.fromBackendResponse(Map<String, dynamic> response) {
    id = response["Id"] ?? 0;
    name = response["Nombre"] ?? "";
    link = response["link"] ?? "";
    image = response["Imgen"] ?? "";
    user = response["Usuario"] ?? "";
    status = response["IdEstado"] ?? false;
    controlDate = DateTime.tryParse(response["FechaControl"]) ?? DateTime.now();
  }
}

List<SocialMedia> mySocialMedia = [
  SocialMedia(1, "Facebook", "https://www.facebook.com/CredidiunsaHn/", "",
      "@credidiunsa", true),
  SocialMedia(2, "Instagram", "https://instagram.com/credidiunsa?igshid=YmMyMTA2M2Y=", "",
      "@credidiunsa", true),
];
