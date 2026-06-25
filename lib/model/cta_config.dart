/// Call-to-action (CTA) section configuration.
class CtaConfig {
  final String headline;
  final String subtext;
  final String primaryButtonText;
  final String primaryButtonLink;
  final String secondaryButtonText;
  final String footerText;

  CtaConfig({
    required this.headline,
    required this.subtext,
    required this.primaryButtonText,
    required this.primaryButtonLink,
    required this.secondaryButtonText,
    required this.footerText,
  });

  factory CtaConfig.defaults() => CtaConfig(
    headline: 'Got an idea? Let’s build something that actually works.',
    subtext:
        'If you have an idea or project in mind, I’d be happy to discuss and help bring it to life.',
    primaryButtonText: 'Start a Project',
    primaryButtonLink: 'mailto:bhattaraianil2015@gmail.com',
    secondaryButtonText: 'View Projects',
    footerText: '© 2026 Anil Bhattarai — Built with purpose, not templates.',
  );

  factory CtaConfig.fromMap(Map<String, dynamic> data) => CtaConfig(
    headline:
        data['headline'] ??
        'Got an idea? Let’s build something that actually works.',
    subtext:
        data['subtext'] ??
        'If you have an idea or project in mind, I’d be happy to discuss and help bring it to life.',
    primaryButtonText: data['primaryButtonText'] ?? 'Start a Project',
    primaryButtonLink: data['primaryButtonLink'] ?? 'mailto:crealify@gmail.com',
    secondaryButtonText: data['secondaryButtonText'] ?? 'View Projects',
    footerText:
        data['footerText'] ??
        '© 2026 Anil Bhattarai — Built with purpose, not templates.',
  );

  Map<String, dynamic> toMap() => {
    'headline': headline,
    'subtext': subtext,
    'primaryButtonText': primaryButtonText,
    'primaryButtonLink': primaryButtonLink,
    'secondaryButtonText': secondaryButtonText,
    'footerText': footerText,
  };
}
