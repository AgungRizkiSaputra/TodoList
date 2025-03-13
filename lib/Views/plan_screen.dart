import 'package:flutter/material.dart';
import 'package:master_plan/Models/data_layer.dart';
import 'package:master_plan/Provider/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController =
        ScrollController()..addListener(() {
          FocusScope.of(context).requestFocus(FocusNode());
        });
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          Plan currentPlan = plans.firstWhere(
            (p) => p.name == widget.plan.name,
          );
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        int planIndex = plansNotifier.value.indexWhere(
          (p) => p.name == widget.plan.name,
        );
        if (planIndex != -1) {
          List<Task> updatedTasks = List<Task>.from(
            plansNotifier.value[planIndex].tasks,
          )..add(const Task());
          plansNotifier.value = List<Plan>.from(plansNotifier.value)
            ..[planIndex] = Plan(name: widget.plan.name, tasks: updatedTasks);
        }
      },
    );
  }

  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder:
          (context, index) => _buildTaskTile(plan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          int planIndex = plansNotifier.value.indexWhere(
            (p) => p.name == widget.plan.name,
          );
          if (planIndex != -1) {
            plansNotifier.value = List<Plan>.from(plansNotifier.value)
              ..[planIndex] = Plan(
                name: widget.plan.name,
                tasks: List<Task>.from(plansNotifier.value[planIndex].tasks)
                  ..[index] = Task(
                    description: task.description,
                    complete: selected ?? false,
                  ),
              );
          }
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          int planIndex = plansNotifier.value.indexWhere(
            (p) => p.name == widget.plan.name,
          );
          if (planIndex != -1) {
            plansNotifier.value = List<Plan>.from(plansNotifier.value)
              ..[planIndex] = Plan(
                name: widget.plan.name,
                tasks: List<Task>.from(plansNotifier.value[planIndex].tasks)
                  ..[index] = Task(description: text, complete: task.complete),
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
