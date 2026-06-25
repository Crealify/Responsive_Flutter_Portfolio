class Education {
  final String id;
  final String degree;
  final String institution;
  final String location;
  final String duration;
  final String description;
  final String link;
  final int order;

  Education({
    this.id = '',
    required this.degree,
    required this.institution,
    required this.location,
    required this.duration,
    required this.description,
    required this.link,
    this.order = 0,
  });

  factory Education.fromMap(Map<String, dynamic> data, String documentId) =>
      Education(
        id: documentId,
        degree: data['degree'] ?? '',
        institution: data['institution'] ?? '',
        location: data['location'] ?? '',
        duration: data['duration'] ?? '',
        description: data['description'] ?? '',
        link: data['link'] ?? '',
        order: data['order'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
    'degree': degree,
    'institution': institution,
    'location': location,
    'duration': duration,
    'description': description,
    'link': link,
    'order': order,
  };

  Education copyWith({
    String? id,
    String? degree,
    String? institution,
    String? location,
    String? duration,
    String? description,
    String? link,
    int? order,
  }) => Education(
    id: id ?? this.id,
    degree: degree ?? this.degree,
    institution: institution ?? this.institution,
    location: location ?? this.location,
    duration: duration ?? this.duration,
    description: description ?? this.description,
    link: link ?? this.link,
    order: order ?? this.order,
  );
}

List<Education> get defaultEducationList => [
  Education(
    degree: 'Bachelor of Science in Computer Science',
    institution: 'University Name',
    location: 'City, Country',
    duration: '🎓 2024',
    description:
        'Completed Bachelor of Science with a focus on Software Engineering.',
    link: 'https://university.edu/',
    order: 0,
  ),
  Education(
    degree: 'High School Diploma',
    institution: 'High School Name',
    location: 'City, Country',
    duration: '🎓 2020',
    description: 'Major in Science and Mathematics',
    link: 'https://highschool.edu/',
    order: 1,
  ),
];

List<Education> educationList = [];
