class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? projectUrl;
  
  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.projectUrl,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProjectModel(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      projectUrl: data['projectUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'projectUrl': projectUrl,
    };
  }
}

class ExperienceModel {
  final String id;
  final String company;
  final String role;
  final String duration;
  final String description;

  ExperienceModel({
    required this.id,
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
  });

  factory ExperienceModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ExperienceModel(
      id: documentId,
      company: data['company'] ?? '',
      role: data['role'] ?? '',
      duration: data['duration'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'role': role,
      'duration': duration,
      'description': description,
    };
  }
}

class EducationModel {
  final String id;
  final String institution;
  final String degree;
  final String duration;

  EducationModel({
    required this.id,
    required this.institution,
    required this.degree,
    required this.duration,
  });

  factory EducationModel.fromMap(Map<String, dynamic> data, String documentId) {
    return EducationModel(
      id: documentId,
      institution: data['institution'] ?? '',
      degree: data['degree'] ?? '',
      duration: data['duration'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institution': institution,
      'degree': degree,
      'duration': duration,
    };
  }
}

class CertificateModel {
  final String id;
  final String title;
  final String issuer;
  final String imageUrl;

  CertificateModel({
    required this.id,
    required this.title,
    required this.issuer,
    required this.imageUrl,
  });

  factory CertificateModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CertificateModel(
      id: documentId,
      title: data['title'] ?? '',
      issuer: data['issuer'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'issuer': issuer,
      'imageUrl': imageUrl,
    };
  }
}
