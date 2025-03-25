import 'youmi_banner.dart';
import 'youmi_home_module.dart';

class YoumiHomeModel {
  List<YoumiBanner>? banner;
  List<YoumiHomeModule>? modules;

  YoumiHomeModel({this.banner, this.modules});

  factory YoumiHomeModel.fromJson(Map<String, dynamic> json) {
    return YoumiHomeModel(
      banner: (json['banner'] as List<dynamic>?)
          ?.map((e) => YoumiBanner.fromJson(e as Map<String, dynamic>))
          .toList(),
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => YoumiHomeModule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'banner': banner?.map((e) => e.toJson()).toList(),
        'modules': modules?.map((e) => e.toJson()).toList(),
      };
}
