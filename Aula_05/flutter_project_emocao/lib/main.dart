import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HumorApp(),  
  ));
}

class HumorApp extends StatefulWidget {
  @override
  _HumorAppState createState() => _HumorAppState();
}

class _HumorAppState extends State<HumorApp> {
  int humor = 0;

  void alternarhumor() {
    setState(() {
      if (humor >= 2) {
        humor = 0;
      } else {
        humor++;
      }
    });
  }

  Color backgroundAppbar() {
    if (humor == 0) {
      return Colors.grey;
      } else if (humor == 1) {
      return Colors.yellow; 
      } else {
      return Colors.red;
  }
}

  Text TextAppbar() {
  if (humor == 0) {
    return Text(
      'Neutro',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  } else if (humor == 1) {
    return Text(
      'Feliz',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    );
  } else {
    return Text(
      'Bravo',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundAppbar(),
        title: Text('Mudança de Humor', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            if (humor == 0 ) 
              Text('😐', style: TextStyle(fontSize: 80))
             else if (humor == 1) 
              Text('😊', style: TextStyle(fontSize: 80))
            else 
              Text('😡', style: TextStyle(fontSize: 80)),

              SizedBox(height: 20),
              TextAppbar(),
            ElevatedButton(
              onPressed: alternarhumor,
              style: ElevatedButton.styleFrom(
                backgroundColor:Colors.black
              ),
              child: Text("Alterar humor", style: TextStyle(color: Colors.white))
            ),
          ],
        ),
      ),
    );
  }
}