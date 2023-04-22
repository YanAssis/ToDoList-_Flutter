class Tarefa {
  String titulo;
  String desc;
  String data;
  bool isFinalizado;
  bool isAtrasado;
  bool isDebitado;

  Tarefa({
    required this.titulo,
    required this.desc,
    required this.data,
    required this.isFinalizado,
    required this.isAtrasado,
    required this.isDebitado,
  });
}
