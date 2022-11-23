import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';

class StackWithProgress extends StatelessWidget {
  const StackWithProgress({
    Key? key,
    required List<Widget> children,
    bool isLoading = false,
    this.opacity,
  })  : _children = children,
        _isLoading = isLoading,
        super(key: key);

  final List<Widget> _children;
  final bool _isLoading;
  final double? opacity;
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      _children.add(_progressBar(context));
    }

    return Stack(
      children: _children,
    );
  }

  Widget _progressBar(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: opacity ?? 1,
          child: ModalBarrier(
            dismissible: false,
            color: Colors.white,
          ),
        ),
        Center(
          child: LoadingProggressCustom(),
        ),
      ],
    );
  }
}

class LoadingProggressCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme(
                      brightness: Brightness.dark,
                      primary: ConstanColor.white,
                      onPrimary: ConstanColor.white,
                      secondary: ConstanColor.white,
                      onSecondary: ConstanColor.white,
                      error: ConstanColor.white,
                      onError: ConstanColor.white,
                      background: ConstanColor.white,
                      onBackground: ConstanColor.white,
                      surface: ConstanColor.white,
                      onSurface: ConstanColor.white)),
              child: CircularProgressIndicator(),
            )
          : CupertinoActivityIndicator(),
    );
  }
}
