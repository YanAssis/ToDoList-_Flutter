import 'package:expenses/providers/tarefas_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/tarefas.dart';
import '../providers/userProvider.dart';

class NewToDoPage extends StatefulWidget {
  const NewToDoPage({super.key, required this.searchtext});
  final String searchtext;

  @override
  State<NewToDoPage> createState() => _NewToDoPageState();
}

class _NewToDoPageState extends State<NewToDoPage> {
  final formKey = GlobalKey<FormState>();

  var tituloController = TextEditingController();
  var descController = TextEditingController();
  var dateController = TextEditingController();
  var datetime = "";

  bool loading = false;

  @override
  void initState() {
    tituloController.text = widget.searchtext;
    descController.text = "";
    dateController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userdata = context.watch<UserProvider>().userInfo;

    createTarefa() async {
      loading = true;

      var titulo = tituloController.text;
      var descricao = descController.text;

      Tarefa novaTarefa = Tarefa(
        titulo: titulo,
        desc: descricao,
        data: datetime,
        isFinalizado: false,
        isAtrasado: false,
        isDebitado: false,
      );

      try {
        Provider.of<TarefaRepository>(context, listen: false)
            .createNewTarefa(novaTarefa);
      } finally {
        loading = false;
        const snackBar = SnackBar(
          content: Text('Nova tarefa criada!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      }
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 130,
          backgroundColor: const Color.fromARGB(255, 98, 0, 238),
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.deepPurple[900],
                      child: const Icon(
                        Icons.person,
                        size: 70,
                        color: Color.fromARGB(255, 98, 0, 238),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0; i < 5; i++)
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Icon(
                                  Icons.favorite,
                                  color: i < userdata.life
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 40,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: Icon(
                                Icons.castle,
                                color: Colors.yellowAccent[700],
                                size: 40,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  '${userdata.coins} Coins',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )),
                          ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 10),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        child: TextFormField(
                          controller: tituloController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 98, 0, 238))),
                            hintText: 'Insira o título da Tarefa',
                            labelText: 'Título da Tarefa',
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Favor inserir título da tarefa';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        child: TextFormField(
                          controller: descController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 98, 0, 238))),
                            hintText: 'Insira a descrição da Tarefa',
                            labelText: 'Descrição da Tarefa',
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: TextFormField(
                            controller: dateController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 98, 0, 238))),
                              icon: Icon(Icons.calendar_today),
                              hintText: 'Insira a data limite da Tarefa',
                              labelText: 'Data limite da Tarefa',
                            ),
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Favor inserir a data limite da tarefa';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);

                                setState(() {
                                  dateController.text = formattedDate;
                                  datetime = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                });
                              } else {
                                if (kDebugMode) {
                                  print("Date is not selected");
                                }
                              }
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: loading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.save),
                                iconSize: 50,
                                color: Colors.grey[800],
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    createTarefa();
                                  }
                                },
                              ),
                      ),
                    ],
                  )),
            ]),
          ),
        ));
  }
}
