import 'package:auth_api/auth_api.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:profile_api/profile_api.dart';

import '../../localization/profile_localizations.dart';
import 'profile_cubit.dart';

class ProfilePage extends HookWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<ProfileCubit>();

    useEffect(() {
      cubit.fetchUserInfo();
      return null;
    }, []);

    // Listen to SessionManager changes to rebuild when user data updates
    useListenable(SessionManager.defaultManager);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.profile_title ?? 'Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black87),
            onPressed: () {
              context.push(ProfileRoutes.settings);
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _ProfileHeader(),
            SizedBox(height: 20),
            _StatsRow(),
            SizedBox(height: 20),
            _ActionButtons(),
            SizedBox(height: 20),
            _MenuItems(),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends HookWidget {
  const _ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = SessionManager.defaultManager.getUser<AuthUser>();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            backgroundImage: user?.userInfo.avatar != null ? NetworkImage(user!.userInfo.avatar!) : null,
            child: user?.userInfo.avatar == null
                ? Icon(Icons.person, size: 40, color: Theme.of(context).primaryColor)
                : null,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.userInfo.userName ?? AppLocalizations.of(context)?.profile_guest_user ?? 'Guest User',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '@${user?.userInfo.userId ?? (AppLocalizations.of(context)?.profile_unknown ?? 'unknown')}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)?.profile_description ?? 'Flutter Developer & Enthusiast',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(label: AppLocalizations.of(context)?.profile_stats_posts ?? 'Posts', count: '142'),
          _StatItem(label: AppLocalizations.of(context)?.profile_stats_followers ?? 'Followers', count: '12.4K'),
          _StatItem(label: AppLocalizations.of(context)?.profile_stats_following ?? 'Following', count: '1,024'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String count;

  const _StatItem({Key? key, required this.label, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text(AppLocalizations.of(context)?.profile_action_edit ?? 'Edit Profile'),
        ),
        const SizedBox(width: 16),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text(AppLocalizations.of(context)?.profile_action_share ?? 'Share Profile'),
        ),
      ],
    );
  }
}

class _MenuItems extends StatelessWidget {
  const _MenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _MenuTile(
            icon: Icons.bookmark_border,
            title: AppLocalizations.of(context)?.profile_menu_saved_posts ?? 'Saved Posts',
          ),
          const Divider(height: 1),
          _MenuTile(
            icon: Icons.favorite_border,
            title: AppLocalizations.of(context)?.profile_menu_liked_items ?? 'Liked Items',
          ),
          const Divider(height: 1),
          _MenuTile(
            icon: Icons.history,
            title: AppLocalizations.of(context)?.profile_menu_browsing_history ?? 'Browsing History',
          ),
          const Divider(height: 1),
          _MenuTile(
            icon: Icons.help_outline,
            title: AppLocalizations.of(context)?.profile_menu_help_support ?? 'Help & Support',
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _MenuTile({Key? key, required this.icon, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
