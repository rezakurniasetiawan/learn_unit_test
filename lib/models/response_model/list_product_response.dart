import 'dart:convert';

import 'package:learn_unit_test/models/models/product_model.dart';

ListProductResponse listProductResponseFromJson(String str) => ListProductResponse.fromJson(json.decode(str));

String listProductResponseToJson(ListProductResponse data) => json.encode(data.toJson());

class ListProductResponse {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ListProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ListProductResponse.fromJson(Map<String, dynamic> json) => ListProductResponse(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}
