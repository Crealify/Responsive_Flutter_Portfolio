/// Social media links and icons configuration.
class SocialConfig {
  final String linkedin;
  final String linkedinIcon;
  final String github;
  final String githubIcon;
  final String facebook;
  final String facebookIcon;
  final String youtube;
  final String youtubeIcon;
  final String instagram;
  final String instagramIcon;

  SocialConfig({
    required this.linkedin,
    required this.linkedinIcon,
    required this.github,
    required this.githubIcon,
    required this.facebook,
    required this.facebookIcon,
    required this.youtube,
    required this.youtubeIcon,
    required this.instagram,
    required this.instagramIcon,
  });

  factory SocialConfig.defaults() => SocialConfig(
        linkedin: 'https://www.linkedin.com/in/yourusername/',
        linkedinIcon: 'assets/icons/linkedin.svg',
        github: 'https://github.com/yourusername',
        githubIcon: 'assets/icons/github.svg',
        facebook: 'https://www.facebook.com/yourusername',
        facebookIcon: 'assets/icons/facebook.svg',
        youtube: 'https://www.youtube.com/@yourusername',
        youtubeIcon: 'assets/icons/youtube.svg',
        instagram: 'https://www.instagram.com/yourusername',
        instagramIcon: 'assets/icons/instagram.svg',
      );

  factory SocialConfig.fromMap(Map<String, dynamic> data) => SocialConfig(
        linkedin: data['linkedin'] ?? '',
        linkedinIcon: data['linkedinIcon'] ?? 'assets/icons/linkedin.svg',
        github: data['github'] ?? '',
        githubIcon: data['githubIcon'] ?? 'assets/icons/github.svg',
        facebook: data['facebook'] ?? '',
        facebookIcon: data['facebookIcon'] ?? 'assets/icons/facebook.svg',
        youtube: data['youtube'] ?? '',
        youtubeIcon: data['youtubeIcon'] ?? 'assets/icons/youtube.svg',
        instagram: data['instagram'] ?? '',
        instagramIcon: data['instagramIcon'] ?? 'assets/icons/instagram.svg',
      );

  Map<String, dynamic> toMap() => {
        'linkedin': linkedin,
        'linkedinIcon': linkedinIcon,
        'github': github,
        'githubIcon': githubIcon,
        'facebook': facebook,
        'facebookIcon': facebookIcon,
        'youtube': youtube,
        'youtubeIcon': youtubeIcon,
        'instagram': instagram,
        'instagramIcon': instagramIcon,
      };
}
