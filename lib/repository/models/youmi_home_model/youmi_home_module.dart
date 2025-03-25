import 'module_list_item_model.dart';

class YoumiHomeModule {
  int? id;
  String? moduleTitle;
  String? icon;
  int? store;
  int? type;
  List<ModuleListItemModel>? list;

  YoumiHomeModule({
    this.id,
    this.moduleTitle,
    this.icon,
    this.store,
    this.type,
    this.list,
  });

  factory YoumiHomeModule.fromJson(Map<String, dynamic> json) =>
      YoumiHomeModule(
        id: json['id'] as int?,
        moduleTitle: json['module_title'] as String?,
        icon: json['icon'] as String?,
        store: json['store'] as int?,
        type: json['type'] as int?,
        list: (json['list'] as List<dynamic>?)
            ?.where((element) => element != null)
            .map((e) => ModuleListItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'module_title': moduleTitle,
        'icon': icon,
        'store': store,
        'type': type,
        'list': list?.map((e) => e.toJson()).toList(),
      };
}
