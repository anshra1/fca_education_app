import 'package:badges/badges.dart';
import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/core/common/views/loading_view.dart';
import 'package:fca_education_app/core/common/widgets/nested_back_button.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/notification/presentation/cubit/notification_cubit.dart';
import 'package:fca_education_app/src/notification/presentation/widgets/no_notification.dart';
import 'package:fca_education_app/src/notification/presentation/widgets/notification_tile.dart';
import 'package:fca_education_app/src/notification/presentation/widgets/notifications_option.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    context.read<NotificationCubit>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: false,
        leading: const NestedBackButton(),
        actions: const [NotificationOptions()],
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is NotificationError) {
            CoreUtils.showSnackBar(context, state.message);
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is GettingNotifications) {
            return const Loadingview();
          } else if (state is NotificationsLoaded &&
              state.notifications.isEmpty) {
            return const NoNotifications();
          } else if (state is NotificationsLoaded) {
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (_, index) {
                final notification = state.notifications[index];
                return Badge(
                  showBadge: !notification.seen,
                  position: BadgePosition.topEnd(top: 30, end: 20),
                  child: BlocProvider(
                    create: (context) => sl<NotificationCubit>(),
                    child: NotificationTile(notification),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
