class Plugin {
  final String id;
  final String name;
  final String description;
  final String image;
  final String link;
  final List<String> technologies;
  final int order;

  Plugin({
    this.id = '',
    required this.name,
    required this.description,
    required this.image,
    required this.link,
    required this.technologies,
    this.order = 0,
  });

  factory Plugin.fromMap(Map<String, dynamic> data, String documentId) =>
      Plugin(
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

  Plugin copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? link,
    List<String>? technologies,
    int? order,
  }) =>
      Plugin(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        link: link ?? this.link,
        technologies: technologies ?? this.technologies,
        order: order ?? this.order,
      );
}

List<Plugin> get defaultPluginList => [
      Plugin(
        name: 'Animated Notch Bottom Bar',
        description:
            'A uniquely designed, highly customizable animated notch bottom navigation bar for Flutter. Published on pub.dev and verified by anil-bhattarai.com.np.',
        image: 'assets/icons/github.svg',
        link: 'https://pub.dev/packages/bottom_navigation_animated_notch_bar',
        technologies: [
          'Flutter',
          'Dart',
          'Animation',
          'Open Source'
        ],
        order: 0,
      ),
      Plugin(
        name: 'lifecycle_guard',
        description:
            'Published Flutter plugin on pub.dev with support for Android and iOS. Solves background execution reliability issues in mobile applications.',
        image: 'assets/icons/github.svg',
        link: 'https://pub.dev/packages/lifecycle_guard',
        technologies: ['Flutter', 'Android', 'iOS', 'Dart'],
        order: 1,
      ),
    ];
