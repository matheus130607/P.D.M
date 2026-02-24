import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: Paginarandom()),
  );
}

  class Paginarandom extends StatefulWidget{
    

    @override
    _PaginarandomState createState() => _PaginarandomState();
  }

  class _PaginarandomState extends State<Paginarandom> {
    int aleatorio = 0;

    void sortear() {
      setState(() {
        aleatorio = Random().nextInt(21);
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title:Text("Atividade Random",
          style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),

         body: Center(
        child: Text("(＾０＾@): $aleatorio", style: TextStyle(fontSize: 30)),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(185, 127, 60, 182),
            onPressed: sortear,
            child: Icon(Icons.casino, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
