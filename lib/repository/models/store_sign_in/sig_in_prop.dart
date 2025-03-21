class SigInProp {
  String? name;
  int? type;
  String? image;
  int? number;

  SigInProp({this.name, this.type, this.image, this.number});

  factory SigInProp.fromJson(Map<String, dynamic> json) => SigInProp(
        name: json['name'] as String?,
        type: json['type'] as int?,
        image: json['image'] as String?,
        number: json['number'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'image': image,
        'number': number,
      };
}
