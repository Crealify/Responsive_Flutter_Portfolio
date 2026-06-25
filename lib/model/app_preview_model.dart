class AppPreviewModel {
  final String id;
  final String name;
  final String imageUrl; // Or use an icon identifier if they are icons
  final int order;

  AppPreviewModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'order': order,
    };
  }

  factory AppPreviewModel.fromMap(Map<String, dynamic> map, String id) {
    return AppPreviewModel(
      id: id,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      order: map['order'] ?? 0,
    );
  }
}

List<AppPreviewModel> defaultAppPreviews = [
  AppPreviewModel(id: 'ap1', name: 'E-Commerce App', imageUrl: 'Icons.shopping_bag', order: 0),
  AppPreviewModel(id: 'ap2', name: 'Fitness Tracker', imageUrl: 'Icons.fitness_center', order: 1),
  AppPreviewModel(id: 'ap3', name: 'Social Connect', imageUrl: 'Icons.people', order: 2),
];
