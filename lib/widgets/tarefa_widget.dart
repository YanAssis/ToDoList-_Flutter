import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefas.dart';
import '../providers/tarefas_repository.dart';
import '../providers/userProvider.dart';

class TarefaWidget extends StatefulWidget {
  const TarefaWidget({super.key, required this.tarefaModel});
  final Tarefa tarefaModel;

  @override
  State<TarefaWidget> createState() => _TarefaWidgetState();
}

class _TarefaWidgetState extends State<TarefaWidget> {
  @override
  Widget build(BuildContext context) {
    var tarefaRepository = context.watch<TarefaRepository>();
    var userProvider = context.watch<UserProvider>();

    String titulo = widget.tarefaModel.titulo;

    String dataLimiteTarefa = widget.tarefaModel.data;

    final dateHoje = DateTime.now();
    DateTime datalimite = DateTime.parse(dataLimiteTarefa);
    final difference = datalimite.difference(dateHoje).inDays;

    // void _deletar(BuildContext context) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext ctx) {
    //         return AlertDialog(
    //           title: const Text('Confirmação'),
    //           content: const Text('Deseja deletar a tarefa?'),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     tarefaRepository.removerTarefa;
    //                     this.deactivate();
    //                   });

    //                   Navigator.of(ctx).pop();
    //                 },
    //                 child: const Text('Sim')),
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.of(ctx).pop();
    //                 },
    //                 child: const Text('Não'))
    //           ],
    //         );
    //       });
    // }

    BoxDecoration bordercolor;
    InkWell traillingIcon = InkWell(
      onTap: () {
        setState(() {
          widget.tarefaModel.isFinalizado = true;
          tarefaRepository.finalizarTarefa(widget.tarefaModel);
          userProvider.setCoinsAfterTask(context);
        });
      },
      child: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
    );

    if (widget.tarefaModel.isFinalizado) {
      traillingIcon = InkWell(
        onTap: () {
          SnackBar snackBar =
              const SnackBar(content: Text('Tarefa já finalizada'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Icon(
          Icons.thumb_up,
          color: Colors.green,
        ),
      );

      bordercolor = BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 3, 218, 197), width: 2));
    } else if (difference < 0) {
      tarefaRepository.updateTarefaAtrasada(widget.tarefaModel);

      traillingIcon = InkWell(
        onTap: () {
          SnackBar snackBar = const SnackBar(
              content: Text('Tarefa atrasada, favor criar nova tarefa'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      );

      bordercolor =
          BoxDecoration(border: Border.all(color: Colors.red, width: 2));
    } else if (difference == 0) {
      bordercolor =
          BoxDecoration(border: Border.all(color: Colors.yellow, width: 2));
    } else {
      bordercolor = BoxDecoration(
          border: Border.all(color: Colors.grey.shade700, width: 2));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        // onLongPress: () => _deletar(context),
        child: Container(
          height: 50,
          width: 400,
          decoration: bordercolor,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Font Awesome 5 Brands',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: SizedBox(
                      width: 170,
                      child: Text(
                          difference > 0
                              ? 'Dias restantes: $difference'
                              : 'TAREFA ATRASADA!!!',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Font Awesome 5 Brands',
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: traillingIcon,
                )
              ]),
        ),
      ),
    );
  }
}
