import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tvshow/config/config.dart';
import 'package:shimmer/shimmer.dart';

class NetImageOnly extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit boxfit;
  final bool isGrey;
  const NetImageOnly({
    this.height = 0,
    this.width = 0,
    this.imageUrl,
    this.boxfit = BoxFit.fill,
    this.isGrey = false,
  });

  @override
  Widget build(BuildContext context) {
    int delay = 900;
    Color highlightColor = Colors.white;
    return CachedNetworkImage(
      filterQuality: FilterQuality.high,
      color: isGrey ? Colors.grey : null,
      colorBlendMode: isGrey ? BlendMode.color : null,
      alignment: Alignment.center,
      height: height,
      width: width == 0 ? double.infinity : width,
      fit: boxfit,
      imageUrl: "${ConstantApp.baseUrlImage}$imageUrl",
      placeholder: (context, url) => Shimmer.fromColors(
          period: Duration(milliseconds: delay),
          baseColor: ConstanColor.black.withOpacity(0.3),
          highlightColor: highlightColor,
          child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
              ))),
      errorWidget: (context, url, error) => Container(),
    );
  }
}
