import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/presentation/cubit/cubit.dart';
import 'package:tvshow/presentation/widget/section_tvpopular.dart';
import 'package:tvshow/shared/routers.dart';

import '../../widget/widget.dart';

class MenuPopup {
  String title;
  IconData icons;
  MenuPopup(this.icons, this.title);
}

List<MenuPopup> _menuPopup = [
  MenuPopup(Icons.bookmark, "Simpanan Saya"),
  MenuPopup(Icons.logout_outlined, "Keluar"),
];

class HomePages extends StatefulWidget {
  final String? sessionID;
  HomePages({this.sessionID});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _textController.dispose();
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  _initData() => context.read<HomeCubit>().initialData(token: widget.sessionID);

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query != '') {
        context.read<HomeCubit>().changeContentModeSearch(true);
        context.read<HomeCubit>().searchMovie(query);
      } else {
        context.read<HomeCubit>().changeContentModeSearch(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.statusState == HomeStatusState.successLogout) {
          BlocProvider.of<StartedCubit>(context)
              .changeSession(SessionUser.unknown);
          Get.offAllNamed(RoutesApp.initial);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: state.isModeSearch
                    ? Container(
                        decoration: BoxDecoration(
                          color: ConstanColor.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FormfieldCustom(
                          hintText: "Silahkan cari disini...",
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          onchanged: _onSearchChanged,
                          controller: _textController,
                          autoFocust: true,
                          focusNode: _focusNode,
                        ))
                    : Text(
                        'NetFlox',
                        style: TextStyleApp.poppins.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                actions: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: state.isModeSearch ? false : true,
                        child: state.token != ''
                            ? PopupMenuButton(
                                onSelected: (MenuPopup val) {
                                  switch (val.title) {
                                    case "Keluar":
                                      context.read<HomeCubit>().doLogout();
                                      break;
                                    default:
                                  }
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: ConstanColor.white,
                                  size: 24,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return _menuPopup.map((e) {
                                    return PopupMenuItem(
                                      value: e,
                                      child:
                                          _buildIconRowText(e.icons, e.title),
                                    );
                                  }).toList();
                                },
                              )
                            : GestureDetector(
                                onTap: () {
                                  Get.toNamed(RoutesApp.login)?.then((value) {
                                    if (value != null) {
                                      context
                                          .read<HomeCubit>()
                                          .setToken(value['model']);
                                      ;
                                    }
                                  });
                                },
                                child: Text(
                                  "Masuk",
                                  style: TextStyleApp.poppins.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ConstanColor.white,
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (state.isModeSearch) {
                            _focusNode.unfocus();
                            _textController.clear();
                            context.read<HomeCubit>().changeIsModeSearch(false);
                            context
                                .read<HomeCubit>()
                                .changeContentModeSearch(false);
                          } else {
                            _focusNode.requestFocus();

                            context.read<HomeCubit>().changeIsModeSearch(true);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 14),
                          child: Icon(
                              state.isModeSearch ? Icons.close : Icons.search,
                              size: 24,
                              color: ConstanColor.white),
                        ),
                      )
                    ],
                  ),
                ],
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: ConstanColor.black,
              extendBodyBehindAppBar: state.contentModeSearch ? false : true,
              body: StackWithProgress(
                opacity: 0.4,
                isLoading: state.statusState == HomeStatusState.loadingLogout,
                children: [
                  state.contentModeSearch
                      ? SectionSearch(
                          state: state,
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            SectionTrending(sessionID: state.token),
                            SectionTvPopular(),
                          ],
                        ),
                ],
              )),
        );
      },
    );
  }

  Row _buildIconRowText(IconData icons, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icons,
          size: 18,
          color: ConstanColor.black,
        ),
        Text(
          text,
          style: TextStyleApp.poppins.copyWith(
            fontSize: 14,
            color: ConstanColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
