import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/presentation/dashboard/onboarding/onboarding.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:flutter/material.dart';

import 'screens/dashboard_empty.dart';
import 'screens/dashboard_joined.dart';

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
    final param = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final startTutorial = param['startTutorial'] as bool? ?? false;

    return PopScope(
      canPop: false,
      child: FutureBuilder<bool>(
        future: _checkForJoinedBrgy(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const EBLoadingScreen(solid: true);
          } else {
            // If the Future is complete, show the appropriate view based on the result.
            if (startTutorial) return const OnBoardingView();
            return (snapshot.data == true) ? const JoinedDashboardView() : const EmptyDashboardView();
          }
        },
      ),
    );
  }
}
