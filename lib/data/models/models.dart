class Plant {
  final String id;
  final String name;
  final String imagePath;
  final DateTime dateAdded;
  final String? notes;

  Plant({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.dateAdded,
    this.notes,
  });
}
