import 'package:fca_education_app/core/common/app/providers/notification_notifier.dart';
import 'package:fca_education_app/core/common/widgets/popup_item.dart';
import 'package:fca_education_app/core/res/colors.dart';
import 'package:fca_education_app/src/notification/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationOptions extends StatelessWidget {
  const NotificationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsNotifier>(
      builder: (_, notifier, __) {
        return PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<void>(
              onTap: notifier.toggleMuteNotifications,
              child: PopUpItem(
                title: notifier.muteNotifications
                    ? 'Un-mute Notifications'
                    : 'Mute Notifications',
                icon: Icon(
                  notifier.muteNotifications
                      ? Icons.notifications_off_outlined
                      : Icons.notifications_outlined,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: context.read<NotificationCubit>().clearAll,
              child: const PopUpItem(
                title: 'Clear All',
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
