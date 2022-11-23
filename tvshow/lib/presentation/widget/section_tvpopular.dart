import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tvshow/presentation/cubit/cubit.dart';
import 'package:tvshow/presentation/widget/card_movies.dart';
import 'package:tvshow/shared/shared.dart';

import '../../config/config.dart';

class SectionTvPopular extends StatefulWidget {
  const SectionTvPopular({Key? key}) : super(key: key);

  @override
  State<SectionTvPopular> createState() => _SectionTvPopularState();
}

class _SectionTvPopularState extends State<SectionTvPopular> {
  RefreshController _controller = RefreshController();

  @override
  void initState() {
    super.initState();
    _getInitData();
  }

  _getInitData() => context.read<TvpopularCubit>().getInitialData();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TvpopularCubit, TvpopularState>(
      listener: (context, state) {
        _controller.loadComplete();
      },
      child: BlocBuilder<TvpopularCubit, TvpopularState>(
        builder: (context, state) {
          return Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 24, top: 20),
                  child: Text(
                    'TV Show',
                    style: TextStyleApp.poppins.copyWith(
                      fontSize: 18,
                      color: ConstanColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: SmartRefresher(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    enablePullDown: false,
                    enablePullUp: true,
                    onLoading: () =>
                        context.read<TvpopularCubit>().infinitLoaded(),
                    child: ListView.builder(
                        itemCount: state.models.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () =>
                                Get.toNamed(RoutesApp.detailTv, arguments: {
                              'model': state.models[index],
                            }),
                            child: Container(
                              height: 200,
                              width: 130,
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: ConstanColor.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CardMovies(
                                      width: 130,
                                      height: 120,
                                      model: state.models[index],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    state.models[index].title ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleApp.poppins.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: ConstanColor.black,
                                    ),
                                  ),
                                  Text(
                                    Formatter.year(
                                        value:
                                            state.models[index].firstAirDate),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleApp.poppins.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: ConstanColor.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
