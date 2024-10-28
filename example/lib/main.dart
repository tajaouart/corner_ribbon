import 'package:corner_ribbon/corner_ribbon.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Corner Ribbon Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Corner Ribbon Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.green,
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 16,
            spacing: 16,
            children: [
              for (final position in RibbonPosition.values)
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CornerRibbon(
                    label: 'Best Seller !!',
                    position: position,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      shadows: [
                        Shadow(
                          blurRadius: 3.0,
                          color: Colors.grey,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                    ribbonColor: const Color(0xFFFFD700),
                    // More vibrant yellow
                    child: Image.asset('assets/shoes.png'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
