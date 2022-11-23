import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/presentation/cubit/started/started_cubit.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({Key? key}) : super(key: key);

  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  @override
  void initState() {
    super.initState();
    _initTime();
  }

  _initTime() async {
    await Future.delayed(Duration(seconds: 2), () {
      BlocProvider.of<StartedCubit>(context).changeSession(SessionUser.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstanColor.black,
      body: Center(
        child: Text(
          "NetFlox",
          style: TextStyleApp.poppins.copyWith(
            fontSize: 18,
            color: ConstanColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
