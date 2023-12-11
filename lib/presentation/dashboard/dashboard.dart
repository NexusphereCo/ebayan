import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/presentation/dashboard/onboarding/onboarding.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/loading.dart';

import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final BarangayController brgyController = BarangayController();

  Future<bool> checkForJoinedBrgy() async {
    return await brgyController.hasJoinedBrgy();
  }

  @override
  Widget build(BuildContext context) {
    final param = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final startTutorial = param['startTutorial'] as bool? ?? false;

    return PopScope(
      canPop: false,
      child: FutureBuilder(
        future: checkForJoinedBrgy(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const EBCustomLoadingScreen(solid: true);
            case ConnectionState.done:
              bool hasJoinedBrgy = snapshot.data!;

              if (startTutorial) return const OnBoardingView();

              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushReplacementNamed(
                  hasJoinedBrgy ? Routes.dashboardJoined : Routes.dashboardEmpty,
                );
              });
            default:
          }
          return const EBCustomLoadingScreen(solid: true);
        },
      ),
    );
  }
}
