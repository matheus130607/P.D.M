import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CadastroInteligente(),
    ),
  );
}

class CadastroInteligente extends StatefulWidget {
  const CadastroInteligente({super.key});

  @override
  State<CadastroInteligente> createState() => _CadastroInteligenteState();
}

class _CadastroInteligenteState extends State<CadastroInteligente> {

  // Controladores para os campos de entrada
  TextEditingController tituloController = TextEditingController();
  TextEditingController descController = TextEditingController();
  
  List<Map<String, dynamic>> tarefas = [];

  //FUNÇÕES DO BANCO DE DADOS
  Future<Database> criarBanco() async {
    final caminho = await getDatabasesPath();
    final path = join(caminho, "banco_profissional.db");

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dados(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT, data TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> inserirItem() async {
    if (tituloController.text.isEmpty) return;

    final db = await criarBanco();
    await db.insert("dados", {
      "titulo": tituloController.text,
      "descricao": descController.text,
      "data": DateTime.now().toString().substring(0, 16), // Bônus: Campo Data
    });

    tituloController.clear();
    descController.clear();
    carregarItens();
  }

  Future<void> carregarItens() async {
    final db = await criarBanco();
    //Ordenar por título (ASC)
    final lista = await db.query("dados", orderBy: "titulo ASC");

    setState(() {
      tarefas = lista;
    });
  }

  Future<void> deletarItem(int id) async {
    final db = await criarBanco();
    await db.delete("dados", where: "id = ?", whereArgs: [id]);
    carregarItens();
  }

  @override
  void initState() {
    super.initState();
    carregarItens();
  }

  //INTERFACE PRINCIPAL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 26, 70),
        title: const Text("Cadastro Profissional", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Campos de Cadastro
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(labelText: "Título", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Descrição", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: inserirItem,
                  icon: const Icon(Icons.save),
                  label: const Text("Salvar Item"),
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                ),
              ],
            ),
          ),

          const Divider(),

          // Listagem
          Expanded(
            child: tarefas.isEmpty
                ? const Center(child: Text("Nenhum item cadastrado", style: TextStyle(fontSize: 18, color: Colors.grey)))
                : ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      final item = tarefas[index];
                      return Card(
                        child: ListTile(
                          title: Text(item["titulo"], style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("${item["descricao"]}\nCriado em: ${item["data"]}"),
                          isThreeLine: true,
                          
                          // Abrir Edição
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => TelaEditar(item: item),
                          ),
                        ).then((value) => carregarItens());
                      },

                          // Remover 
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deletarItem(item["id"]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//SEGUNDA TELA: EDIÇÃO

class TelaEditar extends StatefulWidget {
  final Map<String, dynamic> item;
  const TelaEditar({super.key, required this.item});

  @override
  State<TelaEditar> createState() => _TelaEditarState();
}

class _TelaEditarState extends State<TelaEditar> {
  late TextEditingController editTitulo;
  late TextEditingController editDesc;

  @override
  void initState() {
    super.initState();
    editTitulo = TextEditingController(text: widget.item["titulo"]);
    editDesc = TextEditingController(text: widget.item["descricao"]);
  }

  Future<void> atualizarNoBanco(BuildContext context) async {
    final caminho = await getDatabasesPath();
    final path = join(caminho, "banco_profissional.db");
    final db = await openDatabase(path);

    await db.update(
      "dados",
      {
        "titulo": editTitulo.text,
        "descricao": editDesc.text,
      },
      where: "id = ?",
      whereArgs: [widget.item["id"]],
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Item")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: editTitulo, decoration: const InputDecoration(labelText: "Título")),
            const SizedBox(height: 10),
            TextField(controller: editDesc, decoration: const InputDecoration(labelText: "Descrição")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => atualizarNoBanco(context),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text("Confirmar Alteração"),
            ),
          ],
        ),
      ),
    );
  }
}