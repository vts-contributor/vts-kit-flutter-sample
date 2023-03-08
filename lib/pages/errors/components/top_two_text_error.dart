import 'package:flutter/material.dart';
import 'package:sample/pages/errors/components/fade_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopTwoTextError extends StatelessWidget {
  const TopTwoTextError({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 404 TEXT
        FadeAnimation(
          delay: 2.5,
          child: Text(
            "404",
            style: textTheme.displayMedium,
          ),
        ),

        /// PAGE NOT FOUND TEXT
        FadeAnimation(
          delay: 2.0,
          child: Text(
            AppLocalizations.of(context)!.kPageNotFound,
            style: textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}
