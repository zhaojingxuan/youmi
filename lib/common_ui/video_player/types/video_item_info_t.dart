import 'package:copy_with_extension/copy_with_extension.dart';

part 'video_item_info_t.g.dart';
// flutter pub run build_runner build

@CopyWith(copyWithNull: true)
class VideoItemInfoT {
  final String picUrl;
  final String? heroKeyTag;
  final bool? forHero;
  final int? dramaId;
  final int? epId;
  final String? dramaName;
  final String? desc;
  String? src;
  final int? like;
  final int? collect;
  final int? likeNumber;
  final int? collectNumber;
  final int? forwardNumber;
  final int? index;
  int? locking;

  VideoItemInfoT({
    required this.picUrl,
    this.heroKeyTag,
    this.forHero,
    this.dramaId,
    this.epId,
    this.dramaName,
    this.desc,
    this.src,
    this.like,
    this.collect,
    this.likeNumber,
    this.collectNumber,
    this.forwardNumber,
    this.locking,
    this.index,
  });

  // 重写 == 运算符
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // 检查是否是同一个对象
    return other is VideoItemInfoT &&
        other.picUrl == picUrl &&
        other.heroKeyTag == heroKeyTag &&
        other.forHero == forHero &&
        other.dramaId == dramaId &&
        other.epId == epId &&
        other.dramaName == dramaName &&
        other.desc == desc &&
        other.src == src &&
        other.like == like &&
        other.collect == collect &&
        other.likeNumber == likeNumber &&
        other.collectNumber == collectNumber &&
        other.forwardNumber == forwardNumber &&
        other.index == index &&
        other.locking == locking;
  }

  // 重写 hashCode（必须与 == 一致）
  @override
  int get hashCode =>
      picUrl.hashCode ^
      heroKeyTag.hashCode ^
      forHero.hashCode ^
      dramaId.hashCode ^
      epId.hashCode ^
      dramaName.hashCode ^
      desc.hashCode ^
      src.hashCode ^
      like.hashCode ^
      collect.hashCode ^
      likeNumber.hashCode ^
      collectNumber.hashCode ^
      forwardNumber.hashCode ^
      index.hashCode ^
      locking.hashCode;
}
