import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starter: Random Circle',
      home: const RandomCirclePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Step 3 - creates one circle
class CircleData {
  final double x;
  final double y;
  final Color color;
  final double diameter;

  CircleData({
    required this.x,
    required this.y,
    required this.color,
    this.diameter = 50,
  });
}

// Step 4 - random position on screen
class CircleDot extends StatelessWidget {
  final double x;
  final double y;
  final Color color;
  final double diameter;

  const CircleDot({
    super.key,
    required this.x,
    required this.y,
    required this.color,
    this.diameter = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class RandomCirclePage extends StatefulWidget {
  const RandomCirclePage({super.key});

  @override
  State<RandomCirclePage> createState() => _RandomCirclePageState();
}

class _RandomCirclePageState extends State<RandomCirclePage> {
  final Random _rng = Random(); 

  // Step 1
  final List<Color> colorList = [Colors.red, Colors.orange, Colors.yellow, Colors.green];
  Color selectedColor = Colors.red;

  // List of circles
  final List<CircleData> _circles = [];

  static const double _diameter = 50;

  // Add a new circle
  void _addCircle() {
    final size = MediaQuery.of(context).size;

    const topPadding = 100.0;
    const bottomPadding = 100.0;
    final maxX = size.width - _diameter;
    final maxY = size.height - _diameter - bottomPadding;

    final x = _rng.nextDouble() * maxX;
    final y = topPadding + _rng.nextDouble() * (maxY - topPadding);

    setState(() {
      _circles.add(
        CircleData(x: x, y: y, color: selectedColor),
      );
    });
  }

  // Step 5
  void _clearCircles() {
    setState(() {
      _circles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Starter: One Random Circle')),
      body: Stack(
        children: [
          // Draw all circles
          for (final circle in _circles)
            CircleDot(
              x: circle.x,
              y: circle.y,
              color: circle.color,
              diameter: circle.diameter,
            ),
          // Step 2
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Row( //Step 2
                mainAxisAlignment: MainAxisAlignment.center,
                children: colorList.map((color) {
                  final bool isSelected = color == selectedColor;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.transparent, // border is black if selected if not then transparent
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: _addCircle,
            icon: const Icon(Icons.add),
            label: const Text('Add Object'),
          ),
          const SizedBox(width: 10),
          FloatingActionButton.extended(
            onPressed: _clearCircles,
            icon: const Icon(Icons.clear),
            label: const Text('Clear All'),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
