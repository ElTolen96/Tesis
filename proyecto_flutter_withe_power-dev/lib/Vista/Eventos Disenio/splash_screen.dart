import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';

class SplashScreenPage extends StatefulWidget {
  static final routName = 'splash';

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with AfterLayoutMixin {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    //   Auth.intance.user.then((FirebaseUser user) {
    //  if (user != null) {
    //  Navigator.pushReplacementNamed(context, HomePage.routName);
    // } else {
    Navegacion.ir_LOGIN(context);
    //  }
    //   },
    //);
  }
}
