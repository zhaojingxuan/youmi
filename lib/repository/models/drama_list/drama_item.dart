class DramaItem {
  int? epId;
  int? dramaId;
  String? ep;
  String? epDuation;
  dynamic epDesc;
  String? coverUrl;
  int? locking;
  int? sort;
  int? likeNumber;
  int? collectNumber;
  int? forwardNumber;
  int? like;
  int? collect;
  int? epLocking;

  DramaItem({
    this.epId,
    this.dramaId,
    this.ep,
    this.epDuation,
    this.epDesc,
    this.coverUrl,
    this.locking,
    this.sort,
    this.likeNumber,
    this.collectNumber,
    this.forwardNumber,
    this.like,
    this.collect,
    this.epLocking,
  });

  factory DramaItem.fromJson(Map<String, dynamic> json) => DramaItem(
        epId: json['ep_id'] as int?,
        dramaId: json['drama_id'] as int?,
        ep: json['ep'] as String?,
        epDuation: json['ep_duation'] as String?,
        epDesc: json['ep_desc'] as dynamic,
        coverUrl: json['cover_url'] as String?,
        locking: json['locking'] as int?,
        sort: json['sort'] as int?,
        likeNumber: json['like_number'] as int?,
        collectNumber: json['collect_number'] as int?,
        forwardNumber: json['forward_number'] as int?,
        like: json['like'] as int?,
        collect: json['collect'] as int?,
        epLocking: json['ep_locking'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'ep_id': epId,
        'drama_id': dramaId,
        'ep': ep,
        'ep_duation': epDuation,
        'ep_desc': epDesc,
        'cover_url': coverUrl,
        'locking': locking,
        'sort': sort,
        'like_number': likeNumber,
        'collect_number': collectNumber,
        'forward_number': forwardNumber,
        'like': like,
        'collect': collect,
        'ep_locking': epLocking,
      };
}
