class AwardModel {
  final String id;
  final String title;
  final String issuer;
  final String date;
  final String description;
  final String iconUrl;
  final String link;
  final int order;

  const AwardModel({
    required this.id,
    required this.title,
    required this.issuer,
    required this.date,
    required this.description,
    this.iconUrl = '',
    this.link = '',
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'issuer': issuer,
      'date': date,
      'description': description,
      'iconUrl': iconUrl,
      'link': link,
      'order': order,
    };
  }

  factory AwardModel.fromMap(Map<String, dynamic> map, String id) {
    return AwardModel(
      id: id,
      title: map['title'] ?? '',
      issuer: map['issuer'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? '',
      iconUrl: map['iconUrl'] ?? '',
      link: map['link'] ?? '',
      order: map['order'] ?? 0,
    );
  }

  AwardModel copyWith({
    String? id,
    String? title,
    String? issuer,
    String? date,
    String? description,
    String? iconUrl,
    String? link,
    int? order,
  }) {
    return AwardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      issuer: issuer ?? this.issuer,
      date: date ?? this.date,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      link: link ?? this.link,
      order: order ?? this.order,
    );
  }
}

List<AwardModel> defaultAwardsList = [
  const AwardModel(
    id: "a1",
    title: "National Tech Innovation Award",
    issuer: "Ministry of Science & Technology",
    date: "2024",
    description: "Awarded for exceptional contributions to sustainable IoT and smart infrastructure engineering across the region.",
    iconUrl: "https://cdn-icons-png.flaticon.com/512/3135/3135692.png",
    link: "https://linkedin.com",
    order: 0,
  ),
  const AwardModel(
    id: "a2",
    title: "Best Mobile Application Design",
    issuer: "Flutter Developer Community",
    date: "2023",
    description: "Recognized for building the most intuitive and buttery-smooth user interface in a commercial fintech app.",
    iconUrl: "https://cdn-icons-png.flaticon.com/512/825/825501.png",
    link: "https://github.com",
    order: 1,
  ),
  const AwardModel(
    id: "a3",
    title: "Publication: Advanced System Architectures",
    issuer: "IEEE Tech Journal",
    date: "2022",
    description: "Published a peer-reviewed article on optimizing hardware-software integration for next-generation smart hotels.",
    iconUrl: "https://cdn-icons-png.flaticon.com/512/2921/2921222.png",
    link: "https://ieee.org",
    order: 2,
  ),
];
