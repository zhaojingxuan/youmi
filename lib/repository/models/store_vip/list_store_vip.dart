import 'package:youmi/repository/models/store_vip/store_vip.dart';

class ListStoreVip {
  List<StoreVip>? data;

  ListStoreVip({this.data});

  factory ListStoreVip.fromJson(Map<String, dynamic> json) => ListStoreVip(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => StoreVip.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
