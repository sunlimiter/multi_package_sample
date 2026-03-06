import 'package:common/common.dart';
import 'package:flutter/material.dart';
import '../../localization/profile_localizations.dart';
import 'settings_cubit.dart';
import 'settings_state.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SettingsCubit>(),
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)?.settings_title ?? 'Settings'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
          body: ListView(
            children: [
              const SizedBox(height: 20),
              _SectionHeader(title: AppLocalizations.of(context)?.settings_section_account ?? 'Account'),
              _SettingsTile(
                icon: Icons.lock_outline,
                title: AppLocalizations.of(context)?.settings_privacy_security ?? 'Privacy & Security',
              ),
              _SettingsTile(
                icon: Icons.notifications_none,
                title: AppLocalizations.of(context)?.settings_notifications ?? 'Notifications',
              ),
              const SizedBox(height: 20),
              _SectionHeader(title: AppLocalizations.of(context)?.settings_section_general ?? 'General'),
              _SettingsTile(icon: Icons.language, title: AppLocalizations.of(context)?.settings_language ?? 'Language'),
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: AppLocalizations.of(context)?.settings_display_theme ?? 'Display & Theme',
              ),
              const SizedBox(height: 20),
              _SectionHeader(title: AppLocalizations.of(context)?.settings_section_about ?? 'About'),
              _SettingsTile(
                icon: Icons.info_outline,
                title: AppLocalizations.of(context)?.settings_about_app ?? 'About App',
              ),
              _SettingsTile(
                icon: Icons.policy_outlined,
                title: AppLocalizations.of(context)?.settings_terms_service ?? 'Terms of Service',
              ),
              const SizedBox(height: 40),
              const _LogoutButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SettingsTile({Key? key, required this.icon, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.black87),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggingOut = context.select((SettingsCubit cubit) => cubit.state.isLoggingOut);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[50],
          foregroundColor: Colors.red,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: isLoggingOut ? null : () => _handleLogout(context),
        child: isLoggingOut
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red))
            : Text(
                AppLocalizations.of(context)?.settings_log_out ?? 'Log Out',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final cubit = context.read<SettingsCubit>();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.settings_log_out ?? 'Log Out'),
        content: Text(AppLocalizations.of(context)?.settings_log_out_confirm ?? 'Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)?.settings_cancel ?? 'Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)?.settings_log_out ?? 'Log Out'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await cubit.logout();
    }
  }
}
