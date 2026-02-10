import 'package:flutter/material.dart';

void main() {
  runApp(meuapp());
}

class meuapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text('Lista de tarefas', style:TextStyle(color: Colors.white)), 
        backgroundColor: Colors.black),

        // body: Center(
        //   child: Text('Olá Mundo!')),
        body: ListView(
          children: [

            ListTile(
              leading: Icon(Icons.radio_button_unchecked, color: Colors.amber),
              title: Text('Estudar flutter'),
              trailing: Icon(Icons.delete, color: Colors.red)),
            ListTile(
              leading: Icon(Icons.radio_button_unchecked, color: Colors.amber),
              title: Text('Praticar Dart'),
              trailing: Icon(Icons.delete, color: Colors.red)),
            ListTile(
              leading: Icon(Icons.radio_button_unchecked,color: Colors.amber),
              title: Text('Criar um App'),
              trailing: Icon(Icons.delete,color: Colors.red)),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.black,
          elevation: 30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.add, color: Colors.white,)
        
        )
      ),
    );
  }
}