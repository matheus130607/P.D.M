import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InterruptorApp(),  
  ));
}

class InterruptorApp extends StatefulWidget {
  @override
  _InterruptorAppState createState() => _InterruptorAppState();
}

class _InterruptorAppState extends State<InterruptorApp> {
  bool estaAceso = false;

  void alternarLuz() {
    setState(() {
      estaAceso = !estaAceso;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: estaAceso ? Colors.yellow: const Color.fromARGB(255, 230, 77, 67),
      appBar: AppBar(
        backgroundColor: estaAceso ? Colors.yellow: const Color.fromARGB(255, 230, 77, 67),
        title: Text('Interruptor', style: TextStyle(color: estaAceso ? const Color.fromARGB(255, 230, 77, 67): Colors.yellow)),
        centerTitle: true,
      ),

      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        
            // Icon(
            //   estaAceso ? Icons.lightbulb: Icons.lightbulb_outline,
            //   size: 100,
            //   color: estaAceso ? const Color.fromARGB(255, 230, 77, 67): Colors.yellow,
            // ),
            ElevatedButton(
              onPressed: alternarLuz,
              style: ElevatedButton.styleFrom(
                backgroundColor: estaAceso ? const Color.fromARGB(255, 230, 77, 67): Colors.yellow
              ),
              child: estaAceso 
              ? Text("😊Feliz", style: TextStyle(color: Colors.black))
              : Text("😡Bravo", style: TextStyle(color: Colors.white))
              ),
          ],
        ),
      ),
    );
  }
}