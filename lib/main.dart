import 'package:expenses/home_page.dart';
import 'package:expenses/providers/tarefas_repository.dart';
import 'package:expenses/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MediaQuery(
    data: const MediaQueryData(),
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TarefaRepository())
      ],
      child: const MaterialApp(home: MyApp()),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
