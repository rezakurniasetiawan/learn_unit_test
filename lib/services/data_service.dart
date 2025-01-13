// lib/services/auth_service.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:learn_unit_test/models/models/product_model.dart';
import 'package:learn_unit_test/models/response_model/list_product_response.dart';

abstract class DataService {
  Future<List<Product>> getData();
}

class DataServiceImpl implements DataService {
  final Dio dio;

  DataServiceImpl(this.dio);

  @override
  Future<List<Product>> getData() async {
    final response = await dio.get('https://dummyjson.com/products?limit=1');
    if (response.statusCode == 200) {
      log('Walawwee Data fetched successfully');
      return ListProductResponse.fromJson(response.data).products;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
