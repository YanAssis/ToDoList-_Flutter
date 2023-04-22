import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final User _userInfo = User(life: 5, coins: 20, isDead: false);

  User get userInfo {
    return _userInfo;
  }

  bool setlives(BuildContext context, int newlifes) {
    int uplifes = _userInfo.life + newlifes;
    if (uplifes <= 5) {
      _userInfo.life = uplifes;
      notifyListeners();
      return true;
    } else {
      SnackBar snackBar = const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Sua vida já está completa'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  setLifeAfterTask() {
    int uplife = _userInfo.life - 1;
    if (uplife >= 0) {
      _userInfo.life = uplife;
      notifyListeners();
    } else {
      _userInfo.isDead = true;
      notifyListeners();
    }
    print("vidas atualizadas");
  }

  setCoinsAfterBuy(BuildContext context, int newcoins) {
    int upcoins = _userInfo.coins + newcoins;
    if (upcoins > 0) {
      _userInfo.coins = upcoins;
      SnackBar snackBar = const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Compra efetuada com sucesso'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      notifyListeners();
    } else {
      SnackBar snackBar = const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              'Seu saldo é insuficiente, complete atividades para receber mais moedas'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  setCoinsAfterTask(BuildContext context) {
    int upcoins = _userInfo.coins + 2;
    _userInfo.coins = upcoins;
    SnackBar snackBar = const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Tarefa finalizada. Parabéns, você ganhou 2 moedas!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }
}
