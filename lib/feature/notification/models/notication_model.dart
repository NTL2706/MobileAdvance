
enum NoticationType{
  invited,
  submitted,
  message,
  offered
}

class NoticationModel{
  String? content;
  String? type;
  String? createAt;
  NoticationModel(
    {
      this.content,
      this.type,
      this.createAt
    }
  );
}