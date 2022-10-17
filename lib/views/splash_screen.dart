import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/views/login_page.dart';
import 'package:kopkar_japernosa/views/main/transaction/home_page.dart';
import 'package:kopkar_japernosa/views/main_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    });
    return Scaffold(
      backgroundColor: R.colors.primary,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "KOPKAR ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            Text(
              "Japernosa",
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
