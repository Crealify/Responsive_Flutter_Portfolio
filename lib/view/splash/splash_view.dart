import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:anilbhattarai_portfolio/res/constants.dart';
import 'package:anilbhattarai_portfolio/view/splash/components/animated_loading_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Initial entry point with a branded cinematic loading experience.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Fire audio earlier to match the faster animation
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _playStartupSound();
    });
    _navigateToHome();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheAssets();
  }

  Future<void> _playStartupSound() async {
    try {
      await _audioPlayer.setVolume(0.6);
      await _audioPlayer.play(AssetSource('audio/startup.mp3'));
    } catch (e) {
      // Silently swallow Chrome autoplay block — animation continues unaffected
      debugPrint('Audio: $e');
    }
  }

  Future<void> _precacheAssets() async {
    precacheImage(const AssetImage('assets/icons/portfolio_logo.png'), context);
    for (final icon in [
      'assets/icons/linkedin.svg',
      'assets/icons/github.svg',
      'assets/icons/facebook.svg',
      'assets/icons/youtube.svg',
      'assets/icons/instagram.svg',
    ]) {
      DefaultAssetBundle.of(context).load(icon);
    }
  }

  void _navigateToHome() {
    // 1.4s total to match the sped-up animation
    _timer = Timer(const Duration(milliseconds: 1400), () {
      Get.offAllNamed('/HomePage');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppConstants.bgColor,
      body: SizedBox.expand(child: AnimatedLoadingText()),
    );
  }
}
