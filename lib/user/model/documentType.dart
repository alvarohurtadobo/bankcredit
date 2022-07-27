class DocumentType {
  int id = 0;
  String name = "";

  DocumentType(this.id, this.name);
}

List<DocumentType> myDocumentTypes = [
  DocumentType(1, "Cédula de Identidad"),
  DocumentType(2, "Cédula de Residencia")
];
