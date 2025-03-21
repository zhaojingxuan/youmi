import 'task_list.dart';

class TaskItem {
  int? id;
  String? taskName;
  String? taskDesc;
  int? taskNumber;
  int? taskActivity;
  int? states;
  int? number;
  List<TaskList>? list;

  TaskItem({
    this.id,
    this.taskName,
    this.taskDesc,
    this.taskNumber,
    this.taskActivity,
    this.states,
    this.number,
    this.list,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
      id: json['id'] as int?,
      taskName: json['task_name'] as String?,
      taskDesc: json['task_desc'] as String?,
      taskNumber: json['task_number'] as int?,
      taskActivity: json['task_activity'] as int?,
      states: json['states'] as int?,
      number: json['number'] as int?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => TaskList.fromJson(e as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toJson() => {
        'id': id,
        'task_name': taskName,
        'task_desc': taskDesc,
        'task_number': taskNumber,
        'task_activity': taskActivity,
        'states': states,
        'number': number,
        'list': list?.map((e) => e.toJson()).toList(),
      };
}
