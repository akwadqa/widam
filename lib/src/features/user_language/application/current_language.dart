import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/global_providers/global_providers.dart';
part 'current_language.g.dart';

@Riverpod(keepAlive: true)
class CurrentLanguage extends _$CurrentLanguage {
  @override
  String build() {
    return ref
            .watch(sharedPreferencesProvider)
            .requireValue
            .getString(Keys.languageCode) ??
        'en';
  }

  void changeLanguage() {
    final language = state == 'en' ? 'ar' : 'en';
    ref
        .read(sharedPreferencesProvider)
        .requireValue
        .setString(Keys.languageCode, language);
    state = language;
  }
}
