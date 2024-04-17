import 'package:fca_education_app/%20core/common/app/providers/user_providers.dart';
import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:fca_education_app/%20core/res/colors.dart';
import 'package:fca_education_app/%20core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;

        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : const AssetImage(MediaResources.user) as ImageProvider,
            ),
            Text(
              user?.fullName ?? 'No User',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            if (user?.bio != null && user!.bio!.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * .15,
                ),
                child: Text(
                  user.bio!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colours.neutralTextColour,
                  ),
                ),
              ),
            ],
            const SizedBox(
              height: 16,
            ),
          ],
        );
      },
    );
  }
}
