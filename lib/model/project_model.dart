class Project {
  final String id;
  final String name;
  final String description;
  final String image;
  final String link;
  final List<String> technologies;
  final int order;

  Project({
    this.id = '',
    required this.name,
    required this.description,
    required this.image,
    required this.link,
    required this.technologies,
    this.order = 0,
  });

  factory Project.fromMap(Map<String, dynamic> data, String documentId) =>
      Project(
        id: documentId,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        image: data['image'] ?? '',
        link: data['link'] ?? '',
        technologies: List<String>.from(data['technologies'] ?? []),
        order: data['order'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'image': image,
        'link': link,
        'technologies': technologies,
        'order': order,
      };

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? link,
    List<String>? technologies,
    int? order,
  }) =>
      Project(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        link: link ?? this.link,
        technologies: technologies ?? this.technologies,
        order: order ?? this.order,
      );
}

List<Project> get defaultProjectList => [
      Project(
        name: 'Project Name 1',
        description: 'A brief description of your first project. Highlight the key features and your role.',
        image: 'assets/images/flutter.png',
        link: 'https://github.com/yourusername',
        technologies: ['Flutter', 'Firebase', 'Dart'],
        order: 1,
      ),
      Project(
        name: 'Project Name 2',
        description: 'A brief description of your second project. Highlight the key features and your role.',
        image: 'assets/images/flutter.png',
        link: 'https://github.com/yourusername',
        technologies: ['React', 'Node.js', 'MongoDB'],
        order: 2,
      ),
    ];

// Keep backward-compat mutable list that views can reference
List<Project> projectList = [];
