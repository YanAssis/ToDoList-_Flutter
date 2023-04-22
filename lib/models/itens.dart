import 'dart:convert';

class Item {
  String nome;
  String imageurl;
  int preco;
  String descricao;
  Function buy;

  Item({
    required this.nome,
    required this.imageurl,
    required this.preco,
    required this.descricao,
    required this.buy,
  });

  factory Item.fromJson(dynamic json) {
    var data = jsonDecode(json.toString());

    final nome = data['nome'];
    final imageurl = data['imageurl'];
    final preco = int.tryParse(data['preco']);
    final descricao = data['descricao'];
    final buy = data['buy'];

    return Item(
        nome: nome,
        imageurl: imageurl,
        preco: preco!,
        descricao: descricao,
        buy: buy);
  }
}
