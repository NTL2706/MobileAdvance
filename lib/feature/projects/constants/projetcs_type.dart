class Project {
  String id;
  String name;
  DateTime createdAt;
  int numberOfPeople;
  List<int> time;
  List<String> describe;
  bool isFavourite;

  Project(this.id, this.name, this.createdAt, this.numberOfPeople, this.time,
      this.describe, this.isFavourite);
}
