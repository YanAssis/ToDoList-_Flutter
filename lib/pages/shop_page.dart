import 'package:expenses/models/itens.dart';
import 'package:expenses/widgets/Item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/userProvider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Item> _getItens() {
    List<Item> listItem = [];

    //Chamada para recuperar dados dos items à venda

    Item newItem = Item(
        nome: 'Elixir',
        imageurl: 'teste',
        preco: 5,
        descricao: "Restaura um ponto de vida",
        buy: () {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setlives(context, 1)
              ? userProvider.setCoinsAfterBuy(context, -5)
              : null;
        });

    listItem.add(newItem);

    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    var items = _getItens();

    return Scaffold(
        body: ListView.builder(
            itemCount: items.length,
            prototypeItem: ItemWidget(itemModel: items.first),
            itemBuilder: (context, index) {
              return ItemWidget(itemModel: items[index]);
            }));
  }
}
