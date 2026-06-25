import 'package:flutter/material.dart';

/// Centralized application constants following the 60/30/10 design rule.
class AppConstants {
  // ─── Tiered Surface System ───
  static const Color bgColor = Color(0xFF030712); // L0: Deepest Space Slate (Apple Vision Pro/Linear style)
  static const Color darkColor = Color(0x05FFFFFF); // L1: Sidebar/Nav (~2% white)
  static const Color cardColor = Color(0xFF07111F); // L2: Slate Glass Card Background (#07111F)
  static const Color surfaceL2 = Color(0x1F3F6BF5); // L2: Premium Indigo-Blue Glass Card Background
  static const Color surfaceL3 = Color(0x22FFFFFF); // L3: Active Slate (Modals/Highlights - ~13% white)

  // ─── Admin Dashboard Design Tokens ───
  /// Background color for all admin cards and list item containers.
  static const Color adminCardColor = surfaceL2;
  /// Border color for all admin cards and containers.
  static const Color adminCardBorder = Color(0x0FFFFFFF); // ~6% white
  /// Standard corner radius for admin list item cards.
  static const double adminCardRadius = 16.0;
  /// Larger corner radius for featured/section admin cards.
  static const double adminSectionCardRadius = 24.0;
  /// Background color for the upload PDF / text field fill.
  static const Color adminFieldFill = surfaceL2;
  
  // ─── High-Contrast Accents ───
  static const Color primaryColor = Color(0xFF8B5CF6); // Premium Violet (#8B5CF6)
  static const Color secondaryColor = Color(0xFF3B82F6); // Premium Blue (#3B82F6)
  static const Color activeIconColor = Color(0xFF06B6D4); // Premium Cyan (#06B6D4)
  
  // ─── Typography ───
  static const Color bodyTextColor = Color(0xFFE2E8F0); // Slate-200 (High contrast)
  static const Color subtitleColor = Color(0xFF94A3B8); // Slate-400 (Secondary)
  static const Color locationTextColor = Color(0xCC94A3B8); // Slate-400 at 80% — Location labels (Education/Experience)
  static const Color inactiveColor = Color(0xFF475569); // Slate-600 (Inactive)

  // Glow
  static const Color accentGlow = Color(0x1A8B5CF6); // Soft Violet Glow

  // Spacing Scale
  static const double defaultPadding = 20.0;
  static const double spacing8 = 8.0;
  static const double spacing10 = 10.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing36 = 36.0;
  static const double spacing40 = 40.0;
  static const double spacing42 = 42.0;
  static const double spacing48 = 48.0;
  static const double spacing50 = 50.0;
  static const double spacing56 = 56.0;
  static const double spacing60 = 60.0;
  static const double spacing64 = 64.0;
  static const double spacing68 = 68.0;
  static const double spacing70 = 70.0;

  // Aliases
  static const Color glassColor = Color(0x1AFFFFFF);
  // Radius
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius24 = 24.0;
  static const double radius32 = 32.0;

  static double getResponsivePadding(BuildContext context) {
    return spacing24;
  }
}

// Global aliases for backward compatibility (can be removed after full refactor)
const bgColor = AppConstants.bgColor;
const cardColor = AppConstants.cardColor;
const surfaceL2 = AppConstants.surfaceL2;
const darkColor = AppConstants.darkColor;
const primaryColor = AppConstants.primaryColor;
const secondaryColor = AppConstants.secondaryColor;
const bodyTextColor = AppConstants.bodyTextColor;
const defaultPadding = AppConstants.defaultPadding;
const spacing8 = AppConstants.spacing8;
const spacing10 = AppConstants.spacing10;
const spacing12 = AppConstants.spacing12;
const spacing16 = AppConstants.spacing16;
const spacing24 = AppConstants.spacing24;
const spacing32 = AppConstants.spacing32;
const spacing40 = AppConstants.spacing40;
const spacing48 = AppConstants.spacing48;
const spacing64 = AppConstants.spacing64;
const spacing68 = AppConstants.spacing68;
const spacing70 = AppConstants.spacing70;
const glassColor = AppConstants.glassColor;
// Admin design tokens
const adminCardColor = AppConstants.adminCardColor;
const adminCardBorder = AppConstants.adminCardBorder;
const adminCardRadius = AppConstants.adminCardRadius;
const adminSectionCardRadius = AppConstants.adminSectionCardRadius;
const adminFieldFill = AppConstants.adminFieldFill;
