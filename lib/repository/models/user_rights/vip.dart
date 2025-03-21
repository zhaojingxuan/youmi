class Vip {
  int? type;
  String? introduce;
  String? endMs;

  Vip({this.type, this.introduce, this.endMs});

  factory Vip.fromJson(Map<String, dynamic> json) => Vip(
        type: json['type'] as int?,
        introduce: json['introduce'] as String?,
        endMs: json['end_ms'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'introduce': introduce,
        'end_ms': endMs,
      };
}
