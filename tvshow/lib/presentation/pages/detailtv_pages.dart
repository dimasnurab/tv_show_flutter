import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/config/constant_color.dart';
import 'package:tvshow/data/models/movie_models.dart';
import 'package:tvshow/presentation/cubit/cubit.dart';
import 'package:tvshow/presentation/widget/cached_imagenetwork_custom.dart';
import 'package:tvshow/presentation/widget/card_movies.dart';
import 'package:tvshow/shared/shared.dart';

class DetailTvPages extends StatefulWidget {
  const DetailTvPages({Key? key}) : super(key: key);

  @override
  State<DetailTvPages> createState() => _DetailTvPagesState();
}

class _DetailTvPagesState extends State<DetailTvPages> {
  MovieModel _models = Get.arguments['model'];

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() => context.read<DetailTvCubit>().initialData(_models.id);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<DetailTvCubit, DetailTvState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ConstanColor.black,
            body: state.statusState == DetailTvStatusState.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 380,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  ConstanColor.black.withOpacity(0.3),
                                  ConstanColor.black.withOpacity(0.6),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              )),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            child: NetImageOnly(
                              height: 380,
                              width: width,
                              boxfit: BoxFit.fill,
                              imageUrl: state.detailModel.posterPath,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 24, top: 30),
                          child: RichText(
                            text: TextSpan(
                              text: state.detailModel.originalName ??
                                  state.detailModel.name ??
                                  '',
                              style: TextStyleApp.poppins.copyWith(
                                fontSize: 24,
                                color: ConstanColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                    text:
                                        '  (${Formatter.year(value: state.detailModel.firstAirDate)})',
                                    style: TextStyleApp.poppins.copyWith(
                                        fontSize: 18,
                                        color: ConstanColor.orange,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Text(
                                'Rating ${state.detailModel.average != null ? state.detailModel.average.round() : 0}',
                                style: TextStyleApp.poppins.copyWith(
                                    fontSize: 11, color: ConstanColor.white),
                              ),
                              Text(
                                ' || Suka ${state.detailModel.count != null ? state.detailModel.count.round() : 0}',
                                style: TextStyleApp.poppins.copyWith(
                                    fontSize: 11, color: ConstanColor.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 24, top: 8, bottom: 20),
                          child: Wrap(
                              runSpacing: 6,
                              spacing: 6,
                              direction: Axis.horizontal,
                              children: state.detailModel.genre
                                  .map(
                                    (e) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: ConstanColor.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        e.name ?? '',
                                        style: TextStyleApp.poppins.copyWith(
                                          fontSize: 11,
                                          color: ConstanColor.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Season',
                            style: TextStyleApp.poppins.copyWith(
                              fontSize: 18,
                              color: ConstanColor.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.detailModel.seasons.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  height: 200,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CardMovies(
                                          width: 130,
                                          height: 200,
                                          margin: EdgeInsets.only(right: 4),
                                          model: MovieModel(
                                            pathPoster: state.detailModel
                                                .seasons[index].posterPath,
                                            backdropPath: state.detailModel
                                                .seasons[index].posterPath,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 4,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
                                          decoration: BoxDecoration(
                                              color: ConstanColor.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8))),
                                          child: Text(
                                            'Season : ${state.detailModel.seasons[index].seasonNumber + 1 ?? '0'}',
                                            style:
                                                TextStyleApp.poppins.copyWith(
                                              fontSize: 12,
                                              color: ConstanColor.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
