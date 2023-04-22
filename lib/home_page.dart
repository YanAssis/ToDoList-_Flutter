import 'package:expenses/pages/shop_page.dart';
import 'package:expenses/pages/list_page.dart';
import 'package:expenses/providers/tarefas_repository.dart';
import 'package:expenses/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var tarefaRepository =
          Provider.of<TarefaRepository>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      var tarefasPendentes = tarefaRepository.getPendentes;

      for (int i = 0; i < tarefasPendentes.length; i++) {
        userProvider.setLifeAfterTask();
      }
      print("Build Completed");
    });
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userdata = context.watch<UserProvider>().userInfo;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: const Color.fromARGB(255, 98, 0, 238),
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: userdata.isDead
                        ? Colors.red
                        : Colors.deepPurple.shade900,
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
                                '${userdata.coins} Moedas',
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
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          ListPage(),
          ShopPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple[900],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, color: Colors.white),
            label: 'Loja',
          ),
        ],
        unselectedLabelStyle:
            const TextStyle(color: Colors.white, fontSize: 14),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: paginaAtual,
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: const Duration(microseconds: 1000), curve: Curves.ease);
        },
      ),
    );
  }
}
