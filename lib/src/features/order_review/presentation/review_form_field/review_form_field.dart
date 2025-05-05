import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../gen/assets.gen.dart';

class ReviewFormField extends FormField<double> {
  ReviewFormField(
      {super.key,
      required String title,
      double? initialValue,
      super.onSaved,
      super.validator})
      : super(builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(height: 12),
              RatingBar(
                initialRating: initialValue ?? 0.0,
                glow: false,
                direction: Axis.horizontal,
                itemCount: 5,
                allowHalfRating: true,
                ratingWidget: RatingWidget(
                  full: Assets.images.starImage.svg(),
                  half: Assets.images.starHalfImage.svg(),
                  empty: Assets.images.starOffImage.svg(),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                onRatingUpdate: (rating) => state.didChange(rating),
              ),
              if (state.hasError)
                Text(state.errorText!,
                    style: const TextStyle(fontSize: 12, color: Colors.red))
            ],
          );
        });
}
