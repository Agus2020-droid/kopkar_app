import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SimulasiPage extends StatefulWidget {
  const SimulasiPage({Key? key}) : super(key: key);

  @override
  State<SimulasiPage> createState() => _SimulasiPageState();
}

class _SimulasiPageState extends State<SimulasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: "Simulasi Pinjaman",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
