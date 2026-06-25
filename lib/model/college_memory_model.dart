class CollegeMemory {
  final String id;
  final String imagePath;
  final String title;
  final bool isVertical;
  final int order;

  const CollegeMemory({
    required this.id,
    required this.imagePath,
    required this.title,
    this.isVertical = false,
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'title': title,
      'isVertical': isVertical,
      'order': order,
    };
  }

  factory CollegeMemory.fromMap(Map<String, dynamic> map, String id) {
    return CollegeMemory(
      id: id,
      imagePath: map['imagePath'] ?? '',
      title: map['title'] ?? '',
      isVertical: map['isVertical'] ?? false,
      order: map['order'] ?? 0,
    );
  }

  CollegeMemory copyWith({
    String? id,
    String? imagePath,
    String? title,
    bool? isVertical,
    int? order,
  }) {
    return CollegeMemory(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      isVertical: isVertical ?? this.isVertical,
      order: order ?? this.order,
    );
  }
}

List<CollegeMemory> defaultHorizontalMemories = [
  const CollegeMemory(
    id: "h1",
    imagePath: "assets/images/placeholder.jpg",
    title: "Memory 1",
    order: 0,
  ),
];

List<CollegeMemory> defaultVerticalMemories = [
  const CollegeMemory(
    id: "v1",
    imagePath: "assets/images/placeholder.jpg",
    title: "Vertical Memory 1",
    isVertical: true,
    order: 0,
  ),
];
