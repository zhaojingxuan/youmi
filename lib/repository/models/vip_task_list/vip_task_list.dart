import 'task_item.dart';

class VipTaskList {
  List<TaskItem>? dayList;
  List<TaskItem>? toDoList;
  TaskItem? share;

  VipTaskList({this.dayList, this.toDoList, this.share});

  factory VipTaskList.fromJson(Map<String, dynamic> json) => VipTaskList(
        dayList: (json['day_list'] as List<dynamic>?)
            ?.map((e) => TaskItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        toDoList: (json['to_do_list'] as List<dynamic>?)
            ?.map((e) => TaskItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        share: json['share'] == null
            ? null
            : TaskItem.fromJson(json['share'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'day_list': dayList?.map((e) => e.toJson()).toList(),
        'to_do_list': toDoList?.map((e) => e.toJson()).toList(),
        'share': share?.toJson(),
      };
}
