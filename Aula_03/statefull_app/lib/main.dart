import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: PaginaContador()),
  );
}

class PaginaContador extends StatefulWidget {
  

  @override
  _PaginaContadorState createState() => _PaginaContadorState();
}

class _PaginaContadorState extends State<PaginaContador> {
  int contador = 0;

  void increment() {
    setState(() {
      contador++;
    });
  }

  void deincrement() {
    setState(() {
      contador--;
    });
  }

  void increment2() {
    setState(() {
      contador = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meu app interativo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      body: Center(
        child: Text("Cliques: $contador", style: TextStyle(fontSize: 30)),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 68, 255, 68),
            onPressed: increment,
            child: Icon(Icons.add, color: Colors.white),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: increment2,
            child: Icon(Icons.exposure_zero_rounded, color: Colors.white),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: deincrement,
            backgroundColor: const Color.fromARGB(255, 255, 68, 68),
            child: Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
