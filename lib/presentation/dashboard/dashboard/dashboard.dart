import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/presentation/dashboard/onboarding/onboarding.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:flutter/material.dart';

import 'widgets/dashboard_empty.dart';
import 'widgets/dashboard_joined.dart';

/*
  Authored by: Miguel Damien L. Garcera
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-004] Dashboard (Resident) Screen
  Description: a dashboard screen for brgy. officials/residents to use. 
    after registering/logging in, users are redirected to this dashboard
    screen which will contain their list of barangay spheres.

    users after creating an account, will have an interactive guide/tutorial
    for navigating the dashboard.
 */

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final BarangayController _brgyController = BarangayController();

  Future<bool> _checkForJoinedBrgy() async {
    return await _brgyController.hasJoinedBrgy();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final startTutorial = (args != null && args is Map && args['startTutorial'] == true);

    return WillPopScope(
      onWillPop: () async => false,
      child: FutureBuilder<bool>(
        future: _checkForJoinedBrgy(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const EBLoadingScreen(solid: true);
          } else {
            // If the Future is complete, show the appropriate view based on the result.
            return snapshot.data == true
                ? (startTutorial)
                    ? const OnBoardingView()
                    : const JoinedDashboardView()
                : const EmptyDashboardView();
          }
        },
      ),
    );
  }
}
