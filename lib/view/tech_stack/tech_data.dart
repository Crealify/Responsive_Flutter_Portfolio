class TechSkill {
  final String name;
  final String category;

  TechSkill({required this.name, required this.category});
}

class TechData {
  static final List<TechSkill> premiumIntegrations = [
    TechSkill(name: 'flutter_stripe', category: 'Payments'),
    TechSkill(name: 'esewa_flutter_sdk', category: 'Payments'),
    TechSkill(name: 'khalti_flutter', category: 'Payments'),
  ];

  static final List<TechSkill> techStack = [
    // State Management
    TechSkill(name: 'flutter_riverpod', category: 'State Management'),
    TechSkill(name: 'getX', category: 'State Management'),
    TechSkill(name: 'riverpod_annotation', category: 'State Management'),
    TechSkill(name: 'provider', category: 'State Management'),

    // Authentication
    TechSkill(name: 'google_sign_in', category: 'Authentication'),
    TechSkill(name: 'flutter_facebook_auth', category: 'Authentication'),
    TechSkill(name: 'sign_in_with_apple', category: 'Authentication'),
    TechSkill(
        name: 'local_auth (Fingerprint/FaceID/PIN)',
        category: 'Authentication'),
    TechSkill(name: 'flutter_secure_storage', category: 'Authentication'),

    // Database & Storage
    TechSkill(name: 'hive', category: 'Database & Storage'),
    TechSkill(name: 'hive_flutter', category: 'Database & Storage'),
    TechSkill(name: 'shared_preferences', category: 'Database & Storage'),
    TechSkill(name: 'sqflite', category: 'Database & Storage'),

    // Firebase
    TechSkill(name: 'firebase_core', category: 'Firebase'),
    TechSkill(name: 'firebase_auth', category: 'Firebase'),
    TechSkill(name: 'cloud_firestore', category: 'Firebase'),
    TechSkill(name: 'firebase_storage', category: 'Firebase'),
    TechSkill(name: 'cloud_functions', category: 'Firebase'),
    TechSkill(name: 'firebase_messaging', category: 'Firebase'),
    TechSkill(name: 'firebase_core_web', category: 'Firebase'),

    // Networking
    TechSkill(name: 'dio', category: 'Networking'),
    TechSkill(name: 'http', category: 'Networking'),
    TechSkill(name: 'dio_cookie_manager', category: 'Networking'),
    TechSkill(name: 'cookie_jar', category: 'Networking'),
    TechSkill(name: 'wifi_iot', category: 'Networking'),

    // UI & Animation
    TechSkill(name: 'google_fonts', category: 'UI & Animation'),
    TechSkill(name: 'flutter_svg', category: 'UI & Animation'),
    TechSkill(name: 'flutter_animate', category: 'UI & Animation'),
    TechSkill(name: 'animate_do', category: 'UI & Animation'),
    TechSkill(name: 'lottie', category: 'UI & Animation'),
    TechSkill(name: 'shimmer', category: 'UI & Animation'),
    TechSkill(name: 'glassmorphism', category: 'UI & Animation'),
    TechSkill(name: 'confetti', category: 'UI & Animation'),
    TechSkill(name: 'slide_to_act', category: 'UI & Animation'),
    TechSkill(name: 'flutter_screenutil', category: 'UI & Animation'),
    TechSkill(name: 'skeletonizer', category: 'UI & Animation'),
    TechSkill(name: 'visibility_detector', category: 'UI & Animation'),

    // Charts & Graphs
    TechSkill(name: 'fl_chart', category: 'Charts & Graphs'),
    TechSkill(name: 'graphview', category: 'Charts & Graphs'),

    // Image & Media
    TechSkill(name: 'cached_network_image', category: 'Image & Media'),
    TechSkill(name: 'image_picker', category: 'Image & Media'),
    TechSkill(name: 'photo_view', category: 'Image & Media'),
    TechSkill(name: 'screenshot', category: 'Image & Media'),
    TechSkill(name: 'video_player', category: 'Image & Media'),
    TechSkill(name: 'video_editor', category: 'Image & Media'),
    TechSkill(name: 'audioplayers', category: 'Image & Media'),
    TechSkill(name: 'image', category: 'Image & Media'),

    // File Handling
    TechSkill(name: 'file_picker', category: 'File Handling'),
    TechSkill(name: 'open_filex', category: 'File Handling'),
    TechSkill(name: 'path_provider', category: 'File Handling'),
    TechSkill(name: 'path', category: 'File Handling'),

    // WebView
    TechSkill(name: 'webview_flutter', category: 'WebView'),
    TechSkill(name: 'webview_flutter_android', category: 'WebView'),
    TechSkill(name: 'webview_flutter_wkwebview', category: 'WebView'),
    TechSkill(name: 'webview_flutter_web', category: 'WebView'),
    TechSkill(name: 'flutter_inappwebview', category: 'WebView'),

    // Routing
    TechSkill(name: 'go_router', category: 'Routing'),

    // Utilities
    TechSkill(name: 'intl', category: 'Utilities'),
    TechSkill(name: 'uuid', category: 'Utilities'),
    TechSkill(name: 'crypto', category: 'Utilities'),
    TechSkill(name: 'equatable', category: 'Utilities'),
    TechSkill(name: 'dartz', category: 'Utilities'),
    TechSkill(name: 'fraction', category: 'Utilities'),
    TechSkill(name: 'timeago', category: 'Utilities'),
    TechSkill(name: 'url_launcher', category: 'Utilities'),
    TechSkill(name: 'share_plus', category: 'Utilities'),
    TechSkill(name: 'permission_handler', category: 'Utilities'),

    // JSON & Serialization
    TechSkill(name: 'json_annotation', category: 'JSON & Serialization'),
    TechSkill(name: 'freezed_annotation', category: 'JSON & Serialization'),



    // Notifications
    TechSkill(name: 'flutter_local_notifications', category: 'Notifications'),

    // Maps & Location
    TechSkill(name: 'google_maps_flutter', category: 'Maps & Location'),
    TechSkill(name: 'location', category: 'Maps & Location'),
    TechSkill(name: 'flutter_polyline_points', category: 'Maps & Location'),

    // QR & Scanner
    TechSkill(name: 'mobile_scanner (QR Scanner)', category: 'QR & Scanner'),
    TechSkill(name: 'barcode', category: 'QR & Scanner'),

    // ML
    TechSkill(
        name: 'google_mlkit_text_recognition', category: 'Machine Learning'),

    // Video Calling
    TechSkill(name: 'zego_uikit_prebuilt_call', category: 'Video Calling'),
    TechSkill(name: 'zego_uikit', category: 'Video Calling'),
    TechSkill(name: 'zego_uikit_signaling_plugin', category: 'Video Calling'),

    // PDF & Printing
    TechSkill(name: 'pdf', category: 'PDF & Printing'),
    TechSkill(name: 'printing', category: 'PDF & Printing'),

    // Game Development
    TechSkill(name: 'flame', category: 'Game Development'),
    TechSkill(name: 'flame_3d', category: 'Game Development'),
    TechSkill(name: 'vector_math', category: 'Game Development'),

    // Misc
    TechSkill(name: 'bottom_navigation_animated_notch_bar', category: 'Misc'),
    TechSkill(name: 'google_nav_bar', category: 'Misc'),
    TechSkill(name: 'youtube_player_iframe', category: 'Misc'),
    TechSkill(name: 'flutter_math_fork', category: 'Misc'),
    TechSkill(name: 'web', category: 'Misc'),
    TechSkill(name: 'web_smooth_scroll', category: 'Misc'),
    TechSkill(name: 'smooth_scroll_multiplatform', category: 'Misc'),
    TechSkill(name: 'cherry_toast', category: 'Misc'),
    TechSkill(name: 'init', category: 'Misc'),
    TechSkill(name: 'cupertino_icons', category: 'Misc'),

    // Dev Tools & Testing
    TechSkill(name: 'flutter_lints', category: 'Dev Tools & Testing'),
    TechSkill(name: 'build_runner', category: 'Dev Tools & Testing'),
    TechSkill(name: 'riverpod_generator', category: 'Dev Tools & Testing'),
    TechSkill(name: 'hive_generator', category: 'Dev Tools & Testing'),
    TechSkill(name: 'json_serializable', category: 'Dev Tools & Testing'),
    TechSkill(name: 'mockito', category: 'Dev Tools & Testing'),
    TechSkill(name: 'mocktail', category: 'Dev Tools & Testing'),
  ];
}
