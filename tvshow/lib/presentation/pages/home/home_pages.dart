import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/presentation/cubit/cubit.dart';

import '../../widget/widget.dart';

class HomePages extends StatefulWidget {
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
  }

  @override
  void dispose() {
    _textController.dispose();
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

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
      listener: (context, state) {},
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
                GestureDetector(
                  onTap: () {
                    if (state.isModeSearch) {
                      _focusNode.unfocus();
                      _textController.clear();
                      context.read<HomeCubit>().changeIsModeSearch(false);
                      context.read<HomeCubit>().changeContentModeSearch(false);
                    } else {
                      _focusNode.requestFocus();

                      context.read<HomeCubit>().changeIsModeSearch(true);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 14),
                    child: Icon(state.isModeSearch ? Icons.close : Icons.search,
                        size: 24, color: ConstanColor.black),
                  ),
                )
              ],
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: ConstanColor.white,
            extendBodyBehindAppBar: state.contentModeSearch ? false : true,
            body: state.contentModeSearch
                ? SectionSearch(
                    state: state,
                  )
                : ListView(
                    padding: EdgeInsets.only(),
                    children: [
                      SectionTrending(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
