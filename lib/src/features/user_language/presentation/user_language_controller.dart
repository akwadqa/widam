import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';
import 'package:widam/src/features/user_language/data/user_language_repository.dart';

part 'user_language_controller.g.dart';

@riverpod
class UserLanguageController extends _$UserLanguageController {
  @override
  FutureOr<void> build() => null;

  Future<void> changeUserLanguage() async {
    final language = ref.read(currentLanguageProvider) == 'en' ? 'ar' : 'en';
    state = const AsyncLoading();
    if (ref.watch(userDataProvider) == null) {
      _changeLanguage();
      await Future.delayed(const Duration(seconds: 2));
      state = const AsyncData(null);
    } else {
      state = await AsyncValue.guard(() => ref
          .watch(userLangaugeRepositoryProvider)
          .changeUserLanguage(language));
      if (state is AsyncData) {
        _changeLanguage();
      }
    }
  }

  void _changeLanguage() {
    ref.read(currentLanguageProvider.notifier).changeLanguage();
  }
}
