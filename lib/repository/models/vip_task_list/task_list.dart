class TaskList {
  String? name;
  String? image;
  int? type;
  int? number;

  TaskList({this.name, this.image, this.type, this.number});

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
        name: json['name'] as String?,
        image: json['image'] as String?,
        type: json['type'] as int?,
        number: json['number'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'type': type,
        'number': number,
      };
}
