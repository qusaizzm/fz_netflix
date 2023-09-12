import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fz_netflix/core/strings.dart';
import 'package:fz_netflix/presentation/main_page/screen_main_page.dart';

import '../../application/Home/home_bloc.dart';
import '../../application/downloads/downloads_bloc.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotoMainPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreendata());
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ScreenMainPage()));
          },
          child: Image.asset(imageLogo1), //   <--- image
        ),
      ),
    );
  }

  Future<void> gotoMainPage() async {
    Timer(
      const Duration(milliseconds: 8500),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenMainPage(),
        ),
      ),
    );
    // Future.delayed(const Duration(seconds: 3));
    //   Navigator.of(context).push(
    //               MaterialPageRoute(builder: (context) => ScreenMainPage()));
  }
}
