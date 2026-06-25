import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'portfolio_base_controller.dart';

mixin PortfolioManagementMixin on PortfolioBaseController {
  Future<void> trackVisitor() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateTime.now().toIso8601String().split('T')[0];
      final lastVisit = prefs.getString('last_visit_date');

      if (lastVisit != today) {
        await svc.trackAction('visit_total');
        await prefs.setString('last_visit_date', today);

        try {
          final response = await http
              .get(Uri.parse('https://ipapi.co/json/'))
              .timeout(const Duration(seconds: 4));
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final country = data['country_name'] ?? 'Unknown';
            await svc.logTrafficOrigin(country);
          } else {
            await svc.logTrafficOrigin('Unknown');
          }
        } catch (e) {
          debugPrint('TELEMETRY: Background traffic origin check failed (handled): \$e');
          await svc.logTrafficOrigin('Unknown');
        }
      }
    } catch (e) {
      debugPrint('TELEMETRY: Info tracking visitor (handled): \$e');
    }
  }

  Future<void> trackAction(String action) async {
    await svc.trackAction(action);
  }

  Future<void> loadAnalytics() async {
    isAnalyticsLoading.value = true;
    analyticsData.value = await svc.getAnalytics();
    _updatePeakMetrics();
    isAnalyticsLoading.value = false;
  }

  Future<void> loadAnalyticsForPeriod(int days) async {
    isAnalyticsLoading.value = true;
    selectedAnalyticsDays.value = days;
    analyticsData.value = await svc.getAnalyticsForPeriod(days);
    _updatePeakMetrics();
    isAnalyticsLoading.value = false;
  }

  void _updatePeakMetrics() {
    if (analyticsData.isEmpty) return;

    final hourlyData = svc.calculatePeakHour(analyticsData);
    peakHourlyData.clear();
    hourlyData.forEach((hour, count) {
      peakHourlyData['$hour'] = count;
    });

    int maxCount = 0;
    int peakHourValue = 0;
    hourlyData.forEach((hour, count) {
      if (count > maxCount) {
        maxCount = count;
        peakHourValue = hour;
      }
    });

    if (maxCount > 0) {
      final hour12 = peakHourValue % 12 == 0 ? 12 : peakHourValue % 12;
      final period = peakHourValue >= 12 ? 'PM' : 'AM';
      peakHour.value = '$hour12:00 $period (GMT+5:45)';
    } else {
      peakHour.value = 'No data available';
    }

    peakDay.value = svc.calculatePeakDay(analyticsData) ?? '';
  }

  void syncAdminData() {
    loadAnalytics();
    intrusionLogs.bindStream(svc.intrusionLogsStream());
    trafficOrigins.bindStream(svc.trafficOriginsStream());
  }

  Future<void> loadTodos() async {
    adminTodos.assignAll(await svc.getTodos());
  }

  Future<void> loadNotes() async {
    adminNotes.assignAll(await svc.getNotes());
  }

  Future<void> loadCashTransactions() async {
    cashTransactions.assignAll(await svc.getCashTransactions());
  }
  
  void refreshCash() => loadCashTransactions();
}
