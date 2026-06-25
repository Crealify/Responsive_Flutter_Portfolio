/// Contact section configuration.
class ContactConfig {
  final String email;
  final String phone;
  final String location;
  final String availability;

  ContactConfig({
    required this.email,
    required this.phone,
    required this.location,
    required this.availability,
  });

  factory ContactConfig.defaults() => ContactConfig(
        email: 'your.email@example.com',
        phone: '+1-234-567-8900',
        location: 'City, Country',
        availability: 'Open to opportunities',
      );

  factory ContactConfig.fromMap(Map<String, dynamic> data) => ContactConfig(
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        location: data['location'] ?? '',
        availability: data['availability'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'phone': phone,
        'location': location,
        'availability': availability,
      };
}
