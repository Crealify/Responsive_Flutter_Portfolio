import 'package:get/get.dart';
import '../../../model/hero_config.dart';
import '../../../model/project_model.dart';
import '../../../model/experience_model.dart';
import '../../../model/education_model.dart';
import '../../../model/certificate_model.dart';
import '../../../model/skill_model.dart';
import '../../../model/video_model.dart';
import '../../../model/shorts_model.dart';
import '../../../model/college_memory_model.dart';
import '../../../model/client_model.dart';
import '../../../model/app_preview_model.dart';
import '../../../model/plugin_model.dart';
import '../../../model/award_model.dart';
import '../../../services/mock_data_service.dart';

abstract class PortfolioBaseController extends GetxController {
  final dynamic svc = MockDataService();

  // ─── Config ───────────────────────────────────────
  final Rx<HeroConfig> heroConfig = HeroConfig.defaults().obs;
  final Rx<SocialConfig> socialConfig = SocialConfig.defaults().obs;
  final Rx<ContactConfig> contactConfig = ContactConfig.defaults().obs;
  final Rx<CtaConfig> ctaConfig = CtaConfig.defaults().obs;

  // ─── Section Data ─────────────────────────────────
  final RxList<Project> projects = RxList<Project>(defaultProjectList);
  final RxList<Plugin> plugins = RxList<Plugin>(defaultPluginList);
  final RxList<Experience> experiences = RxList<Experience>(defaultExperienceList);
  final RxList<Education> educations = RxList<Education>(defaultEducationList);
  final RxList<CertificateModel> certifications = RxList<CertificateModel>(defaultCertificateList);
  final RxList<Skill> skills = RxList<Skill>(defaultSkillsList);
  final RxList<VideoModel> videos = RxList<VideoModel>(defaultVideoList);
  final RxList<ShortsModel> shorts = RxList<ShortsModel>(defaultShortsList);
  final RxList<CollegeMemory> memories = RxList<CollegeMemory>([...defaultHorizontalMemories, ...defaultVerticalMemories]);
  final RxList<Client> clients = RxList<Client>(defaultClientList);
  final RxList<AppPreviewModel> appPreviews = RxList<AppPreviewModel>(defaultAppPreviews);
  final RxList<AwardModel> awards = RxList<AwardModel>(defaultAwardsList);
  final RxList<Map<String, dynamic>> leaderboard = <Map<String, dynamic>>[].obs;

  // ─── Loading States ───────────────────────────────
  final RxBool isHeroLoading = false.obs;
  final RxBool isProjectsLoading = false.obs;
  final RxBool isPluginsLoading = false.obs;
  final RxBool isExperienceLoading = false.obs;
  final RxBool isEducationLoading = false.obs;
  final RxBool isCertificationsLoading = false.obs;
  final RxBool isSkillsLoading = false.obs;
  final RxBool isVideosLoading = false.obs;
  final RxBool isShortsLoading = false.obs;
  final RxBool isMemoriesLoading = false.obs;
  final RxBool isClientsLoading = false.obs;
  final RxBool isPreviewsLoading = false.obs;
  final RxBool isAwardsLoading = false.obs;
  final RxBool isLeaderboardLoading = false.obs;
  
  // ─── Error States ─────────────────────────────────
  final RxBool hasNetworkError = false.obs;

  // ─── Show All (Mobile) ────────────────────────────
  final RxBool showAllProjects = false.obs;
  final RxBool showAllExperience = false.obs;
  final RxBool showAllEducation = false.obs;
  final RxBool showAllCertifications = false.obs;

  // ─── Analytics, Todos & Notes ─────────────────────
  final RxMap<String, dynamic> analyticsData = <String, dynamic>{}.obs;
  final RxList<Map<String, dynamic>> intrusionLogs = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> trafficOrigins = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> adminTodos = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> adminNotes = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> cashTransactions = <Map<String, dynamic>>[].obs;
  final RxBool isAnalyticsLoading = true.obs;

  final RxInt selectedAnalyticsDays = 1.obs;
  final RxMap<String, int> peakHourlyData = <String, int>{}.obs;
  final RxString peakHour = ''.obs;
  final RxString peakDay = ''.obs;

  void forceStopLoading() {
    isHeroLoading.value = false;
    isProjectsLoading.value = false;
    isPluginsLoading.value = false;
    isExperienceLoading.value = false;
    isEducationLoading.value = false;
    isCertificationsLoading.value = false;
    isSkillsLoading.value = false;
    isVideosLoading.value = false;
    isShortsLoading.value = false;
    isMemoriesLoading.value = false;
    isClientsLoading.value = false;
    isPreviewsLoading.value = false;
    isAnalyticsLoading.value = false;
    isLeaderboardLoading.value = false;
  }
}
