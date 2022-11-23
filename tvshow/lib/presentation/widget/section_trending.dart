import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/presentation/widget/cached_imagenetwork_custom.dart';
import 'package:tvshow/shared/shared.dart';

import '../cubit/cubit.dart';
import 'card_movies.dart';

class SectionTrending extends StatefulWidget {
  const SectionTrending({
    this.sessionID = '',
    Key? key,
  }) : super(key: key);
  final String sessionID;

  @override
  State<SectionTrending> createState() => _SectionTrendingState();
}

class _SectionTrendingState extends State<SectionTrending> {
  ScrollController? _scrollController;
  final itemSize = 130.0;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController?.addListener(_listenerScroll);
    super.initState();
    _getTrendingHome();
  }

  _getTrendingHome() => context.read<TrendinghomeCubit>().initialTrending();

  _listenerScroll() {
    context
        .read<TrendinghomeCubit>()
        .changeIndex((_scrollController!.offset / itemSize).round() + 1);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color highlightColor = Colors.white;
    return BlocBuilder<TrendinghomeCubit, TrendinghomeState>(
      builder: (context, state) {
        return Column(
          children: [
            state.statusState == TrendingHomeStatusState.loading
                ? Shimmer.fromColors(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                    ),
                    baseColor: ConstanColor.black.withOpacity(0.3),
                    highlightColor: highlightColor,
                  )
                : Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: ConstanColor.white,
                        gradient: LinearGradient(
                          colors: [
                            ConstanColor.black.withOpacity(0.2),
                            ConstanColor.black.withOpacity(0.4),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        )),
                    child: state.models.isEmpty
                        ? Container()
                        : Stack(
                            children: [
                              NetImageOnly(
                                imageUrl: state
                                    .models[state.currentIndex].backdropPath,
                                height: 250,
                                boxfit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 140,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          state.models[state.currentIndex]
                                                      .title !=
                                                  null
                                              ? state.models[state.currentIndex]
                                                  .title
                                                  .toUpperCase()
                                              : '',
                                          textAlign: TextAlign.center,
                                          style: TextStyleApp.poppins.copyWith(
                                            fontSize: 18,
                                            color: ConstanColor.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            Formatter.year(
                                                value: state
                                                    .models[state.currentIndex]
                                                    .releaseDate),
                                            style:
                                                TextStyleApp.poppins.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: ConstanColor.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                                color: ConstanColor.orange,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                              'Lihat Detail',
                                              style:
                                                  TextStyleApp.poppins.copyWith(
                                                fontSize: 14,
                                                color: ConstanColor.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Visibility(
                                            visible: widget.sessionID != ''
                                                ? true
                                                : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<TrendinghomeCubit>()
                                                    .addWathcList(
                                                        state.models[
                                                            state.currentIndex],
                                                        !state
                                                            .models[state
                                                                .currentIndex]
                                                            .watchList);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(
                                                    color: ConstanColor.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: state.statusState ==
                                                        TrendingHomeStatusState
                                                            .loadingWatchList
                                                    ? CircularProgressIndicator()
                                                    : Text(
                                                        state
                                                                .models[state
                                                                    .currentIndex]
                                                                .watchList
                                                            ? 'Batal Simpan'
                                                            : 'Simpan',
                                                        style: TextStyleApp
                                                            .poppins
                                                            .copyWith(
                                                          fontSize: 14,
                                                          color: ConstanColor
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
            _buildListTrending(state),
          ],
        );
      },
    );
  }

  Widget _buildListTrending(TrendinghomeState state) {
    return Container(
        height: 220,
        child: state.statusState == TrendingHomeStatusState.loading
            ? Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                height: 240,
                child: ListView(
                  itemExtent: itemSize,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  children: List.generate(state.models.length, (index) {
                    return CardMovies(
                      width: state.currentIndex == index ? 140 : 130,
                      height: 220,
                      margin: state.currentIndex == index
                          ? EdgeInsets.all(0)
                          : EdgeInsets.symmetric(vertical: 10),
                      model: state.models[index],
                      isNotSelected: state.currentIndex == index ? false : true,
                    );
                  }),
                ),
              ));
  }
}
