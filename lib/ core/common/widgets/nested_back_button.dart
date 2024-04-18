import 'package:fca_education_app/%20core/common/app/providers/tab_navigator.dart';
import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        try {
          context.pop();
        } catch (_) {
          Navigator.of(context).pop();
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.read<TabNavigator>().pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
