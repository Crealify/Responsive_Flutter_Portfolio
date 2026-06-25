import '../model/project_model.dart';
import '../model/plugin_model.dart';
import '../model/experience_model.dart';
import '../model/education_model.dart';
import '../model/certificate_model.dart';
import '../model/skill_model.dart';
import '../model/video_model.dart';
import '../model/shorts_model.dart';
import '../model/college_memory_model.dart';
import '../model/client_model.dart';
import '../model/app_preview_model.dart';
import '../model/award_model.dart';
import '../model/hero_config.dart';

class MockDataService {
  Future<List<Project>> getProjects() async => defaultProjectList;
  Future<void> seedProjects() async {}
  Future<void> addProject(Project p) async {}
  Future<void> updateProject(Project p) async {}
  Future<void> deleteProject(String id) async {}

  Future<List<Plugin>> getPlugins() async => defaultPluginList;
  Future<void> seedPlugins() async {}
  Future<void> addPlugin(Plugin p) async {}
  Future<void> updatePlugin(Plugin p) async {}
  Future<void> deletePlugin(String id) async {}

  Future<List<Experience>> getExperiences() async => defaultExperienceList;
  Future<void> seedExperiences() async {}
  Future<void> addExperience(Experience e) async {}
  Future<void> updateExperience(Experience e) async {}
  Future<void> deleteExperience(String id) async {}

  Future<List<Education>> getEducations() async => defaultEducationList;
  Future<void> seedEducations() async {}
  Future<void> addEducation(Education e) async {}
  Future<void> updateEducation(Education e) async {}
  Future<void> deleteEducation(String id) async {}

  Future<List<CertificateModel>> getCertifications() async => defaultCertificateList;
  Future<void> seedCertifications() async {}
  Future<void> addCertification(CertificateModel c) async {}
  Future<void> updateCertification(CertificateModel c) async {}
  Future<void> deleteCertification(String id) async {}

  Future<List<Skill>> getSkills() async => defaultSkillsList;
  Future<void> seedSkills() async {}
  Future<void> addSkill(Skill s) async {}
  Future<void> updateSkill(Skill s) async {}
  Future<void> deleteSkill(String id) async {}

  Future<List<VideoModel>> getVideos() async => defaultVideoList;
  Future<void> seedVideos() async {}
  Future<void> addVideo(VideoModel v) async {}
  Future<void> updateVideo(VideoModel v) async {}
  Future<void> deleteVideo(String id) async {}

  Future<List<ShortsModel>> getShorts() async => defaultShortsList;
  Future<void> seedShorts() async {}
  Future<void> addShort(ShortsModel s) async {}
  Future<void> updateShort(ShortsModel s) async {}
  Future<void> deleteShort(String id) async {}

  Future<List<CollegeMemory>> getMemories() async => [...defaultHorizontalMemories, ...defaultVerticalMemories];
  Future<void> seedMemories() async {}
  Future<void> addMemory(CollegeMemory m) async {}
  Future<void> updateMemory(CollegeMemory m) async {}
  Future<void> deleteMemory(String id) async {}

  Future<List<Client>> getClients() async => defaultClientList;
  Future<void> seedClients() async {}
  Future<void> addClient(Client c) async {}
  Future<void> updateClient(Client c) async {}
  Future<void> deleteClient(String id) async {}

  Future<List<AppPreviewModel>> getAppPreviews() async => defaultAppPreviews;
  Future<void> seedAppPreviews() async {}
  Future<void> addAppPreview(AppPreviewModel a) async {}
  Future<void> updateAppPreview(AppPreviewModel a) async {}
  Future<void> deleteAppPreview(String id) async {}

  Future<List<AwardModel>> getAwards() async => defaultAwardsList;
  Future<void> seedAwards() async {}
  Future<void> addAward(AwardModel a) async {}
  Future<void> updateAward(AwardModel a) async {}
  Future<void> deleteAward(String id) async {}

  Future<HeroConfig> getHeroConfig() async => HeroConfig.defaults();
  Future<void> updateHero(HeroConfig c) async {}

  Future<SocialConfig> getSocialConfig() async => SocialConfig.defaults();
  Future<void> updateSocial(SocialConfig c) async {}

  Future<ContactConfig> getContactConfig() async => ContactConfig.defaults();
  Future<void> updateContact(ContactConfig c) async {}

  Future<CtaConfig> getCtaConfig() async => CtaConfig.defaults();
  Future<void> updateCta(CtaConfig c) async {}

  Future<Map<String, dynamic>?> getResume() async => {'url': 'https://example.com/resume.pdf'};
  Future<void> updateResume(Map<String, dynamic> data) async {}

  Future<Map<String, dynamic>> getAnalytics([int days = 1]) async => {};
  Future<Map<String, dynamic>> getAnalyticsForPeriod(int days) async => {};
  Future<void> trackVisitor() async {}
  Future<void> trackAction(String action) async {}
  Future<void> logTrafficOrigin() async {}
  Future<void> logIntrusion(String email) async {}
  Future<List<Map<String, dynamic>>> getTrafficOrigins(int days) async => [];
  Future<Map<String, int>> getPeakHourlyData(int days) async => {};
  Future<String> calculatePeakHour(int days) async => '';
  Future<String> calculatePeakDay(int days) async => '';
  Future<List<Map<String, dynamic>>> getIntrusionLogs() async => [];
  Stream<dynamic> get intrusionLogsStream => const Stream.empty();
  Stream<dynamic> get trafficOriginsStream => const Stream.empty();

  Future<List<Map<String, dynamic>>> getTodos() async => [];
  Future<void> addAdminTodo(Map<String, dynamic> todo) async {}
  Future<void> updateAdminTodo(Map<String, dynamic> todo) async {}
  Future<void> deleteAdminTodo(String id) async {}

  Future<List<Map<String, dynamic>>> getNotes() async => [];
  Future<void> addAdminNote(Map<String, dynamic> note) async {}
  Future<void> updateAdminNote(Map<String, dynamic> note) async {}
  Future<void> deleteAdminNote(String id) async {}

  Future<List<Map<String, dynamic>>> getCashTransactions() async => [];
  Future<void> addCashTransaction(Map<String, dynamic> t) async {}
  Future<void> updateCashTransaction({dynamic id, dynamic name, dynamic amount, dynamic desc, dynamic type, dynamic date}) async {}
  Future<void> updateCashOrder(dynamic data) async {}
  Future<void> updateCashStatus(dynamic data) async {}
  Future<void> deleteCashTransaction(String id) async {}

  Future<List<Map<String, dynamic>>> getLeaderboard() async => [];
  Future<void> updateLeaderboard(Map<String, dynamic> data) async {}
  Future<void> addLeaderboardEntry(Map<String, dynamic> data) async {}
  Future<void> deleteLeaderboardEntry(String id) async {}

  Future<List<Map<String, dynamic>>> getBusinessMails() async => [];
  Future<void> submitFeedback(Map<String, dynamic> data) async {}
  Stream<List<Map<String, dynamic>>> contactMessagesStream() => const Stream.empty();
  Future<void> deleteContactMessage(String id) async {}
  Future<void> markContactMessageRead(String id) async {}
  Future<void> submitContactMessage({dynamic name, dynamic email, dynamic subject, dynamic message}) async {}
  Stream<dynamic> get authStateChanges => const Stream.empty();
  Future<dynamic> signInWithGoogle() async => null;
  Future<void> signOut() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      if (invocation.memberName == #authStateChanges) return const Stream.empty();
      if (invocation.memberName == #intrusionLogsStream) return const Stream.empty();
      if (invocation.memberName == #trafficOriginsStream) return const Stream.empty();
      return null;
    }
    return Future.value(null);
  }
}


