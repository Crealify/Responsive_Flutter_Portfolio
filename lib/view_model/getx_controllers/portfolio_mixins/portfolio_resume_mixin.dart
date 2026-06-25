import 'package:get/get.dart';
import '../../../model/experience_model.dart';
import '../../../model/education_model.dart';
import '../../../model/certificate_model.dart';
import '../../../model/skill_model.dart';
import '../../../services/local_cache_service.dart';
import 'portfolio_base_controller.dart';

mixin PortfolioResumeMixin on PortfolioBaseController {
  Future<void> loadExperiences() async {
    try {
      isExperienceLoading.value = true;
      final cached = await LocalCacheService().getList('experiences');
      if (cached != null && cached.isNotEmpty) {
        experiences.assignAll(cached.map((e) => Experience.fromMap(e, e['id'] ?? '')).toList());
        experienceList = experiences.toList();
      }

      var list = await svc.getExperiences();
      if (list.isEmpty) {
        await svc.seedExperiences();
        list = await svc.getExperiences();
      }

      if (list.isNotEmpty) {
        experiences.assignAll(list);
        experienceList = list;
        await LocalCacheService().saveList('experiences', list.map((e) => e.toMap()).toList());
      }
    } finally {
      isExperienceLoading.value = false;
    }
  }

  Future<void> loadEducations() async {
    try {
      isEducationLoading.value = true;
      var list = await svc.getEducations();
      final bool needsSync = list.isEmpty ||
          !list.any((e) => e.degree == 'BE in Computer Engineering') ||
          !list.any((e) => e.degree == '+2 in Science');

      if (needsSync) {
        await svc.seedEducations();
        list = await svc.getEducations();
      }

      if (list.isNotEmpty) {
        educations.assignAll(list);
        educationList = list;
      }
    } finally {
      isEducationLoading.value = false;
    }
  }

  Future<void> loadCertifications() async {
    try {
      isCertificationsLoading.value = true;
      var list = await svc.getCertifications();
      if (list.isEmpty) {
        await svc.seedCertifications();
        list = await svc.getCertifications();
      }

      if (list.isNotEmpty) {
        certifications.assignAll(list);
        certificateList = list;
      }
    } finally {
      isCertificationsLoading.value = false;
    }
  }

  Future<void> loadSkills() async {
    try {
      isSkillsLoading.value = true;
      var list = await svc.getSkills();
      if (list.isEmpty) {
        await svc.seedSkills();
        list = await svc.getSkills();
      }

      if (list.isNotEmpty) {
        skills.assignAll(list);
        skillsList = list;
      }
    } finally {
      isSkillsLoading.value = false;
    }
  }

  void refreshExperiences() => loadExperiences();
  void refreshEducations() => loadEducations();
  void refreshCertifications() => loadCertifications();
  void refreshSkills() => loadSkills();
}
