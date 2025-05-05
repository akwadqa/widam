import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../generated/l10n.dart';
import '../../../data/google_maps_repository.dart';
import '../../../domain/place/place.dart';

class LocationAutoComplete extends ConsumerStatefulWidget {
  const LocationAutoComplete({super.key, required this.onSelected});
  final void Function(Place) onSelected;
  @override
  ConsumerState<LocationAutoComplete> createState() =>
      _LocationAutoCompleteState();
}

class _LocationAutoCompleteState extends ConsumerState<LocationAutoComplete> {
  String? sessionToken;

  @override
  void initState() {
    sessionToken = const Uuid().v4();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return Autocomplete<Place>(
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<Place>.empty();
          }
          return await _suggestPlaces(textEditingValue.text, ref);
        },
        onSelected: (Place place) {
          widget.onSelected.call(place);
          FocusScope.of(context).unfocus();
        },
        displayStringForOption: (option) => option.description,
        optionsViewBuilder: (context, onSelected, options) {
          return Padding(
            padding: Directionality.of(context) == TextDirection.rtl
                ? const EdgeInsetsDirectional.only(start: 30)
                : const EdgeInsetsDirectional.only(end: 30),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Material(
                elevation: 4.0,
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final option = options.elementAt(index);
                      return ListTile(
                        key: Key(option.placeId),
                        title: Text(option.description),
                        onTap: () {
                          onSelected(option);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            focusNode: focusNode,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: S.of(context).enterLocationName,
              prefixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(
                    end: 4.0, start: 16.0, top: 16.0, bottom: 16.0),
                child: Assets.icons.locationIcon.svg(),
              ),
              filled: true,
              fillColor: Colors.white,
              border: _outlineInputBorder,
              enabledBorder: _outlineInputBorder,
            ),
          );
        },
      );
    });
  }

  OutlineInputBorder get _outlineInputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide.none,
      );

  Future<List<Place>> _suggestPlaces(String input, WidgetRef ref) async {
    if (input.isNotEmpty) {
      final places =
          await ref.watch(autoCompleteProvider(input, sessionToken!).future);
      return places;
    }
    return [];
  }
}
