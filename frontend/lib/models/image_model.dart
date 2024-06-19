class ImageModel {
  final String? filename;
  final String? url;

  ImageModel({this.filename, this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      filename: json['filename'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['url'] = url;

    return data;
  }
}
