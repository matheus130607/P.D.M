import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JogoApp(),
  ));
}

class JogoApp extends StatefulWidget {
  @override
  _JogoAppState createState() => _JogoAppState();
}

class _JogoAppState extends State<JogoApp> {

  String escolhaUsuario = "❔";
  String escolhaComputador = "💻";
  String resultado = "Escolha sua jogada";

  int pontosJogador = 0;
  int pontosComputador = 0;

  late ConfettiController _confetti;

  List<String> opcoes = ["pedra", "papel", "tesoura"];

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  String emoji(String valor) {
    if (valor == "pedra") return "🪨";
    if (valor == "papel") return "📄";
    return "✂️";
  }

  void jogar(String escolha) {
    var pc = opcoes[Random().nextInt(3)];

    setState(() {
      escolhaUsuario = emoji(escolha);
      escolhaComputador = emoji(pc);

      if (escolha == pc) {
        resultado = "Empate 😐";
      } 
      else if (
        (escolha == "pedra" && pc == "tesoura") ||
        (escolha == "papel" && pc == "pedra") ||
        (escolha == "tesoura" && pc == "papel")
      ) {
        pontosJogador++;
        resultado = "Você venceu 🎉";

        if (pontosJogador == 5) {
          resultado = "🏆 CAMPEÃO!";
          pontosJogador = 0;
          pontosComputador = 0;
          _confetti.play();
        }

      } else {
        pontosComputador++;
        resultado = "Computador venceu 💀";

        if (pontosComputador == 5) {
          resultado = "☠️ VOCÊ FOI DESTRUIDO!";
          pontosJogador = 0;
          pontosComputador = 0;
        }
      }
    });
  }

  Widget botao(String emojiIcon, String valor) {
    return GestureDetector(
      onTap: () => jogar(valor),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade200],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Text(
          emojiIcon,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 🌈 FUNDO BONITO
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1f1c2c), Color(0xff928dab)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Stack(
          alignment: Alignment.center,
          children: [

            // 🎆 CONFETTI
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confetti,
                blastDirectionality: BlastDirectionality.explosive,
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // 🧠 TÍTULO
                Text(
                  "Pedra • Papel • Tesoura",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),

                // 🧊 CARD PRINCIPAL
                Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white24),
                  ),

                  child: Column(
                    children: [

                      // 🆚 ESCOLHAS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Column(
                            children: [
                              Text("Você", style: TextStyle(color: Colors.white)),
                              SizedBox(height: 10),
                              Text(escolhaUsuario, style: TextStyle(fontSize: 50)),
                            ],
                          ),

                          Text("VS", style: TextStyle(color: Colors.white)),

                          Column(
                            children: [
                              Text("PC", style: TextStyle(color: Colors.white)),
                              SizedBox(height: 10),
                              Text(escolhaComputador, style: TextStyle(fontSize: 50)),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 25),

                      // 📊 RESULTADO
                      Text(
                        resultado,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        "$pontosJogador  x  $pontosComputador",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 25),

                      // 🎮 BOTÕES
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          botao("🪨", "pedra"),
                          botao("📄", "papel"),
                          botao("✂️", "tesoura"),
                        ],
                      ),

                      SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            pontosJogador = 0;
                            pontosComputador = 0;
                            resultado = "Resetado!";
                            escolhaUsuario = "❔";
                            escolhaComputador = "💻";
                          });
                        },
                        child: Text("Resetar"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}