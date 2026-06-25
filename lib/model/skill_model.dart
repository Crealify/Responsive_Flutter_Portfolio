class Skill {
  final String id;
  final String name;
  final String category;
  final int proficiency; // 1–5 scale
  final int order;

  Skill({
    this.id = '',
    required this.name,
    required this.category,
    required this.proficiency,
    this.order = 0,
  });

  factory Skill.fromMap(Map<String, dynamic> data, String documentId) => Skill(
        id: documentId,
        name: data['name'] ?? '',
        category: data['category'] ?? '',
        proficiency: data['proficiency'] ?? 3,
        order: data['order'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'category': category,
        'proficiency': proficiency,
        'order': order,
      };

  Skill copyWith({
    String? id,
    String? name,
    String? category,
    int? proficiency,
    int? order,
  }) =>
      Skill(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        proficiency: proficiency ?? this.proficiency,
        order: order ?? this.order,
      );
}

List<Skill> get defaultSkillsList => [
      Skill(name: 'Flutter', category: 'Mobile Development', proficiency: 5, order: 0),
      Skill(name: 'Dart', category: 'Programming', proficiency: 5, order: 1),
      Skill(name: 'Firebase', category: 'Backend', proficiency: 4, order: 2),
      Skill(name: 'REST API', category: 'Web Services', proficiency: 4, order: 3),
      Skill(name: 'MERN Stack', category: 'Web Development', proficiency: 4, order: 4),
      Skill(name: 'JavaScript', category: 'Programming', proficiency: 4, order: 5),
      Skill(name: 'TypeScript', category: 'Programming', proficiency: 3, order: 6),
      Skill(name: 'Python', category: 'Programming', proficiency: 3, order: 7),
      Skill(name: 'Arduino', category: 'IoT', proficiency: 4, order: 8),
      Skill(name: 'UI/UX Design', category: 'Design', proficiency: 4, order: 9),
      Skill(name: 'Figma', category: 'Design', proficiency: 4, order: 10),
      Skill(name: 'Git', category: 'Version Control', proficiency: 4, order: 11),
      Skill(name: 'Docker', category: 'DevOps', proficiency: 3, order: 12),
      Skill(name: 'AWS', category: 'Cloud', proficiency: 3, order: 13),
      Skill(name: 'Networking', category: 'IT', proficiency: 4, order: 14),
      Skill(name: 'Cybersecurity', category: 'Security', proficiency: 3, order: 15),
    ];

List<Skill> skillsList = [];
