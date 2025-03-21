class YoumiBanner {
  String? bannerImage;
  int? dramaId;

  YoumiBanner({this.bannerImage, this.dramaId});

  factory YoumiBanner.fromJson(Map<String, dynamic> json) => YoumiBanner(
        bannerImage: json['banner_image'] as String?,
        dramaId: json['drama_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'banner_image': bannerImage,
        'drama_id': dramaId,
      };
}
