class Experience {
  final String id;
  final String title;
  final String company;
  final String duration;
  final String image;
  final List<String> responsibilities;
  final int order;

  Experience({
    this.id = '',
    required this.title,
    required this.company,
    required this.duration,
    required this.image,
    required this.responsibilities,
    this.order = 0,
  });

  factory Experience.fromMap(Map<String, dynamic> data, String documentId) =>
      Experience(
        id: documentId,
        title: data['title'] ?? '',
        company: data['company'] ?? '',
        duration: data['duration'] ?? '',
        image: data['image'] ?? '',
        responsibilities: List<String>.from(data['responsibilities'] ?? []),
        order: data['order'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'company': company,
        'duration': duration,
        'image': image,
        'responsibilities': responsibilities,
        'order': order,
      };

  Experience copyWith({
    String? id,
    String? title,
    String? company,
    String? duration,
    String? image,
    List<String>? responsibilities,
    int? order,
  }) =>
      Experience(
        id: id ?? this.id,
        title: title ?? this.title,
        company: company ?? this.company,
        duration: duration ?? this.duration,
        image: image ?? this.image,
        responsibilities: responsibilities ?? this.responsibilities,
        order: order ?? this.order,
      );
}

List<Experience> get defaultExperienceList => [
      Experience(
        title: 'Software Engineer',
        company: 'Company Name\nCity, Country',
        duration: 'Jan 2023\nPresent',
        image: 'assets/images/flutter.png',
        responsibilities: [
          'Developed cross-platform apps using Flutter and Dart',
          'Collaborated with designers and product managers in an Agile environment',
        ],
        order: 0,
      ),
      Experience(
        title: 'Intern',
        company: 'Startup Name\nCity, Country',
        duration: 'Jun 2022\nDec 2022',
        image: 'assets/images/flutter.png',
        responsibilities: [
          'Assisted in building RESTful APIs using Node.js',
          'Wrote unit tests and improved code coverage by 20%',
        ],
        order: 1,
      ),
    ];

List<Experience> experienceList = [];
