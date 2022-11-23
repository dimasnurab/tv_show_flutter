import 'package:flutter/material.dart';
import 'package:tvshow/shared/shared.dart';

import '../../config/config.dart';
import '../cubit/cubit.dart';
import 'card_movies.dart';

class SectionSearch extends StatelessWidget {
  final HomeState state;
  const SectionSearch({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: state.statusState == HomeStatusState.loading
          ? [
              Center(
                child: CircularProgressIndicator(),
              )
            ]
          : List.generate(state.models.length, (index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  color: ConstanColor.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CardMovies(
                          width: 100,
                          height: 150,
                          model: state.models[index],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.models[index].title ?? '',
                            style: TextStyleApp.poppins.copyWith(
                              fontSize: 15,
                              color: ConstanColor.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            Formatter.ddMMMMYYYY(
                                value: state.models[index].firstAirDate),
                            style: TextStyleApp.poppins.copyWith(
                                fontSize: 11, color: ConstanColor.white),
                          ),
                          Row(
                            children: [
                              Text(
                                'Rating ${state.models[index].voteAverage != null ? state.models[index].voteAverage.round() : 0}',
                                style: TextStyleApp.poppins.copyWith(
                                    fontSize: 11, color: ConstanColor.white),
                              ),
                              Text(
                                ' || Suka ${state.models[index].voteCount != null ? state.models[index].voteCount.round() : 0}',
                                style: TextStyleApp.poppins.copyWith(
                                    fontSize: 11, color: ConstanColor.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
    );
  }
}
