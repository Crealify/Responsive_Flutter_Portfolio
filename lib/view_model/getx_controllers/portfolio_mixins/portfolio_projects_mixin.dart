import 'package:get/get.dart';
import '../../../model/project_model.dart';
import '../../../services/local_cache_service.dart';
import 'portfolio_base_controller.dart';

mixin PortfolioProjectsMixin on PortfolioBaseController {
  Future<void> loadProjects() async {
    try {
      isProjectsLoading.value = true;
      
      final cached = await LocalCacheService().getList('projects');
      if (cached != null && cached.isNotEmpty) {
        projects.assignAll(cached.map((e) => Project.fromMap(e, e['id'] ?? '')).toList());
        projectList = projects.toList();
      }

      var list = await svc.getProjects();
      final bool hasOutdatedPlaceholder = list.any((p) => p.image.contains('v07otoxvzkr5aofvvkpz.png'));

      if (list.isEmpty || hasOutdatedPlaceholder) {
        await svc.seedProjects();
        list = await svc.getProjects();
      }

      if (list.isNotEmpty) {
        projects.assignAll(list);
        projectList = list;
        await LocalCacheService().saveList('projects', list.map((e) => e.toMap()).toList());
      }
    } finally {
      isProjectsLoading.value = false;
    }
  }

  Future<void> loadPlugins() async {
    try {
      isPluginsLoading.value = true;
      var list = await svc.getPlugins();
      if (list.isEmpty) {
        await svc.seedPlugins();
        list = await svc.getPlugins();
      }

      if (list.isNotEmpty) {
        plugins.assignAll(list);
      }
    } finally {
      isPluginsLoading.value = false;
    }
  }

  Future<void> loadAppPreviews() async {
    try {
      isPreviewsLoading.value = true;
      var list = await svc.getAppPreviews();
      if (list.isEmpty) {
        await svc.seedAppPreviews();
        list = await svc.getAppPreviews();
      }

      if (list.isNotEmpty) {
        appPreviews.assignAll(list);
      }
    } finally {
      isPreviewsLoading.value = false;
    }
  }

  void refreshProjects() => loadProjects();
  void refreshPlugins() => loadPlugins();
  void refreshAppPreviews() => loadAppPreviews();
}
