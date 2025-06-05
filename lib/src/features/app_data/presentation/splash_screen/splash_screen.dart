import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:widam/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    StatusBarControl.setFullscreen(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Assets.splash.splash.image(
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );
  }

  @override
  void dispose() {
    StatusBarControl.setFullscreen(false);
    super.dispose();
  }
}
