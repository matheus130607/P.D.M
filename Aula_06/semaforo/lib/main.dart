import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SemaforoApp(),
  ));
}

class SemaforoApp extends StatefulWidget {
  @override
  _SemaforoAppState createState() => _SemaforoAppState();
}

class _SemaforoAppState extends State<SemaforoApp> {
  int estado = 0;

  void mudarSemaforo() {
    setState(() {
      estado++;
      if (estado > 2) {
        estado = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 80, 98, 138),
      appBar: AppBar(
        title: Text("Semáforo de Trânsito"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //PEDESTRE
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Icon(
                    estado == 0
                        ? Icons.directions_walk
                        : Icons.pan_tool,
                    size: 60,
                    color:
                        estado == 0 ? Colors.green : Colors.red,
                  ),
                  SizedBox(height: 5),
                  Text(
                    estado == 0
                        ? "ATRAVESSE"
                        : "AGUARDE",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            //SEMÁFORO
            Container(
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //VERMELHO
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 2
                          ? Colors.red
                          : Colors.grey[700],
                      shape: BoxShape.circle,
                    ),
                  ),

                  SizedBox(height: 15),

                  //AMARELO
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 1
                          ? Colors.yellow
                          : Colors.grey[700],
                      shape: BoxShape.circle,
                    ),
                  ),

                  SizedBox(height: 15),

                  // VERDE
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 0
                          ? Colors.green
                          : Colors.grey[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // BOTÃO
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: mudarSemaforo,
              child: Text("Mudar Semáforo"),
            ),
          ],
        ),
      ),
    );
  }
}