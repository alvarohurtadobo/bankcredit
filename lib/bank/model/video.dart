class Video {
  int id = 0;
  String link = "";
  bool status = false;
  DateTime controlDate = DateTime.now();
  String youtubeId = "";

  Video.fromBackendResponse(Map<String, dynamic> res) {
    id = res["Id"] ?? 0;
    link = res["link"] ?? "";
    status = res["IdEstado"] ?? false;
    youtubeId = "";
    try {
      if (link.contains("?v=")) {
        youtubeId = link.split("?v=").last;
      }
    } catch (err) {
      print("Could not decode Youtube URL: $link");
    }
  }
}

List<Video> myVideos = [];