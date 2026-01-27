import 'package:flutter/material.dart';
import 'package:project01/common/const/colors.dart';
import 'package:project01/restaurant/model/restaurant_detail_model.dart';
import 'package:project01/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  //가게 이미지
  final Widget image;
  //레스토랑 이름
  final String name;
  //레스토랑 테그
  final List<String> tags;
  //평점 갯수
  final int ratingsCount;
  //배송 걸리는 시간
  final int deliveryTime;
  //배송 비용
  final int deliveryFee;
  //평균 평점
  final double ratings;

  final bool isDetial;

  final String? Detial;
  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetial = false,
    this.Detial,
    super.key,
  });

  factory RestaurantCard.fromModel({

    required RestaurantModel model,
    final bool isDetail = false
}) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,),
      name:  model.name,
      tags:List<String>.from(model.tags),
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetial: isDetail,
      Detial: model is RestaurantDetailModel ?  model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(isDetial)
          image,
        if(!isDetial)
        ClipRRect(borderRadius: BorderRadius.circular(12.0), child: image),
        const SizedBox(height: 16.0),
        Padding(
          padding:EdgeInsets.symmetric(horizontal: isDetial ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                tags.join(' · '),
                style: TextStyle(color: BODY_COLOR, fontSize: 14.0),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _IconText(icon:Icons.star, label: ratings.toString()),
                  renderDot(),
                  _IconText(icon: Icons.receipt,label: ratings.toString()),
                  renderDot(),
                  _IconText(icon: Icons.timelapse_outlined,label: '${deliveryTime} 분 '),
                  renderDot(),
                  _IconText(icon: Icons.monetization_on,label: deliveryFee == 0 ? '무료' : deliveryFee.toString())
                ],
              ),
              if(isDetial != null && isDetial)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(Detial!),
                ),
            ],
          ),
        ),
      ],
    );
  }
  Widget renderDot(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text('·',
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500
       ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconText({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: PRIMARY_COLOR, size: 14.0),
        const SizedBox(height: 14.0),
        Text(
          label,
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
