import 'item_sale.dart';

class ListSale {
  List<ItemSale>? data;

  ListSale({this.data});

  factory ListSale.fromJson(Map<String, dynamic> json) => ListSale(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ItemSale.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
