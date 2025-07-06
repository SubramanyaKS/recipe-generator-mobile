import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isAvailable = false;
  bool _isListening = false;

  Function(String text)? onResult;
  Function(String error)? onError;
  Function(String status)? onStatus;

  bool get isListening => _isListening;
  bool get isAvailable => _isAvailable;

  Future<void> initSpeech() async {
    _isAvailable = await _speechToText.initialize(
      onError: (val) {
        _isListening = false;
        if (onError != null) onError!(val.errorMsg);
      },
      onStatus: (val) {
        if (val == 'done' || val == 'notListening') {
          _isListening = false;
        }
        if (onStatus != null) onStatus!(val);
      },
    );
  }

  void startListening() {
    if (!_isAvailable || _isListening) return;
    _isListening=true;

    _speechToText.listen(
      onResult: (val) {
        _isListening = true;
        if (onResult != null) onResult!(val.recognizedWords);
      },
      listenFor: const Duration(seconds: 30), // Max duration
      pauseFor: const Duration(seconds: 5),   // Auto-stop after 3s of silence
      partialResults: false, // Set to false if you only want final results
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
    );
  }

  void stopListening() {
    if (_isListening) {
      _speechToText.stop();
      _isListening = false;
    }
  }

  void cancelListening() {
    if (_isListening) {
      _speechToText.cancel();
      _isListening = false;
    }
  }
}