class DramaDatum {
  String? dramaName;
  int? dramaId;
  String? posterUrl1;
  String? posterUrl2;
  String? posterUrl3;

  DramaDatum({
    this.dramaName,
    this.dramaId,
    this.posterUrl1,
    this.posterUrl2,
    this.posterUrl3,
  });

  factory DramaDatum.fromJson(Map<String, dynamic> json) => DramaDatum(
        dramaName: json['drama_name'] as String?,
        dramaId: json['drama_id'] as int?,
        posterUrl1: json['poster_url1'] as String?,
        posterUrl2: json['poster_url2'] as String?,
        posterUrl3: json['poster_url3'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'drama_name': dramaName,
        'drama_id': dramaId,
        'poster_url1': posterUrl1,
        'poster_url2': posterUrl2,
        'poster_url3': posterUrl3,
      };
}
