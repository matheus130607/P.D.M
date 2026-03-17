import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TemperaturaApp(),
  ));
}

class TemperaturaApp extends StatefulWidget {
  @override

  _TemperaturaAppState createState() => _TemperaturaAppState();
}

class _TemperaturaAppState extends State<TemperaturaApp> {
  int temperatura = 20;

  void aumentar() {
    setState(() {
      temperatura++;
    });
  }

  void diminuir() {
    setState(() {
      temperatura--;
    });
  }


  @override
  Widget build(BuildContext context) {

    Color corFundo;
    IconData icone;
    String status;

    if(temperatura < 15) {
      corFundo = Colors.lightBlueAccent;
      icone = Icons.ac_unit;
      status = "Frio";

    } else if(temperatura < 30) {
      corFundo = const Color.fromARGB(255, 78, 143, 4);
      icone = Icons.wb_sunny;
      status = "Agradável";

    } else {
      corFundo = Colors.redAccent;
      icone = Icons.local_fire_department;
      status = "Quente";
    }

    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        title: Text("Controle de Temperatura"),
        centerTitle: true,
      ),

      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone,size: 120, color: Colors.white),
            Text("$temperatura °C", style: TextStyle(fontSize: 40, color: Colors.white)),
            Text(status, style: TextStyle(fontSize: 28, color: Colors.white)),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: diminuir,
                  child: Text("-"),
                ),
                
                SizedBox(width:20),

                ElevatedButton(
                  onPressed: aumentar,
                  child: Text("+"),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}