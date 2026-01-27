import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:project01/restaurant/model/restaurant_model.dart';

import '../../common/const/data.dart';
import '../../common/utils/data_utils.dart';
part 'restaurant_detail_model.g.dart';


@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel{
  final String detail;
  final List<RestaurantProductModel>products;
  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
});

  
  factory RestaurantDetailModel.fromJson(Map<String , dynamic> json)
  => _$RestaurantDetailModelFromJson(json);



//   factory RestaurantDetailModel.fromJson({
//     required Map<String , dynamic> json,
// }){
//     return RestaurantDetailModel
//       (id: json['id'],
//         name: json['name'],
//         thumbUrl:  'http://$ip${json['thumbUrl']}',
//         tags: List<String>.from(json['tags']),
//         priceRange: RestaurantPriceRage.values.firstWhere((e) =>
//         e.name == json['priceRange']),
//         ratings: (json['ratings']as num?)?.toDouble() ?? 0.0,
//         ratingsCount: json['ratingsCount'] ?? 0,
//         deliveryTime: json['deliveryTime'] ?? 0,
//         deliveryFee: json['deliveryFee'] ?? 0,
//         detail: json['detail'],
//         products: json['products'].map<RestaurantProductModel>(
//             (x) => RestaurantProductModel.fromJson(
//               json: x,
//
//             )
//         ).toList()
//     );
//   }

}

@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price
  });


  factory RestaurantProductModel.fromJson(Map<String , dynamic> json)
  => _$RestaurantProductModelFromJson(json);

//   factory RestaurantProductModel.fromJson({
//     required Map<String, dynamic> json,
// }) {
//       return RestaurantProductModel(
//           id: json['id'],
//           name: json['name'],
//           imgUrl:'http://$ip${json['imgUrl']}',
//           detail: json['detail'],
//           price: json['price']
//       );
//   }

}