import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

mixin TypingAudioMixin<T extends StatefulWidget> on State<T> {
  static const int _audioPoolSize = 5;
  final List<AudioPlayer> _audioPool = [];
  int _audioPoolIndex = 0;

  @override
  void initState() {
    super.initState();
    _initAudioPool();
  }

  Future<void> _initAudioPool() async {
    // 1. Initialize first player immediately so sound is ready ASAP
    final firstPlayer = AudioPlayer();
    await firstPlayer.setSource(AssetSource('audio/keyboard.wav')).catchError((_) {});
    await firstPlayer.setVolume(0.5);
    await firstPlayer.setReleaseMode(ReleaseMode.stop);
    if (!mounted) return;
    _audioPool.add(firstPlayer);

    // 2. Initialize the rest of the pool gradually in the background
    for (int i = 1; i < _audioPoolSize; i++) {
      await Future.delayed(const Duration(milliseconds: 150)); // stagger initialization
      if (!mounted) return;
      final player = AudioPlayer();
      await player.setSource(AssetSource('audio/keyboard.wav')).catchError((_) {});
      await player.setVolume(0.5);
      await player.setReleaseMode(ReleaseMode.stop);
      _audioPool.add(player);
    }
  }

  void playTypingSound() {
    if (_audioPool.isNotEmpty) {
      final player = _audioPool[_audioPoolIndex % _audioPool.length];
      player.resume().catchError((_) {});
      _audioPoolIndex++;
    }
  }

  @override
  void dispose() {
    for (var player in _audioPool) {
      player.dispose();
    }
    super.dispose();
  }
}
