import 'dart:async';

import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/core/common/app/providers/tab_navigator.dart';
import 'package:fca_education_app/core/common/widgets/popup_item.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/res/colors.dart';
import 'package:fca_education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fca_education_app/src/profile/presentation/views/edit_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          PopupMenuButton(
            offset: const Offset(0, 50),
            icon: const Icon(Icons.more_horiz),
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            itemBuilder: (context) => [
              PopupMenuItem<void>(
                child: const PopUpItem(
                  title: 'Edit Profile',
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colours.neutralTextColour,
                  ),
                ),
                onTap: () {
                  // context.push() same as below
                  context.push(
                    BlocProvider(
                      create: (context) => sl<AuthBloc>(),
                      child:  const EditPrifleView(),
                    ),
                  );
                },
              ),
              PopupMenuItem<void>(
                child: const PopUpItem(
                  title: 'Notification',
                  icon: Icon(
                    IconlyLight.notification,
                    color: Colours.neutralTextColour,
                  ),
                ),
                onTap: () {
                  // context.push() same as below
                  context
                      .read<TabNavigator>()
                      .push(TabItem(child: const Placeholder()));
                },
              ),
              PopupMenuItem<void>(
                child: const PopUpItem(
                  title: 'Help',
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: Colours.neutralTextColour,
                  ),
                ),
                onTap: () {
                  // context.push() same as below
                  context
                      .read<TabNavigator>()
                      .push(TabItem(child: const Placeholder()));
                },
              ),
              PopupMenuItem<void>(
                height: 1,
                padding: EdgeInsets.zero,
                child: Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                  endIndent: 16,
                  indent: 16,
                ),
              ),
              PopupMenuItem<void>(
                child: const PopUpItem(
                  title: 'Logout',
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  // way 1
                  final navigator = Navigator.of(context);
                  await sl<FirebaseAuth>().signOut();

                  unawaited(
                    navigator.pushNamedAndRemoveUntil(
                      '/',
                      (route) => false,
                    ),
                  );

                  // way 2

                  // await sl<FirebaseAuth>().signOut().then((value) {
                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                  //     '/',
                  //     (route) => false,
                  //   );
                  // });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
