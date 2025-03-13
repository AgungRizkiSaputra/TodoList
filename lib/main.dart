import 'package:flutter/material.dart';
import 'package:master_plan/Models/plan.dart';
import 'package:master_plan/Provider/plan_provider.dart';
import 'package:master_plan/Views/plan_creator_screen.dart';
import 'package:master_plan/Views/plan_screen.dart';

void main() => runApp(MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
      notifier: ValueNotifier<List<Plan>>(const []),
      child: MaterialApp(
        title: 'State management app',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const PlanCreatorScreen(),
      ),
    );
  }
}
