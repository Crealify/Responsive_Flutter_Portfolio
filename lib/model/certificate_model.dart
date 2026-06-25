class CertificateModel {
  final String id;
  final String name;
  final String organization;
  final String date;
  final String skills;
  final String credential;
  final int order;

  CertificateModel({
    this.id = '',
    required this.name,
    required this.organization,
    required this.date,
    required this.skills,
    required this.credential,
    this.order = 0,
  });

  factory CertificateModel.fromMap(
          Map<String, dynamic> data, String documentId) =>
      CertificateModel(
        id: documentId,
        name: data['name'] ?? '',
        organization: data['organization'] ?? '',
        date: data['date'] ?? '',
        skills: data['skills'] ?? '',
        credential: data['credential'] ?? '',
        order: data['order'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'organization': organization,
        'date': date,
        'skills': skills,
        'credential': credential,
        'order': order,
      };

  CertificateModel copyWith({
    String? id,
    String? name,
    String? organization,
    String? date,
    String? skills,
    String? credential,
    int? order,
  }) =>
      CertificateModel(
        id: id ?? this.id,
        name: name ?? this.name,
        organization: organization ?? this.organization,
        date: date ?? this.date,
        skills: skills ?? this.skills,
        credential: credential ?? this.credential,
        order: order ?? this.order,
      );
}

List<CertificateModel> get defaultCertificateList => [
      CertificateModel(
        name: 'Certificate of Appreciation - Flutter Development',
        organization: 'SMAIT Technology',
        date: 'SEP 2025',
        skills: 'Flutter · Dart · App Store Publishing',
        credential: 'https://smaittechnology.com',
        order: 0,
      ),
      CertificateModel(
        name: 'ICIP (Introduction to Critical Infrastructure Protection)',
        organization: 'OPSWAT Academy',
        date: 'JAN 2025',
        skills: 'Security · Infrastructure Protection',
        credential: 'https://learn.opswatacademy.com/certificate/RmNMNDBYeA',
        order: 1,
      ),
      CertificateModel(
        name: 'Door Security System with AI',
        organization: 'Lec Expo',
        date: 'JUN 2024',
        skills: 'AI · Security Systems',
        credential: 'https://lecexpo.com/certificates',
        order: 2,
      ),
      CertificateModel(
        name: 'Robotics & IoT',
        organization: 'Dursikshya',
        date: 'JAN 2024',
        skills: 'Robotics · IoT · Arduino',
        credential: 'https://dursikshya.com/certificates',
        order: 3,
      ),
      CertificateModel(
        name: 'Front-End Development with React',
        organization: 'Online Course',
        date: 'SEP 2023',
        skills: 'React · JavaScript · Web Development',
        credential: 'https://react-certificates.com',
        order: 4,
      ),
    ];

List<CertificateModel> certificateList = [];
