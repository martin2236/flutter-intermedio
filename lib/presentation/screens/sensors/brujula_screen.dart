import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permissions/presentation/providers/providers.dart';
import 'package:permissions/presentation/screens/permissions/pedir_permisos_screen.dart';

class BrujulaScreen extends ConsumerWidget {
  const BrujulaScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

      final locationGranted = ref.watch(permissionProvider).locationGranted;
      if(!locationGranted){
        return const PedirPermisosScreen();
      }
     final compassHeading$ = ref.watch(brujulaProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('brujula screen',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        iconTheme:const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Center(child: compassHeading$.when(
          data: (heading) => Brujula(heading: heading ?? 0), 
          error: (error, stackTrace) => Text('error: $error'), 
          loading: () => const CircularProgressIndicator())),
      ),
    );
  }
}


class Brujula extends StatefulWidget {
  final double heading;
  const Brujula({super.key, required this.heading});

  @override
  State<Brujula> createState() => _BrujulaState();
}

class _BrujulaState extends State<Brujula> {

   double prevValue = 0.0;
  double turns = 0;

  double getTurns() {

    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction): direction;

    double diff = direction - prevValue;
    if(diff.abs() > 180) {

      if(prevValue > direction) {
        diff = 360 - (direction-prevValue).abs();
      } else {
        diff = 360 - (prevValue-direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Text('${widget.heading.ceil()}',style:const TextStyle(color: Colors.white,fontSize: 30),),
        const SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            alignment: Alignment.center,
            children:[
              Image.asset('assets/images/compass/quadrant-1.png'),
              // Transform.rotate(
              //   angle: (heading * (pi / 180) * -1),
              //   child: Image.asset('assets/images/compass/needle-1.png')
              //   ),

                AnimatedRotation(
                  curve: Curves.easeOut,
                  turns: getTurns(), 
                  duration: const Duration(seconds: 1),
                  child: Image.asset('assets/images/compass/needle-1.png') ,
                  )
            ]
          ),
        ),
      ],
    );
  }
}