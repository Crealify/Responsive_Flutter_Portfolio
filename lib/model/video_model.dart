class VideoModel {
  final String id;
  final String title;
  final String videoId; // The YouTube ID
  final int order;

  VideoModel({
    required this.id,
    required this.title,
    required this.videoId,
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'videoId': videoId,
      'order': order,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map, String id) {
    return VideoModel(
      id: id,
      title: map['title'] ?? '',
      videoId: map['videoId'] ?? '',
      order: map['order'] ?? 0,
    );
  }

  VideoModel copyWith({
    String? id,
    String? title,
    String? videoId,
    int? order,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      videoId: videoId ?? this.videoId,
      order: order ?? this.order,
    );
  }
}

List<VideoModel> defaultVideoList = [
  VideoModel(
    id: "v1",
    videoId: "VENO1naGC1w",
    title: "How to register .com.np domain",
    order: 0,
  ),
  VideoModel(
    id: "v2",
    videoId: "hc4X7syafaQ",
    title: "LEC EXPO-2024",
    order: 1,
  ),
  VideoModel(
    id: "v3",
    videoId: "0jNgI0mTemU",
    title: "Engineering College Farewell Program 2079",
    order: 2,
  ),
];
