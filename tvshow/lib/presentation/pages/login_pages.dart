import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/config/constant_color.dart';
import 'package:tvshow/presentation/cubit/cubit.dart';
import 'package:tvshow/shared/routers.dart';

import '../widget/widget.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.statusState == LoginStatusState.done) {
          Get.toNamed(RoutesApp.validateToken,
              arguments: {'token': state.requestToken})?.then((value) {
            if (value != null) {
              if (value == 'success') {
                context.read<LoginCubit>().createSession(state.requestToken);
              }
            }
          });
        }
        if (state.statusState == LoginStatusState.setSessionDone) {
          BlocProvider.of<StartedCubit>(context)
              .changeSession(SessionUser.unknown);
          Get.offAllNamed(RoutesApp.initial);
        }
      },
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
                backgroundColor: ConstanColor.black,
                body: StackWithProgress(
                    isLoading: state.statusState == LoginStatusState.loaded,
                    opacity: 0.7,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "NetFlox",
                                style: TextStyleApp.poppins.copyWith(
                                  fontSize: 24,
                                  color: ConstanColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ConstanColor.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: FormfieldCustom(
                                      hintText: "Username",
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 1,
                                      controller: _usernameCtrl,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ConstanColor.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: FormfieldCustom(
                                      hintText: "Password",
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 1,
                                      controller: _passwordCtrl,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: () =>
                                        context.read<LoginCubit>().doLogin(
                                              _usernameCtrl.text,
                                              _passwordCtrl.text,
                                            ),
                                    child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: ConstanColor.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Masuk',
                                          style: TextStyleApp.poppins.copyWith(
                                            fontSize: 15,
                                            color: ConstanColor.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ])));
      },
    );
  }
}
