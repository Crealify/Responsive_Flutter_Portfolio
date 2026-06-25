import 'package:flutter/material.dart';
import 'portfolio_mixins/portfolio_base_controller.dart';
import 'portfolio_mixins/portfolio_config_mixin.dart';
import 'portfolio_mixins/portfolio_resume_mixin.dart';
import 'portfolio_mixins/portfolio_projects_mixin.dart';
import 'portfolio_mixins/portfolio_content_mixin.dart';
import 'portfolio_mixins/portfolio_management_mixin.dart';

class PortfolioController extends PortfolioBaseController
    with
        PortfolioConfigMixin,
        PortfolioResumeMixin,
        PortfolioProjectsMixin,
        PortfolioContentMixin,
        PortfolioManagementMixin {
  
  @override
  void onInit() {
    super.onInit();
    loadAll();
    Future.delayed(const Duration(milliseconds: 1500), () {
      trackVisitor();
    });
  }

  Future<void> loadAll() async {
    hasNetworkError.value = false;
    try {
      await Future.wait([
        loadHero(),
        loadSocial(),
        loadCta(),
      ]);
      _initiateBackgroundLoading();
    } catch (e) {
      debugPrint('PORTFOLIO: Async background loading error: \$e');
      hasNetworkError.value = true;
      Future.delayed(Duration.zero, () => forceStopLoading());
    }
  }

  void _initiateBackgroundLoading() {
    Future.wait([
      loadProjects(),
      loadPlugins(),
      loadExperiences(),
      loadEducations(),
      loadSkills(),
    ]).catchError((e) {
      debugPrint('PORTFOLIO: Tier 2 error: \$e');
      return <void>[];
    });

    Future.wait([
      loadCertifications(),
      loadVideos(),
      loadShorts(),
      loadMemories(),
      loadClients(),
      loadAppPreviews(),
      loadLeaderboard(),
      loadContact(),
    ]).catchError((e) {
      debugPrint('PORTFOLIO: Tier 3 error: \$e');
      return <void>[];
    });
  }
}
