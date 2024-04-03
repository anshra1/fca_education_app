import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:flutter/material.dart';


class Loadingview extends StatelessWidget {
  const Loadingview({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
