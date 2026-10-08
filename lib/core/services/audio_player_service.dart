import 'dart:async';

enum AudioPlaybackState {
  stopped,
  playing,
  paused,
  completed,
}

enum AmbientSoundType {
  none,
  flute,
  rain,
  omChime,
  natureBirds,
  oceanWaves,
  bellChimes,
}

class AudioPlayerService {
  AudioPlaybackState _state = AudioPlaybackState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = const Duration(minutes: 15);
  AmbientSoundType _currentAmbient = AmbientSoundType.none;
  Timer? _playbackTimer;
  Timer? _sleepTimer;
  int? _sleepTimerMinutesRemaining;

  final _stateController = StreamController<AudioPlaybackState>.broadcast();
  final _positionController = StreamController<Duration>.broadcast();
  final _ambientController = StreamController<AmbientSoundType>.broadcast();

  Stream<AudioPlaybackState> get stateStream => _stateController.stream;
  Stream<Duration> get positionStream => _positionController.stream;
  Stream<AmbientSoundType> get ambientStream => _ambientController.stream;

  AudioPlaybackState get state => _state;
  Duration get position => _position;
  Duration get duration => _duration;
  AmbientSoundType get currentAmbient => _currentAmbient;
  int? get sleepTimerMinutesRemaining => _sleepTimerMinutesRemaining;

  void play({required Duration duration}) {
    _duration = duration;
    _state = AudioPlaybackState.playing;
    _stateController.add(_state);

    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state == AudioPlaybackState.playing) {
        if (_position < _duration) {
          _position += const Duration(seconds: 1);
          _positionController.add(_position);
        } else {
          _state = AudioPlaybackState.completed;
          _stateController.add(_state);
          timer.cancel();
        }
      }
    });
  }

  void pause() {
    _state = AudioPlaybackState.paused;
    _stateController.add(_state);
  }

  void resume() {
    if (_position >= _duration) {
      _position = Duration.zero;
    }
    _state = AudioPlaybackState.playing;
    _stateController.add(_state);
  }

  void stop() {
    _playbackTimer?.cancel();
    _position = Duration.zero;
    _state = AudioPlaybackState.stopped;
    _stateController.add(_state);
    _positionController.add(_position);
  }

  void seek(Duration newPosition) {
    if (newPosition < Duration.zero) {
      _position = Duration.zero;
    } else if (newPosition > _duration) {
      _position = _duration;
    } else {
      _position = newPosition;
    }
    _positionController.add(_position);
  }

  void setAmbientSound(AmbientSoundType type) {
    _currentAmbient = type;
    _ambientController.add(_currentAmbient);
  }

  void setSleepTimer(int minutes) {
    _sleepTimer?.cancel();
    if (minutes <= 0) {
      _sleepTimerMinutesRemaining = null;
      return;
    }
    _sleepTimerMinutesRemaining = minutes;
    _sleepTimer = Timer(Duration(minutes: minutes), () {
      pause();
      _sleepTimerMinutesRemaining = null;
    });
  }

  void dispose() {
    _playbackTimer?.cancel();
    _sleepTimer?.cancel();
    _stateController.close();
    _positionController.close();
    _ambientController.close();
  }
}
