import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

import 'widgets/profile_header.dart';
import 'widgets/hc_search_bar.dart';
import 'widgets/feature_tile.dart';
import 'widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double horizontal = 20.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontal, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Header
              const ProfileHeader(),

              const SizedBox(height: 18),

              /// Title
              Text(
                'Medical Card',
                style: AppTheme.headingStyle.copyWith(fontSize: 34),
              ),

              const SizedBox(height: 18),

              /// Search Bar (fixed version)
              const HCSearchBar(),

              const SizedBox(height: 18),

              /// Feature Tiles (2-column layout using Flexible)
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// LEFT COLUMN
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FeatureTile.small(
                              title: 'My doctors',
                              iconAsset: 'assets/icons/stethoscope.svg',
                              onTap: () => context.push('/my_doctors'),
                            ),
                            const SizedBox(height: 16),

                            FeatureTile.large(
                              title: 'Check-up schedule',
                              subtitle:
                                  'Your personal plan for regular medical examinations to maintain overall health',
                              iconAsset: 'assets/icons/calendar.svg',
                              badge: '3',
                              onTap: () => context.push('/schedule'),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      /// RIGHT COLUMN
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FeatureTile.small(
                              title: 'Prescriptions',
                              iconAsset: 'assets/icons/prescription.svg',
                              onTap: () => context.push('/prescriptions'),
                            ),
                            const SizedBox(height: 16),

                            FeatureTile.small(
                              title: 'Laboratory test results',
                              iconAsset: 'assets/icons/lab.svg',
                              badge: '4',
                              onTap: () => context.push('/lab_results'),
                            ),
                            const SizedBox(height: 16),

                            FeatureTile.small(
                              title: 'Medications',
                              iconAsset: 'assets/icons/pill.svg',
                              badge: '+2',
                              onTap: () => context.push('/medications'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// Bottom Navigation
      bottomNavigationBar: const SafeArea(child: BottomNavBar()),
    );
  }
}
