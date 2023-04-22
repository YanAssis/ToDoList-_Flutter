import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/itens.dart';
import '../providers/userProvider.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.itemModel});
  final Item itemModel;

  @override
  Widget build(BuildContext context) {
    String nome = itemModel.nome;
    String descricao = itemModel.descricao;
    int preco = itemModel.preco;

    var userProvider = context.watch<UserProvider>();
    var userdata = userProvider.userInfo;

    return SizedBox(
      width: 400.0,
      height: 170.0,
      child: Card(
        color: const Color.fromARGB(255, 229, 185, 185),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple[900],
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        nome,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Font Awesome 5 Brands',
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: SizedBox(
                        width: 170,
                        child: Text(descricao,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Font Awesome 5 Brands',
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ))),
                  ),
                ]),
            InkWell(
              onTap: () {
                if (preco <= userdata.coins) {
                  itemModel.buy();
                } else {
                  SnackBar snackBar = const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          'Seu saldo é insuficiente, complete atividades para receber mais moedas'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.grey))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.blue[900],
                          size: 45,
                        ),
                      ),
                      Text(
                        '$preco Moedas',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Font Awesome 5 Brands',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
