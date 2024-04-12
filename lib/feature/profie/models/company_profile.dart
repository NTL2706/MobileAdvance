class Company {
  int? id;
  String name;
  int numberOfEmployees;
  String address;
  String website;
  String description;

  Company({
    this.id,
    required this.name,
    required this.numberOfEmployees,
    required this.address,
    required this.website,
    required this.description,
  });
}
