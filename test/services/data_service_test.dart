// test/services/auth_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:learn_unit_test/models/models/dimensions_model.dart';
import 'package:learn_unit_test/models/models/meta_model.dart';
import 'package:learn_unit_test/models/models/product_model.dart';
import 'package:learn_unit_test/models/models/review_model.dart';
import 'package:learn_unit_test/models/response_model/list_product_response.dart';
import 'package:learn_unit_test/services/data_service.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import '../mocks/auth_service_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late DataService dataService;

  setUp(() {
    mockDio = MockDio();
    dataService = DataServiceImpl(mockDio);
  });
  test('should return a list of data when API call is successful', () async {
    // Arrange
    String uri = 'https://dummyjson.com/products?limit=1';
    final ListProductResponse mockReposponseProduct = ListProductResponse(
      products: [
        Product(
          id: 1,
          title: "Essence Mascara Lash Princess",
          description:
              "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
          category: "beauty",
          price: 9.99,
          discountPercentage: 7.17,
          rating: 4.94,
          stock: 5,
          tags: [
            "beauty",
            "mascara",
          ],
          brand: "Essence",
          sku: "RCH45Q1A",
          weight: 2,
          dimensions: Dimensions(
            width: 23.17,
            height: 14.43,
            depth: 28.01,
          ),
          warrantyInformation: "1 month warranty",
          shippingInformation: "Ships in 1 month",
          availabilityStatus: "Low Stock",
          reviews: [
            Review(
              rating: 2,
              comment: "Very unhappy with my purchase!",
              date: DateTime.parse("2024-05-23T08:56:21.618Z"),
              reviewerName: "John Doe",
              reviewerEmail: "john.doe@x.dummyjson.com",
            ),
            Review(
              rating: 2,
              comment: "Not as described!",
              date: DateTime.parse("2024-05-23T08:56:21.618Z"),
              reviewerName: "Nolan Gonzalez",
              reviewerEmail: "nolan.gonzalez@x.dummyjson.com",
            ),
            Review(
              rating: 5,
              comment: "Very satisfied!",
              date: DateTime.parse("2024-05-23T08:56:21.618Z"),
              reviewerName: "Scarlett Wright",
              reviewerEmail: "scarlett.wright@x.dummyjson.com",
            ),
          ],
          returnPolicy: "30 days return policy",
          minimumOrderQuantity: 24,
          meta: Meta(
            createdAt: DateTime.parse("2024-05-23T08:56:21.618Z"),
            updatedAt: DateTime.parse("2024-05-23T08:56:21.618Z"),
            barcode: "9164035109868",
            qrCode: "https://assets.dummyjson.com/public/qr-code.png",
          ),
          images: ["https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"],
          thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png",
        ),
      ],
      total: 194,
      skip: 0,
      limit: 1,
    );

    when(mockDio.get(uri)).thenAnswer(
      (_) async => Response(
        data: {
          "products": [
            {
              "id": 1,
              "title": "Essence Mascara Lash Princess",
              "description":
                  "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
              "category": "beauty",
              "price": 9.99,
              "discountPercentage": 7.17,
              "rating": 4.94,
              "stock": 5,
              "tags": ["beauty", "mascara"],
              "brand": "Essence",
              "sku": "RCH45Q1A",
              "weight": 2,
              "dimensions": {"width": 23.17, "height": 14.43, "depth": 28.01},
              "warrantyInformation": "1 month warranty",
              "shippingInformation": "Ships in 1 month",
              "availabilityStatus": "Low Stock",
              "reviews": [
                {
                  "rating": 2,
                  "comment": "Very unhappy with my purchase!",
                  "date": "2024-05-23T08:56:21.618Z",
                  "reviewerName": "John Doe",
                  "reviewerEmail": "john.doe@x.dummyjson.com"
                },
                {
                  "rating": 2,
                  "comment": "Not as described!",
                  "date": "2024-05-23T08:56:21.618Z",
                  "reviewerName": "Nolan Gonzalez",
                  "reviewerEmail": "nolan.gonzalez@x.dummyjson.com"
                },
                {
                  "rating": 5,
                  "comment": "Very satisfied!",
                  "date": "2024-05-23T08:56:21.618Z",
                  "reviewerName": "Scarlett Wright",
                  "reviewerEmail": "scarlett.wright@x.dummyjson.com"
                }
              ],
              "returnPolicy": "30 days return policy",
              "minimumOrderQuantity": 24,
              "meta": {
                "createdAt": "2024-05-23T08:56:21.618Z",
                "updatedAt": "2024-05-23T08:56:21.618Z",
                "barcode": "9164035109868",
                "qrCode": "https://assets.dummyjson.com/public/qr-code.png"
              },
              "images": ["https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"],
              "thumbnail": "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png"
            }
          ],
          "total": 194,
          "skip": 0,
          "limit": 1,
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: uri),
      ),
    );

    // Act
    final result = await dataService.getData();

    // Assert
    expect(result, mockReposponseProduct.products);
    verify(mockDio.get(uri)).called(1);
  });

  test('should throw exception when API call fails', () async {
    // Arrange
    String uri = 'https://dummyjson.com/products?limit=1';
    when(mockDio.get(uri)).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: uri),
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: ''),
        ),
        error: 'Server Error',
      ),
    );

    // Act & Assert
    expect(() => dataService.getData(), throwsException);
    verify(mockDio.get(uri)).called(1);
  });
}
