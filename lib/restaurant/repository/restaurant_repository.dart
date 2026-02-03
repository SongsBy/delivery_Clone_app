import 'package:dio/dio.dart' hide Headers;
import 'package:project01/common/const/model/cursor_pagination_model.dart';
import 'package:project01/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../model/restaurant_model.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  //http://$ip/restaurant
  factory RestaurantRepository(Dio dio,{String baseUrl})
  = _RestaurantRepository;
  //
   @GET('/')//지금 요청 하는 이 부분은 baseurl + GET 요청의 path를 더한 형태가 되면 된다. 즉 따라서 //http://$ip/restaurant/의 형태를 띄게 됨
   @Headers({
     'accessToken' : 'true'
   })
   Future<CursorPagination<RestaurantModel>>paginate();
//http://$ip/restaurant/:id/ 의 형태가 되는 것과 같음
  @GET('/{id}')
  @Headers({
    'accessToken' : 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id
});
}