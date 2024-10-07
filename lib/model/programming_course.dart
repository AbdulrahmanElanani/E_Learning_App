enum Category {
  all,
  mobiledevelopment,
  webdevelopment,
  ai,
  datascience,
  devops,
}

class ProgrammingCourse {
  final int id;
  final String name;
  final int duration; // Duration in minutes
  final String description;
  final String link;
  final double price;
  final List<String> outlines;
  final List<Category> categories;

  ProgrammingCourse({
    required this.categories,
    required this.outlines,
    required this.price,
    required this.id,
    required this.name,
    required this.duration,
    required this.description,
    required this.link,
  });
}
