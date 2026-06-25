export 'social_config.dart';
export 'contact_config.dart';
export 'cta_config.dart';

/// Represents the complete hero section configuration stored in Firestore.
class HeroConfig {
  final String greeting;
  final String name;
  final String title;
  final String description;
  final String ctaText;
  final String resumeUrl;
  final String photoUrl;

  HeroConfig({
    required this.greeting,
    required this.name,
    required this.title,
    required this.description,
    required this.ctaText,
    required this.resumeUrl,
    required this.photoUrl,
  });

  factory HeroConfig.defaults() => HeroConfig(
        greeting: 'Hi, I am',
        name: 'Anil Bhattarai.',
        title: 'Full Stack Engineer',
        description: 'Computer Engineering Graduate & Flutter Engineer specializing in high-performance cross-platform mobile and web applications, building scalable, production-ready digital products with clean architecture and seamless user experiences. Passionate about solving real-world problems through modern software solutions.',
        ctaText: 'Explore My Work',
        resumeUrl: '',
        photoUrl: '',
      );

  factory HeroConfig.fromMap(Map<String, dynamic> data) => HeroConfig(
        greeting: data['greeting'] ?? 'Hi, I am',
        name: data['name'] ?? 'Anil Bhattarai.',
        title: data['title'] ?? 'Full Stack Engineer',
        description: data['description'] ?? '',
        ctaText: data['ctaText'] ?? 'Explore My Work',
        resumeUrl: data['resumeUrl'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'greeting': greeting,
        'name': name,
        'title': title,
        'description': description,
        'ctaText': ctaText,
        'resumeUrl': resumeUrl,
        'photoUrl': photoUrl,
      };

  HeroConfig copyWith({
    String? greeting,
    String? name,
    String? title,
    String? description,
    String? ctaText,
    String? resumeUrl,
    String? photoUrl,
  }) =>
      HeroConfig(
        greeting: greeting ?? this.greeting,
        name: name ?? this.name,
        title: title ?? this.title,
        description: description ?? this.description,
        ctaText: ctaText ?? this.ctaText,
        resumeUrl: resumeUrl ?? this.resumeUrl,
        photoUrl: photoUrl ?? this.photoUrl,
      );
}
