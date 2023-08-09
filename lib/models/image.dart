class ImageApi {
  final String url;

  const ImageApi({
    required this.url,
  });

  factory ImageApi.fromJson(Map<String, dynamic> json) {
    return ImageApi(
      url: json['url'],
    );
  }
}
