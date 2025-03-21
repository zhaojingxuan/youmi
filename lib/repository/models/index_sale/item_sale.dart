class ItemSale {
  int? dramaId;
  String? dramaName;
  int? epId;
  String? epDesc;
  String? ep;
  int? epSort;
  String? dramaUrl;
  int? like;
  int? collect;
  int? likeNumber;
  int? collectNumber;
  int? forwardNumber;

  ItemSale({
    this.dramaId,
    this.dramaName,
    this.epId,
    this.epDesc,
    this.ep,
    this.epSort,
    this.dramaUrl,
    this.like,
    this.collect,
    this.likeNumber,
    this.collectNumber,
    this.forwardNumber,
  });

  factory ItemSale.fromJson(Map<String, dynamic> json) => ItemSale(
        dramaId: json['drama_id'] as int?,
        dramaName: json['drama_name'] as String?,
        epId: json['ep_id'] as int?,
        epDesc: json['ep_desc'] as String?,
        ep: json['ep'] as String?,
        epSort: json['ep_sort'] as int?,
        dramaUrl: json['drama_url'] as String?,
        like: json['like'] as int?,
        collect: json['collect'] as int?,
        likeNumber: json['like_number'] as int?,
        collectNumber: json['collect_number'] as int?,
        forwardNumber: json['forward_number'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'drama_id': dramaId,
        'drama_name': dramaName,
        'ep_id': epId,
        'ep_desc': epDesc,
        'ep': ep,
        'ep_sort': epSort,
        'drama_url': dramaUrl,
        'like': like,
        'collect': collect,
        'like_number': likeNumber,
        'collect_number': collectNumber,
        'forward_number': forwardNumber,
      };
}
