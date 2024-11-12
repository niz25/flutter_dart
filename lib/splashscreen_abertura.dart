import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:splashscreen/index.dart';
import 'package:sysale/bemvindos.dart';

void main() {
  runApp(MaterialApp(
    home: MySplashScreen(),
  ));
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late List<Animation<double>> _letterAnimations;
  late List<double> _offsets;

  @override
  void initState() 
  {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController
    (
      vsync: this,
      // ajusta a duração total da animação
      duration: Duration(seconds: 3), 
    );

    _letterAnimations = List.generate
    (
      // número de letras no texto 'Carregando...'
      13, 
      (index) => CurvedAnimation
      (
        parent: _controller,
        curve: Interval
        (
          index / 13.0,
          (index + 1) / 13.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _offsets = List.generate
    (
      // número de letras no texto 'Carregando...'
      13, 
      // valor inicial dos deslocamentos das letras
      (index) => 0.0, 
    );

    _controller.repeat(reverse: true);
    _controller.addListener(() 
    {
      setState(() {
        for (int i = 0; i < _letterAnimations.length; i++) 
        {
          _offsets[i] = _waveOffset(_controller.value, i);
        }
      });
    });

    Future.delayed(Duration(seconds: 3), () 
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyFirstPage()));
    });
  }

  double _waveOffset(double controllerValue, int index) 
  {
    const double waveFrequency = 6.0; 
    const double waveAmplitude = 1.5; 
    const double speedScale = 1.6;

    // calcula um atraso baseado na posição da letra e no valor do controlador
    double waveDelay = math.sin(controllerValue * 2 * math.pi * waveFrequency + index) * waveAmplitude * speedScale;

    return waveDelay;
  }

  @override
  void dispose() 
  {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body: Container
      (
        width: double.infinity,
        decoration: BoxDecoration
        (
          color: Color.fromARGB(255, 160, 205, 207),
        ),
        child: Center
        (
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              Text('SYSALE', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, fontFamily: "TAN Nimbus", color: Color(0xFFE9F1F1),),),

              Text("Sistemas de Vendas", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "TAN Nimbus", color: Color(0xFFE9F1F1),),),

              SizedBox(height: 10),

              Image.asset('assets/images/loading.png', width: 300,),

              SizedBox(height: 20),

              AnimatedBuilder
              (
                animation: _controller,
                builder: (context, child) 
                {
                  return Row
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: 
                    [
                      for (int i = 0; i < _letterAnimations.length; i++)
                        Transform.translate
                        (
                          offset: Offset
                          (
                            0.0,
                            _offsets[i],
                          ),
                          child: Text('Carregando... '[i], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "TAN Nimbus", color: Color(0xFFE9F1F1),),),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
