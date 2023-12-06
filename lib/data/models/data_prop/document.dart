class PostDocument {
  String? id;
  String? fileName;
  String? fileUrl;



  PostDocument({
    this.id,
    this.fileName,
    this.fileUrl});

  factory PostDocument.fromJson(Map<String, dynamic> json) {
    return PostDocument(
      id: json['id'] ?? 'Default',
      fileName: json['fileName'] ?? 'Default',
      fileUrl: json['fileUrl'] ?? 'https://bom.so/SjYyN2',
    );
  }
  Map<String, dynamic> toJson() => {
    'fileName': fileName,
    'fileUrl': fileUrl,
  };
}