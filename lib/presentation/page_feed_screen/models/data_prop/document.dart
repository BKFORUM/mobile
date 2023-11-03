class PostDocument {
  String id;
  String fileName;
  String fileUrl;

  PostDocument({required this.id, required this.fileName, required this.fileUrl});

  factory PostDocument.fromJson(Map<String, dynamic> json) {
    return PostDocument(
      id: json['id'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
    );
  }
}