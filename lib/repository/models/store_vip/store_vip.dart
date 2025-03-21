class StoreVip {
  int? vipId;
  String? vipName;
  String? price;
  String? originalPrice;
  String? introduce;
  int? type;
  String? storeCode;

  StoreVip({
    this.vipId,
    this.vipName,
    this.price,
    this.originalPrice,
    this.introduce,
    this.type,
    this.storeCode,
  });

  factory StoreVip.fromJson(Map<String, dynamic> json) => StoreVip(
        vipId: json['vip_id'] as int?,
        vipName: json['vip_name'] as String?,
        price: json['price'] as String?,
        originalPrice: json['original_price'] as String?,
        introduce: json['introduce'] as String?,
        type: json['type'] as int?,
        storeCode: json['store_code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'vip_id': vipId,
        'vip_name': vipName,
        'price': price,
        'original_price': originalPrice,
        'introduce': introduce,
        'type': type,
        'store_code': storeCode,
      };
}
