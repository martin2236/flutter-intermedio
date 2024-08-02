import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class GiroscopioBolaScreen extends ConsumerWidget {
  const GiroscopioBolaScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final giroscopio$ = ref.watch(acelerometroConGravedadProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('giroscopio bola screen'),
      ),
      body: SizedBox(
          height: size.height,
          width: size.width,
         child: giroscopio$.when(
          data: (value) => MovingBall(x: value.x, y: value.y),
          error: (error,stackTrace) => Text('$error'), 
          loading: () => const CircularProgressIndicator()
          )
      ),
    );
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;

  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentYPosition = (y * 100);
    double currentXPosition = (x * 100);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          left: (currentXPosition - 25) + (screenWidth / 2),
          top: (currentXPosition - 25) + (screenHeight /2) ,
          curve: Curves.easeInOut,
          duration: const Duration(microseconds: 1000),
          child: const Ball(),
          ),
        
        Text('''
 $x,
 $y
''',style: TextStyle(fontSize: 30),),
  
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(100)
      ),
    );
  }
}