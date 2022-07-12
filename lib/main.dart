import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  bool visible = false;
  bool visiblecircle1 = false;
  bool visiblecircle2 = false;
  Timer? timer;
  double height = 80;
  double width = 80;
  double widthCirclre11 = 0;
  double widthCirclre21 = 0;
  double widthCirclre12 = 0;
  double widthCirclre22 = 0;
  double heightCirclre11 = 0;
  double heightCirclre21 = 0;
  double heightCirclre12 = 0;
  double heightCirclre22 = 0;
  Color colorCircle11 = Colors.black.withOpacity(0.2);
  Color colorCircle12 = Colors.black.withOpacity(0.5);
  Color colorCircle21 = Colors.black.withOpacity(0.5);
  Color colorCircle22 = Colors.black.withOpacity(0.5);

  @override
  void initState() {
    print("start " + DateTime.now().toString());
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller!.reset();
    _controller!.forward();
    changeWidthAndHeight();
    showFirstCircle1();
    showFirstCircle2();
    changeVisibleText();
    changeColorleCircle11();
    showSecondCircle1();
    showSecondCircle2();
    changeColorleCircle12();
    changeColorleCircle21();
    changeColorleCircle22();
  }

  void changeVisibleText() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      print("start visible " + DateTime.now().toString());
      setState(() {
        visible = true;
      });
    });
  }

  void changeColorleCircle11() {
    timer = Timer.periodic(Duration(milliseconds: 6300), (timer) {
      setState(() {
        colorCircle11 = Colors.white;
      });
    });
  }

  void changeColorleCircle12() {
    timer = Timer.periodic(Duration(milliseconds: 6600), (timer) {
      setState(() {
        colorCircle12 = Colors.white;
      });
    });
  }

  void changeColorleCircle21() {
    timer = Timer.periodic(Duration(milliseconds: 8800), (timer) {
      setState(() {
        colorCircle21 = Colors.white;
      });
    });
  }

  void changeColorleCircle22() {
    timer = Timer.periodic(Duration(milliseconds: 9300), (timer) {
      setState(() {
        colorCircle22 = Colors.white;
      });
    });
  }

  void showFirstCircle1() {
    timer = Timer.periodic(Duration(milliseconds: 6500), (timer) {
      setState(() {
        heightCirclre11 = 160;
        widthCirclre11 = 160;
      });
    });
  }

  void showSecondCircle1() {
    timer = Timer.periodic(Duration(milliseconds: 6800), (timer) {
      setState(() {
        heightCirclre12 = 160;
        widthCirclre12 = 160;
      });
    });
  }

  void showFirstCircle2() {
    timer = Timer.periodic(Duration(milliseconds: 9000), (timer) {
      setState(() {
        heightCirclre21 = 160;
        widthCirclre21 = 160;
      });
    });
  }

  void showSecondCircle2() {
    timer = Timer.periodic(Duration(milliseconds: 9300), (timer) {
      setState(() {
        heightCirclre22 = 160;
        widthCirclre22 = 160;
      });
    });
  }

  void changeWidthAndHeight() {
    timer = Timer.periodic(Duration(seconds: 0), (timer) {
      width = 0;
      height = 0;
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Path path = createSpiralPath(size);
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: widthCirclre11,
                  height: heightCirclre11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: colorCircle11,
                  ),
                ),
              ),
              Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: widthCirclre12,
                  height: heightCirclre12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: colorCircle12,
                  ),
                ),
              ),
               Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: widthCirclre21,
                  height: heightCirclre21,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: colorCircle21,
                  ),
                ),
              ),
               Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: widthCirclre22,
                  height: heightCirclre22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: colorCircle22,
                  ),
                ),
              ),
              Center(
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: visible ? 1.0 : 0.0,
                  child: const Text(
                    "HI",
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ),
              Positioned(
                top: calculate(_animation!.value, path).dy,
                left: calculate(_animation!.value, path).dx,
                child: AnimatedContainer(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(250),
                    color: Colors.black,
                  ),
                  duration: Duration(seconds: 5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Offset calculate(value, Path _path) {
  PathMetrics? pathMetrics = _path.computeMetrics();
  PathMetric? pathMetric = pathMetrics.elementAt(0);
  value = pathMetric.length * value;
  Tangent? pos = pathMetric.getTangentForOffset(value);
  return pos!.position;
}

Path createSpiralPath(Size size) {
  double radius = 150, angle = 0;
  Path path = Path();
  path.moveTo(size.width / 2 + 100, size.height / 2 + 1.346963391139956e-11);
  for (int n = 200; n >= 0; n--) {
    radius -= 0.75;
    angle -= (math.pi * 2) / 50;
    var x = size.width / 2 + radius * math.cos(angle);
    var y = size.height / 2 + radius * math.sin(angle);
    path.lineTo(x, y);
  }

  return path;
}

class SpiralPainter extends CustomPainter {
  SpiralPainter({this.progress});
  double? progress;
  // ignore: prefer_final_fields
  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    Path path = createSpiralPath(size);
    PathMetric pathMetric = path.computeMetrics().first;
    Path extactPath =
        pathMetric.extractPath(0.0, pathMetric.length * progress!);
    canvas.drawPath(extactPath, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
