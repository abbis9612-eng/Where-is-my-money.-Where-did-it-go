/// On-device speech recognition, Iraqi Arabic first.
library;

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceInput {
  VoiceInput._();
  static final VoiceInput instance = VoiceInput._();

  final SpeechToText _stt = SpeechToText();
  bool _ready = false;
  String? _locale;

  Future<bool> ensureReady() async {
    if (_ready) return true;
    _ready = await _stt.initialize(onError: (_) {}, onStatus: (_) {});
    if (_ready) {
      final locales = await _stt.locales();
      String? pick(String prefix) {
        for (final l in locales) {
          if (l.localeId.toLowerCase().replaceAll('-', '_').startsWith(prefix)) return l.localeId;
        }
        return null;
      }

      _locale = pick('ar_iq') ?? pick('ar_sa') ?? pick('ar');
    }
    return _ready;
  }

  bool get isListening => _stt.isListening;

  Future<void> listen({required void Function(String text, bool done) onText}) async {
    if (!await ensureReady()) return;
    await _stt.listen(
      listenOptions: SpeechListenOptions(
        localeId: _locale,
        listenFor: const Duration(seconds: 20),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        cancelOnError: true,
        listenMode: ListenMode.dictation,
      ),
      onResult: (SpeechRecognitionResult r) => onText(r.recognizedWords, r.finalResult),
    );
  }

  Future<void> stop() => _stt.stop();
}
