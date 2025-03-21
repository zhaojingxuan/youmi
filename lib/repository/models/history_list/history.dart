class History {
  String? payTime;
  String? payTimeMs;
  int? epId;
  int? epSort;
  int? dramaId;
  String? dramaName;
  String? dramaDesc;
  String? dramaImg;

  History({
    this.payTime,
    this.payTimeMs,
    this.epId,
    this.epSort,
    this.dramaId,
    this.dramaName,
    this.dramaDesc,
    this.dramaImg,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        payTime: json['pay_time'] as String?,
        payTimeMs: json['pay_time_ms'] as String?,
        epId: json['ep_id'] as int?,
        epSort: json['ep_sort'] as int?,
        dramaId: json['drama_id'] as int?,
        dramaName: json['drama_name'] as String?,
        dramaDesc: json['drama_desc'] as String?,
        dramaImg: json['drama_img'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'pay_time': payTime,
        'pay_time_ms': payTimeMs,
        'ep_id': epId,
        'ep_sort': epSort,
        'drama_id': dramaId,
        'drama_name': dramaName,
        'drama_desc': dramaDesc,
        'drama_img': dramaImg,
      };
}
