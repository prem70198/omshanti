import 'dart:async';
import 'package:flutter/material.dart';
import '../core/services/audio_player_service.dart';
import '../models/meditation_session.dart';
import '../data/mock_database.dart';

class MeditationPlayerProvider extends ChangeNotifier {
  final AudioPlayerService _audioService = AudioPlayerService();

  MeditationSession? _currentSession;
  final List<MeditationSession> _allSessions = List.from(MockDatabase.meditationSessions);
  AudioPlaybackState _playbackState = AudioPlaybackState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = const Duration(minutes: 15);
  AmbientSoundType _ambientSound = AmbientSoundType.none;
  int? _sleepTimerMinutes;
  bool _isMiniPlayerVisible = false;

  // Breathing state
  String _breathingPhase = 'INHALE';
  int _breathingSecondsLeft = 4;
  Timer? _breathingTimer;

  StreamSubscription? _stateSub;
  StreamSubscription? _posSub;
  StreamSubscription? _ambientSub;

  MeditationPlayerProvider() {
    _currentSession = _allSessions.first;
    _stateSub = _audioService.stateStream.listen((state) {
      _playbackState = state;
      notifyListeners();
    });
    _posSub = _audioService.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });
    _ambientSub = _audioService.ambientStream.listen((ambient) {
      _ambientSound = ambient;
      notifyListeners();
    });
    _startBreathingLoop();
  }

  MeditationSession? get currentSession => _currentSession;
  List<MeditationSession> get allSessions => _allSessions;
  AudioPlaybackState get playbackState => _playbackState;
  bool get isPlaying => _playbackState == AudioPlaybackState.playing;
  Duration get position => _position;
  Duration get duration => _duration;
  double get progress => _duration.inSeconds > 0 ? _position.inSeconds / _duration.inSeconds : 0.0;
  AmbientSoundType get ambientSound => _ambientSound;
  int? get sleepTimerMinutes => _sleepTimerMinutes;
  bool get isMiniPlayerVisible => _isMiniPlayerVisible && _currentSession != null;
  String get breathingPhase => _breathingPhase;
  int get breathingSecondsLeft => _breathingSecondsLeft;

  void playSession(MeditationSession session) {
    _currentSession = session;
    _duration = Duration(minutes: session.durationMinutes);
    _position = Duration.zero;
    _isMiniPlayerVisible = true;
    _audioService.play(duration: _duration);
    notifyListeners();
  }

  void playSessionById(String id) {
    final session = _allSessions.firstWhere(
      (s) => s.id == id,
      orElse: () => _allSessions.first,
    );
    playSession(session);
  }

  void togglePlayPause() {
    if (_currentSession == null) {
      if (_allSessions.isNotEmpty) {
        playSession(_allSessions.first);
      }
      return;
    }

    if (isPlaying) {
      _audioService.pause();
    } else {
      if (_playbackState == AudioPlaybackState.stopped ||
          _playbackState == AudioPlaybackState.completed) {
        _audioService.play(duration: _duration);
      } else {
        _audioService.resume();
      }
    }
    _isMiniPlayerVisible = true;
    notifyListeners();
  }

  void seek(Duration newPosition) {
    _audioService.seek(newPosition);
    _position = newPosition;
    notifyListeners();
  }

  void seekForward15() {
    seek(_position + const Duration(seconds: 15));
  }

  void seekBackward15() {
    seek(_position - const Duration(seconds: 15));
  }

  void nextSession() {
    if (_currentSession == null) return;
    final currentIndex = _allSessions.indexWhere((s) => s.id == _currentSession!.id);
    if (currentIndex < _allSessions.length - 1) {
      playSession(_allSessions[currentIndex + 1]);
    } else {
      playSession(_allSessions.first);
    }
  }

  void previousSession() {
    if (_currentSession == null) return;
    final currentIndex = _allSessions.indexWhere((s) => s.id == _currentSession!.id);
    if (currentIndex > 0) {
      playSession(_allSessions[currentIndex - 1]);
    } else {
      playSession(_allSessions.last);
    }
  }

  void setAmbientSound(AmbientSoundType type) {
    _ambientSound = type;
    _audioService.setAmbientSound(type);
    notifyListeners();
  }

  void setSleepTimer(int? minutes) {
    _sleepTimerMinutes = (minutes != null && minutes > 0) ? minutes : null;
    _audioService.setSleepTimer(minutes ?? 0);
    notifyListeners();
  }

  void toggleFavorite(String sessionId) {
    final index = _allSessions.indexWhere((s) => s.id == sessionId);
    if (index != -1) {
      final updated = _allSessions[index].copyWith(
        isFavorite: !_allSessions[index].isFavorite,
      );
      _allSessions[index] = updated;
      if (_currentSession?.id == sessionId) {
        _currentSession = updated;
      }
      notifyListeners();
    }
  }

  void toggleDownload(String sessionId) {
    final index = _allSessions.indexWhere((s) => s.id == sessionId);
    if (index != -1) {
      final updated = _allSessions[index].copyWith(
        isDownloaded: !_allSessions[index].isDownloaded,
      );
      _allSessions[index] = updated;
      if (_currentSession?.id == sessionId) {
        _currentSession = updated;
      }
      notifyListeners();
    }
  }

  void dismissMiniPlayer() {
    _isMiniPlayerVisible = false;
    _audioService.stop();
    notifyListeners();
  }

  void _startBreathingLoop() {
    _breathingTimer?.cancel();
    _breathingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _breathingSecondsLeft--;
      if (_breathingSecondsLeft <= 0) {
        if (_breathingPhase == 'INHALE') {
          _breathingPhase = 'HOLD';
          _breathingSecondsLeft = 2;
        } else if (_breathingPhase == 'HOLD') {
          _breathingPhase = 'EXHALE';
          _breathingSecondsLeft = 4;
        } else {
          _breathingPhase = 'INHALE';
          _breathingSecondsLeft = 4;
        }
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _breathingTimer?.cancel();
    _stateSub?.cancel();
    _posSub?.cancel();
    _ambientSub?.cancel();
    _audioService.dispose();
    super.dispose();
  }
}
