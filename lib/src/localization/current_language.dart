import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../main.dart';
import '../constants/keys.dart';
part 'current_language.g.dart';

@Riverpod(keepAlive: true)
class CurrentLanguage extends _$CurrentLanguage {
  @override
  String build() {
    return ref.watch(sharedPreferencesProvider).getString(Keys.languageCode) ??
        'en';
  }

  void changeLanguage() {
    final language = state == 'en' ? 'ar' : 'en';
    ref.read(sharedPreferencesProvider).setString(Keys.languageCode, language);
    state = language;
  }
}
