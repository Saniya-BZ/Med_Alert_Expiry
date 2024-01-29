class Medicine {
  final int id;
  final String name;
  final String type;
  final String description;
  final String dosage;
  final String price;
  final List<String> tags;

  Medicine({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.dosage,
    required this.price,
    required this.tags,
  });
}