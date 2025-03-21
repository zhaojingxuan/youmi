class ModuleListItemModel {
  int? dramaId;
  String? dramaName;
  String? dramaDesc;
  String? posterUrl1;
  String? posterUrl2;
  String? posterUrl3;

  ModuleListItemModel({
    this.dramaId,
    this.dramaName,
    this.dramaDesc,
    this.posterUrl1,
    this.posterUrl2,
    this.posterUrl3,
  });

  factory ModuleListItemModel.fromJson(Map<String, dynamic> json) =>
      ModuleListItemModel(
        dramaId: json['drama_id'] as int?,
        dramaName: json['drama_name'] as String?,
        dramaDesc: json['drama_desc'] as String?,
        posterUrl1: json['poster_url1'] as String?,
        posterUrl2: json['poster_url2'] as String?,
        posterUrl3: json['poster_url3'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'drama_id': dramaId,
        'drama_name': dramaName,
        'drama_desc': dramaDesc,
        'poster_url1': posterUrl1,
        'poster_url2': posterUrl2,
        'poster_url3': posterUrl3,
      };
}
