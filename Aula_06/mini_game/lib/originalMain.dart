import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JogoApp(),
    ),
  );
}

class JogoApp extends StatefulWidget {
  @override
  _JogoAppState createState() => _JogoAppState();
}

class _JogoAppState extends State<JogoApp> {
  IconData iconeComputador = Icons.monitor;
  String resultado = "Escolha uma opção";
  int pontosJogador = 0;
  int pontosComputador = 0;
  Color corFundo = Colors.grey;

  List<String> opcoes = ["pedra", "papel", "tesoura"];

  void jogar(String escolhaUsuario) {
    var numero = Random().nextInt(3);
    var escolhaComputador = opcoes[numero];

    setState(() {

      // Ícone do computador
      if (escolhaComputador == "pedra") {
        iconeComputador = Icons.circle;
      } else if (escolhaComputador == "papel") {
        iconeComputador = Icons.pan_tool;
      } else if (escolhaComputador == "tesoura") {
        iconeComputador = Icons.content_cut;
      }

      // Resultado + cor
      if (escolhaUsuario == escolhaComputador) {
        resultado = "Empate";
        corFundo = Colors.grey;
      } 
      else if (
        (escolhaUsuario == "pedra" && escolhaComputador == "tesoura") ||
        (escolhaUsuario == "papel" && escolhaComputador == "pedra") ||
        (escolhaUsuario == "tesoura" && escolhaComputador == "papel")
      ) {
        pontosJogador++;
        resultado = "Você venceu!";
        corFundo = Colors.green;

        if (pontosJogador == 5) {
          resultado = "🏆 Você ganhou o campeonato!";
          pontosJogador = 0;
          pontosComputador = 0;
        }

      } else {
        pontosComputador++;
        resultado = "Computador venceu!";
        corFundo = Colors.red;
      }
    });
  }

  void resetarPlacar() {
    setState(() {
      pontosJogador = 0;
      pontosComputador = 0;
      resultado = "Placar resetado!";
      iconeComputador = Icons.monitor;
      corFundo = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        title: Text("Pedra, Papel e Tesoura"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text(
                "Computador",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),

              SizedBox(height: 10),

              Icon(
                iconeComputador,
                size: 100,
                color: Colors.white,
              ),

              SizedBox(height: 20),

              Text(
                resultado,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              Text(
                "Você: $pontosJogador   |   PC: $pontosComputador",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),

              SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  IconButton(
                    icon: Icon(Icons.circle, color: Colors.white),
                    iconSize: 40,
                    onPressed: () => jogar("pedra"),
                  ),

                  SizedBox(width: 15),

                  IconButton(
                    icon: Icon(Icons.pan_tool, color: Colors.white),
                    iconSize: 40,
                    onPressed: () => jogar("papel"),
                  ),

                  SizedBox(width: 15),

                  IconButton(
                    icon: Icon(Icons.content_cut, color: Colors.white),
                    iconSize: 40,
                    onPressed: () => jogar("tesoura"),
                  ),
                ],
              ),

              SizedBox(height: 25),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: resetarPlacar,
                icon: Icon(Icons.refresh),
                label: Text("Resetar Placar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}