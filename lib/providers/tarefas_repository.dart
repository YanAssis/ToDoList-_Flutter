import 'dart:collection';
import 'package:expenses/models/tarefas.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TarefaRepository extends ChangeNotifier {
  static List<Tarefa> _lista = tabela;
  UnmodifiableListView<Tarefa> get lista => UnmodifiableListView(_lista);

  UnmodifiableListView<Tarefa> get getPendentes => UnmodifiableListView(
      _lista.where((element) => element.isAtrasado && !element.isDebitado));

  createNewTarefa(Tarefa tarefa) {
    _lista.add(tarefa);
    notifyListeners();
  }

  finalizarTarefa(Tarefa tarefa) {
    var index = _lista.indexWhere((element) => element == tarefa);

    if (index > -1) {
      _lista[index].isFinalizado = true;
    }
    notifyListeners();
  }

  updateTarefaAtrasada(Tarefa tarefa) {
    var index = _lista.indexWhere((element) => element == tarefa);

    if (index > -1) {
      _lista[index].isAtrasado = true;
    }
  }

  filtrarTarefa(List<Tarefa> tarefas) {
    _lista = tarefas;
    notifyListeners();
  }

  resetTarefas() {
    _lista = tabela;
    notifyListeners();
  }

  static List<Tarefa> tabela = [
    Tarefa(
        titulo: 'Pintar quarto',
        desc: '164603.00',
        isFinalizado: false,
        isAtrasado: false,
        isDebitado: false,
        data: "2023-04-28"),
    Tarefa(
        titulo: 'Terminar roteiro',
        desc: '164603.00',
        isFinalizado: true,
        isAtrasado: false,
        isDebitado: false,
        data: "2023-04-30"),
    Tarefa(
        titulo: 'Varrer casa',
        desc: '164603.00',
        isFinalizado: false,
        isAtrasado: false,
        isDebitado: false,
        data: "2023-04-10"),
    Tarefa(
        titulo: 'Limpar geladeira',
        desc: '164603.00',
        isFinalizado: false,
        isAtrasado: true,
        isDebitado: true,
        data: "2023-04-02"),
  ];
}
