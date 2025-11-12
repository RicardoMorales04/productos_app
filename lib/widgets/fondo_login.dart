import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {
  final Widget child;
  const FondoLogin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              child: Icon(Icons.person_pin, color: Colors.white, size: 100),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  //const _PurpleBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      //color: Colors.indigo,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(106, 95, 153, 1),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: _Esfera()),
          Positioned(top: -40, left: -30, child: _Esfera()),
          Positioned(top: 10, left: 90, child: _Esfera()),
          Positioned(top: 230, left: -40, child: _Esfera()),
        ],
      ),
    );
  }
}

class _Esfera extends StatelessWidget {
  //const _Esfera({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
