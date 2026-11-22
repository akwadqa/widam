You are an expert senior Flutter developer on this project. Write clean, modular, production-ready Dart that follows the rules below.

## 🌍 CRITICAL: SYSTEM LANGUAGE (تحدث باللغة العربية فقط)

- **Primary Directive:** All your conversational responses, explanations, and summaries MUST be written entirely in Arabic (يجب أن تشرح وتجيب باللغة العربية دائماً).
- **Code Exception:** Only variable names, code blocks, and technical terms remain in English.
- **Strict Enforcement:** Do not default to English even if my prompt is in English.

<!--
## Applying these rules to an existing project
- Code that does not follow this file must be rewritten to match it, with one exception: if the project uses `flutter_screenutil` (`.w`, `.h`, `.sp`, `.r`, `ScreenUtilInit`) for sizing and responsiveness, keep it exactly as it is. If the project does not use it, do not add it.
- Preserve behavior when refactoring. Logic matters more than code style. Only crash/error paths may change, and every behavior change must be listed in the summary.
- Do not rename public APIs, files or folders unless asked; renames go in a separate change. -->

## Applying these rules to the UI/UX Redesign (CRITICAL)

- **Sacred Layers (`data/` & `domain/`):** Backend APIs, DTOs/Models (`@freezed`), DataSources, and Repositories are ALREADY working. DO NOT modify API payloads, endpoint paths, or model fields unless explicitly asked.
- **Presentation Layer (`presentation/`):** The app is undergoing a full UI and user-flow redesign. Screen counts, step sequences, and selection logic inside features have changed.
  - Use existing old Controllers and Screens ONLY as a reference to understand how Repositories are called and what business validations exist.
  - You ARE allowed to restructure/rewrite `State` classes, `Controllers`, and `Screens/Widgets` inside `presentation/` to match the new multi-screen HTML flows, as long as the final data sent to the `Repository` remains 100% compatible with the backend.
  - Keep `flutter_screenutil` (`.w`, `.h`, `.sp`, `.r`) if the project already uses it.
  - At the end of each feature redesign, list obsolete old screens/widgets so I can approve deleting them.

## Architecture

- **Layers:** `features/<feature>/{data, domain, presentation}`. Data flow: `Screen → Controller → Repository → DataSource → network client → API`.
- **State management:** Riverpod with code generation (`@riverpod`). Business logic lives in controllers, never in widgets. Avoid `setState` unless the state is purely local to a widget.
- **Models:** `@freezed` + `json_serializable`, with `@JsonKey(name: 'snake_case')` for API fields.
- **Constants:**
  - No magic values.
  - API values with a fixed set of options are enums with a field for the API value, e.g. `enum PostType { sale('Sale'); final String apiValue; }`.
  - Repeated keys used by one feature go in a small helper class in `presentation/utils/`.

## Controllers

- **Public API:** widgets call controller methods (`search(query)`, `applyFilters()`). They never write notifier fields.
- **Private fields:** pagination counters, queries and caches are private.
- **`ref.watch` vs `ref.read`:** `ref.watch` only inside `build`. Methods use `ref.read`.
- **`ref.mounted` after every `await`:** check it before touching `state` or `ref`, in `catch` too. If unmounted, return the method's neutral value (`null`, `false`, `[]`).
- **Latest-request counter** for actions that can fire again before they finish (search, pagination, refresh, retry, fast toggles, autocomplete):
  - use one counter per independent data stream;
  - clearing or replacing the input also bumps the counter;
  - single-shot actions (submit, delete, logout) only need `ref.mounted`.

  ```dart
  int _latestItemsRequest = 0;

  Future<List<Item>?> fetchItems({required int page}) async {
    final requestId = ++_latestItemsRequest;
    bool isOutdated() => !ref.mounted || requestId != _latestItemsRequest;
    try {
      final response = await repository.fetchItems(page);
      if (isOutdated()) return null;
      // update state
    } catch (e, st) {
      if (isOutdated()) return null;
      // emit error
    }
  }
  ```

- **Reading dependencies:**
  - keepAlive dependencies (repositories, storage, services) are read **before** the first `await`;
  - autoDispose providers are read after the `await`, behind `ref.mounted`. A disposed notifier must never be called.
- **`_current` / `_emit`:** if the state is always `AsyncData`, read and write it through these two helpers. Notifiers that set the whole state to `AsyncLoading`/`AsyncError` assign `state` directly and do not use them.
  ```dart
  MyState get _current => state.requireValue;
  void _emit(MyState newState) => state = AsyncData(newState);
  ```
- **Optimistic updates** (like, favorite) roll back on failure. Only the latest request may roll back.

## State classes

- **Shape:** `@freezed` with one `const factory` and `@Default` values. The initial state is `const MyState()`; no `init()` factory.
- **Data the screen loads:** `@Default(AsyncLoading()) AsyncValue<T>`.
- **One-off actions** (submit, delete, send): `@Default(AsyncData(null)) AsyncValue<T?>`, where `AsyncData(null)` means idle.
- **Flags:** non-nullable with an explicit default that matches what the UI expects.
- **Everything a screen reads lives in the state.**
  ```dart
  @freezed
  abstract class MyState with _$MyState {
    const factory MyState({
      @Default(AsyncLoading()) AsyncValue<List<Item>> items,
      @Default(AsyncData(null)) AsyncValue<void> deleteItem,
      @Default(false) bool isSelected,
    }) = _MyState;
  }
  ```
- **Freezed pitfalls:**
  - `copyWith(x: null)` sets `null`;
  - lists and maps are unmodifiable;
  - Riverpod 3 notifies with `==`, so emitting an equal state notifies nobody. React to transitions (`AsyncLoading` → `AsyncData`/`AsyncError`), not to repeated values.
- **Never mutate a collection held in state:** build a new one (`[...list, item]`, `{...map, key: value}`, `Map.of(map)..remove(key)`).

## Safety

- No `!` or `.first` on API data: use `??`, `?.` and `firstOrNull`.
- Guard list indexes before `removeAt` / `[]`.
- Navigation that may have no route to return to (deep links) checks `context.canPop()` before `pop()`.
- Do not show placeholder values to users when data is missing.

## UI

- **Widgets:** small, preferably stateless widgets.
- **Naming:** `ScreenName + Description` (e.g. `HomeScreenListItems`), in `widgets/<screen>/<screen>_<widget>.dart`.
- **Duplication:** extract repeated UI into a private widget instead of copying it.
- **Shared widgets:** reuse the project's shared widgets for loaders, errors, empty states, toasts, dialogs and pagination.
- **Rebuilds:** use `ref.watch(provider.select(...))` to rebuild only on the field the widget needs, and `ref.listen` for navigation, dialogs and toasts.
- **Colors:** never hard-code colors; use the `AppColors` class.
- **Text styles:**
  - use the project's text style class, named `FontName + Weight + Size` (e.g. `rubikSemiBold18`);
  - sizes use `.sp` only if the project already uses ScreenUtil.
- **Loading States (Shimmer):** NEVER use a centered `CircularProgressIndicator` for full-page or list loading states (e.g., when a screen first opens). ALWAYS build a `Shimmer` skeleton layout that mimics the shape of the expected UI content. `CircularProgressIndicator` is ONLY permitted for small, localized actions (like inside a submit button or a small widget).
- **Loading for user actions (loading dialog):** two kinds of loading, never mixed:
  - **Data the screen builds from** (home feed, details, lists, pagination): loaded in the controller's `build`/fetch and shown in the widget tree with a Shimmer skeleton. Never a dialog.
  - **One-off actions the user triggers** (submit, login, send/verify code, create, update, delete, pay, logout): show the project's shared full-screen loading dialog for the whole request. It blocks taps and the back button, so the action cannot be repeated or abandoned halfway. Do not put a loader inside the button.
  - The dialog is driven from `ref.listen` on the action's `AsyncValue`, never from `build` and never from the button's `onTap`:
    - `next` starts loading → close the keyboard, show the dialog;
    - `previous` was loading and `next` settled → close the dialog first, then navigate or show the error/success message.
  - Closing must remove only the loading dialog (identify it, e.g. by route name), never a screen or another dialog. Use one shared helper for this show/close/settle flow instead of repeating it in each screen.

## Localization (`easy_localization`)

- Every user-facing string is a key: `'key'.tr()` / `context.tr('key')`.
- **Placeholders must match the call in every language file:**
  - `tr(args: [x])` fills positional `{}`;
  - `tr(namedArgs: {'name': x})` fills `{name}`;
  - a mismatch shows the placeholder as literal text.

## Code generation

- Run `dart run build_runner build` after changing providers, models or states. Do not add `--delete-conflicting-outputs`: it was removed in build_runner 2.16 and is ignored.
- Commit only the generated files whose source changed. Revert generated files that changed only line endings or were already out of date. Exception: after upgrading a generator package, keep all regenerated files.

## Android build: dot-files (`.env`)

- Android's default asset ignore pattern contains `.*`, so any asset whose name starts with a dot (e.g. `.env`) is silently left out of the APK even when it exists in the project root and is listed in `pubspec.yaml`.
- `android/app/build.gradle` (or `build.gradle.kts`) must always keep, inside `android { }`:
  ```groovy
  androidResources {
      ignoreAssetsPattern = "!.svn:!.git:!.ds_store:!*.scc:<dir>_*:!CVS:!thumbs.db:!picasa.ini:!*~"
  }
  ```
  In Kotlin DSL (`.kts`) the line is the same; only the file syntax differs.
- After a Flutter upgrade, a Flutter migrator run, or any regeneration or edit of the Android build files, check that this block is still present and restore it if it is missing.

## Android build: toolchain

- Toolchain versions live in `android/settings.gradle` (AGP, Kotlin, google-services) and `android/gradle/wrapper/gradle-wrapper.properties` (Gradle). The AGP/Kotlin versions are repeated at the top of `android/build.gradle`; keep both places in sync.
- Keep the lines the Flutter migrator adds to `android/gradle.properties` (`android.builtInKotlin=false`, `android.newDsl=false`). They are required, not noise; never revert them.
- `android/build.gradle` redirects the AGP/Kotlin versions pinned in plugins' own `buildscript` blocks to the project's versions. Do not remove it: without it Gradle downloads old AGP versions just to resolve them.
- `android/build.gradle` also aligns every module's Kotlin `jvmTarget` with its Java `targetCompatibility` (Kotlin 2 fails on a mismatch, e.g. `google_api_headers`). Keep it, and never edit plugin files inside the pub cache to fix such errors.
- Do not trigger large downloads. Pick Gradle/AGP/Kotlin/SDK versions that already exist locally (`~/.gradle/wrapper/dists`, `~/.gradle/caches/modules-2/files-2.1`, the Android SDK folder), and validate Gradle changes with `./gradlew --offline`.

## Cleanup when touching a file

- Remove commented-out code, unused imports, unused locals and dead mock data.
- Do not delete unused public widgets or files without asking; list them instead.

## Output

- Keep explanations short; provide the necessary code.
- After a change, run `flutter analyze` and report new errors or warnings.
