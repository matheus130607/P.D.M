import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<String> lista = [];
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  void adicionarTarefa() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      lista.add(controller.text.trim());
    });

    controller.clear();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas tarefas: ${lista.length}"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          TextField(
            controller: controller,
            focusNode: focusNode,
            onSubmitted: (_) => adicionarTarefa(),
          ),

          Expanded(
            child: lista.isEmpty
                ? const Center(
                    child: Text("Nenhuma tarefa na lista"),
                  )
                : ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(lista[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              lista.removeAt(index);
                            });
                          },
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