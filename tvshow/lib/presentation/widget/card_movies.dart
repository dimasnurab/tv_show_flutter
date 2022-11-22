import 'package:flutter/material.dart';
import 'package:tvshow/presentation/widget/widget.dart';

import '../../config/config.dart';
import '../../data/models/movie_models.dart';

class CardMovies extends StatelessWidget {
  final MovieModel? model;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  final bool isNotSelected;
  const CardMovies({
    Key? key,
    this.model,
    this.height,
    required this.width,
    this.margin,
    this.isNotSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: width,
      margin: margin,
      height: height,
      decoration: BoxDecoration(
        color: ConstanColor.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [ConstanColor.kShadowBackground],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: NetImageOnly(
              height: height ?? 0,
              width: width,
              imageUrl: model?.pathPoster ?? '',
            ),
          ),
          Visibility(
            visible: isNotSelected,
            child: Container(
              height: height ?? 0,
              width: width,
              decoration: BoxDecoration(
                  color: ConstanColor.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
        ],
      ),
    );
  }
}
