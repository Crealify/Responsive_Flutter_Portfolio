class ShortsModel {
  final String id;
  final String title;
  final String url;
  final String videoId;
  final bool isYouTube;
  final int order;

  const ShortsModel({
    required this.id,
    required this.title,
    required this.url,
    this.videoId = '',
    this.isYouTube = true,
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'videoId': videoId,
      'isYouTube': isYouTube,
      'order': order,
    };
  }

  factory ShortsModel.fromMap(Map<String, dynamic> map, String id) {
    return ShortsModel(
      id: id,
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      videoId: map['videoId'] ?? '',
      isYouTube: map['isYouTube'] ?? true,
      order: map['order'] ?? 0,
    );
  }

  ShortsModel copyWith({
    String? id,
    String? title,
    String? url,
    String? videoId,
    bool? isYouTube,
    int? order,
  }) {
    return ShortsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      videoId: videoId ?? this.videoId,
      isYouTube: isYouTube ?? this.isYouTube,
      order: order ?? this.order,
    );
  }
}

List<ShortsModel> defaultShortsList = [
  const ShortsModel(
    id: "s1",
    videoId: "7X80uR64mZ8",
    title: "Arduino Projects",
    url: "https://www.youtube.com/shorts/7X80uR64mZ8",
    order: 0,
  ),
  const ShortsModel(
    id: "s2",
    videoId: "1071538010636950",
    title: "Late Night Projects",
    url: "https://www.facebook.com/100052364679499/videos/pcb.900588045030010/1071538010636950",
    isYouTube: false,
    order: 1,
  ),
  const ShortsModel(
    id: "s3",
    videoId: "1679349629948848",
    title: "Last College Tour",
    url: "https://www.facebook.com/reel/1679349629948848",
    isYouTube: false,
    order: 2,
  ),
  const ShortsModel(
    id: "s4",
    videoId: "1127838886162318",
    title: "Farewell Vibes",
    url: "https://www.facebook.com/reel/1127838886162318",
    isYouTube: false,
    order: 3,
  ),
];
