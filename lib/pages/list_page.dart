import 'package:expenses/pages/new_ToDo_page.dart';
import 'package:expenses/widgets/tarefa_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefas.dart';
import '../providers/tarefas_repository.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var tarefasprovider = context.watch<TarefaRepository>();
    List<Tarefa> tarefas = tarefasprovider.lista;

    void searchTask(String query) {
      query = searchController.text;
      if (query.isNotEmpty) {
        final suggestions = tarefas.where((tarefa) {
          final tituloTarefa = tarefa.titulo.toLowerCase();
          final input = query.toLowerCase();
          return tituloTarefa.contains(input);
        }).toList();

        if (suggestions.isNotEmpty) {
          setState(() {
            tarefasprovider.filtrarTarefa(suggestions);
          });
        } else {
          setState(() {
            tarefasprovider.resetTarefas();
          });
        }
      } else {
        setState(() {
          tarefasprovider.resetTarefas();
        });
      }
    }

    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 340,
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: 'Insira o título da Tarefa',
                          labelText: 'Título da Tarefa',
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: searchTask,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 47,
                    height: 50,
                    child: MaterialButton(
                        //height: 40,
                        padding: const EdgeInsets.all(8),
                        color: const Color.fromARGB(255, 3, 218, 197),
                        shape: const CircleBorder(),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewToDoPage()));
                        },
                        child: const Icon(Icons.add)),
                  )
                ]),
          ),
          tarefas.isEmpty
              ? const Text('Crie uma nova tarefa clicando em +')
              : Expanded(
                  child: ListView.builder(
                      itemCount: tarefas.length,
                      prototypeItem: TarefaWidget(tarefaModel: tarefas.first),
                      itemBuilder: (context, index) {
                        return TarefaWidget(
                          tarefaModel: tarefas[index],
                        );
                      }),
                )
        ]));
  }
}
