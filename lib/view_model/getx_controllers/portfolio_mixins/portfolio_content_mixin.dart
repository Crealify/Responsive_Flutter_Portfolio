import 'package:get/get.dart';
import 'portfolio_base_controller.dart';

mixin PortfolioContentMixin on PortfolioBaseController {
  Future<void> loadVideos() async {
    try {
      isVideosLoading.value = true;
      var list = await svc.getVideos();
      if (list.isEmpty) {
        await svc.seedVideos();
        list = await svc.getVideos();
      }

      if (list.isNotEmpty) {
        videos.assignAll(list);
      }
    } finally {
      isVideosLoading.value = false;
    }
  }

  Future<void> loadShorts() async {
    try {
      isShortsLoading.value = true;
      var list = await svc.getShorts();
      if (list.isEmpty) {
        await svc.seedShorts();
        list = await svc.getShorts();
      }

      if (list.isNotEmpty) {
        shorts.assignAll(list);
      }
    } finally {
      isShortsLoading.value = false;
    }
  }

  Future<void> loadMemories() async {
    try {
      isMemoriesLoading.value = true;
      var list = await svc.getMemories();
      if (list.isEmpty) {
        await svc.seedMemories();
        list = await svc.getMemories();
      }

      if (list.isNotEmpty) {
        memories.assignAll(list);
      }
    } finally {
      isMemoriesLoading.value = false;
    }
  }

  Future<void> loadClients() async {
    try {
      isClientsLoading.value = true;
      var list = await svc.getClients();
      if (list.isEmpty) {
        await svc.seedClients();
        list = await svc.getClients();
      }

      if (list.isNotEmpty) {
        clients.assignAll(list);
      }
    } finally {
      isClientsLoading.value = false;
    }
  }

  Future<void> loadLeaderboard() async {
    try {
      isLeaderboardLoading.value = true;
      final list = await svc.getLeaderboard();
      leaderboard.assignAll(list);
    } finally {
      isLeaderboardLoading.value = false;
    }
  }

  Future<void> addLeaderboardEntry(String name, int score) async {
    await svc.addLeaderboardEntry(name, score);
    await loadLeaderboard();
  }

  Future<void> deleteLeaderboardEntry(String id) async {
    await svc.deleteLeaderboardEntry(id);
    await loadLeaderboard();
  }

  void refreshVideos() => loadVideos();
  void refreshShorts() => loadShorts();
  void refreshMemories() => loadMemories();
  void refreshClients() => loadClients();
  void refreshLeaderboard() => loadLeaderboard();
}
