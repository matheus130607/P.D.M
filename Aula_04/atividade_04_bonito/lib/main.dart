import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. Definimos os temas disponíveis no app
enum AppTheme { claro, escuro, daltonico }

// Classe Tarefa
class Tarefa {
  String titulo;
  bool concluida;
  Tarefa({required this.titulo, this.concluida = false});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Tema padrão inicial
  AppTheme _temaAtual = AppTheme.claro;

  void _mudarTema(AppTheme novoTema) {
    setState(() {
      _temaAtual = novoTema;
    });
  }

  // 2. Lógica para retornar as cores dependendo do tema escolhido
  ThemeData _getThemeData() {
    switch (_temaAtual) {
      case AppTheme.escuro:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.deepPurple,
          scaffoldBackgroundColor: const Color(0xFF121212),
          cardColor: const Color(0xFF1E1E1E),
        );
      case AppTheme.daltonico:
      // Modo Daltônico: Foco em Azul (Seguro) e Laranja (Atenção/Exclusão). Evita Verde/Vermelho.
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.blue, // Azul é altamente reconhecível
          scaffoldBackgroundColor: const Color(0xFFF0F4F8),
          cardColor: Colors.white,
        );
      case AppTheme.claro:
      default:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.deepPurple,
          scaffoldBackgroundColor: const Color(0xFFF8F9FE),
          cardColor: Colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _getThemeData(),
      // Passamos o tema atual e a função de trocar de tema para a página principal
      home: TodoPage(
        temaAtual: _temaAtual,
        onMudarTema: _mudarTema,
      ),
    );
  }
}

class TodoPage extends StatefulWidget {
  final AppTheme temaAtual;
  final Function(AppTheme) onMudarTema;

  const TodoPage({
    super.key,
    required this.temaAtual,
    required this.onMudarTema,
  });

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Tarefa> _lista = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _adicionarTarefa() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _lista.insert(0, Tarefa(titulo: _controller.text.trim()));
    });

    _controller.clear();
    _focusNode.requestFocus();
  }

  void _removerTarefa(int index) {
    setState(() {
      _lista.removeAt(index);
    });
  }

  void _alternarTarefa(int index) {
    setState(() {
      _lista[index].concluida = !_lista[index].concluida;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Variáveis auxiliares para adaptar o design com base no tema
    final bool isDark = widget.temaAtual == AppTheme.escuro;
    final bool isDaltonico = widget.temaAtual == AppTheme.daltonico;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Minhas Tarefas",
          style: TextStyle(
            // Adapta a cor do título se for modo escuro
            color: isDark ? Colors.white : Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          // 3. Menu Dropdown (Popup) para escolher o tema
          PopupMenuButton<AppTheme>(
            icon: Icon(Icons.palette_outlined, color: isDark ? Colors.white : Colors.grey[800]),
            tooltip: "Mudar Tema",
            onSelected: widget.onMudarTema,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: AppTheme.claro,
                child: Row(children: [Icon(Icons.light_mode, size: 20), SizedBox(width: 10), Text('Claro')]),
              ),
              const PopupMenuItem(
                value: AppTheme.escuro,
                child: Row(children: [Icon(Icons.dark_mode, size: 20), SizedBox(width: 10), Text('Escuro')]),
              ),
              const PopupMenuItem(
                value: AppTheme.daltonico,
                child: Row(children: [Icon(Icons.visibility, size: 20), SizedBox(width: 10), Text('Daltônico')]),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text("${_lista.length}",
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Campo de Entrada Estilizado
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  if (!isDark) // Remove a sombra no modo escuro para um visual mais limpo
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                onSubmitted: (_) => _adicionarTarefa(),
                decoration: InputDecoration(
                  hintText: "O que vamos fazer hoje?",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.add_task_rounded, color: Theme.of(context).colorScheme.primary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary),
                    onPressed: _adicionarTarefa,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            // Lista de Tarefas
            Expanded(
              child: _lista.isEmpty
                  ? _buildEmptyState(isDark)
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: _lista.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _buildTaskTile(index, isDark, isDaltonico);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.beach_access_rounded, size: 80, color: isDark ? Colors.grey[800] : Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "Tudo limpo por aqui!",
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskTile(int index, bool isDark, bool isDaltonico) {
    final tarefa = _lista[index];

    // 4. Adaptação de Cores Críticas (Excluir e Concluído)
    // No modo daltônico, usamos Laranja forte em vez de Vermelho para exclusão
    Color corFundoExcluir = isDaltonico ? Colors.orange[100]! : (isDark ? Colors.red[900]! : Colors.red[50]!);
    Color corIconeExcluir = isDaltonico ? Colors.orange[900]! : (isDark ? Colors.white : Colors.red);
    
    // Cor do card muda ligeiramente se estiver concluído
    Color corCard = tarefa.concluida
        ? (isDark ? Colors.grey[850]! : Colors.grey[100]!)
        : Theme.of(context).cardColor;

    return Dismissible(
      key: Key(tarefa.titulo + index.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => _removerTarefa(index),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: corFundoExcluir,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(isDaltonico ? Icons.delete_forever : Icons.delete_outline, color: corIconeExcluir),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: corCard,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(isDark ? 0.0 : 0.1)),
        ),
        child: ListTile(
          leading: Checkbox(
            value: tarefa.concluida,
            onChanged: (valor) => _alternarTarefa(index),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            tarefa.titulo,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              decoration: tarefa.concluida ? TextDecoration.lineThrough : null,
              color: tarefa.concluida ? Colors.grey : (isDark ? Colors.white : Colors.black87),
            ),
          ),
          trailing: const Icon(Icons.drag_indicator, color: Colors.grey, size: 20),
        ),
      ),
    );
  }
}