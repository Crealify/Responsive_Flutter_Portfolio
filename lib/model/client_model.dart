class Client {
  final String id;
  final String name;
  final String role;
  final String feedback;
  final int rating;
  final int order;

  const Client({
    required this.id,
    required this.name,
    required this.role,
    required this.feedback,
    required this.rating,
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role,
      'feedback': feedback,
      'rating': rating,
      'order': order,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map, String id) {
    return Client(
      id: id,
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      feedback: map['feedback'] ?? '',
      rating: map['rating'] ?? 5,
      order: map['order'] ?? 0,
    );
  }

  Client copyWith({
    String? id,
    String? name,
    String? role,
    String? feedback,
    int? rating,
    int? order,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      feedback: feedback ?? this.feedback,
      rating: rating ?? this.rating,
      order: order ?? this.order,
    );
  }
}

List<Client> defaultClientList = [
  const Client(
    id: "c1",
    name: "John Doe",
    role: "CEO, Company Name",
    feedback: "This developer provided exceptional services. Their technical expertise and attention to detail are truly impressive.",
    rating: 5,
    order: 0,
  ),
  const Client(
    id: "c2",
    name: "Jane Smith",
    role: "Founder, Startup Inc.",
    feedback: "Highly recommended! They built a professional and responsive application for our business perfectly tailored to our requirements.",
    rating: 5,
    order: 1,
  ),
];
