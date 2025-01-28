import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:health_app/services/app/goal_service.dart';
import 'package:health_app/ui/widgets/conffit_goal.dart';
import 'package:health_app/ui/widgets/goal_card.dart';
import 'package:health_app/ui/widgets/text_animation.dart';
import 'package:provider/provider.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> with WidgetsBindingObserver {
  late final ConfettiController _confettiController;
  late final GoalService goalService;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      final goalService = Provider.of<GoalService>(context, listen: false);
      goalService.init();
    }
  }

  void _triggerConfetti() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    final GoalService goalService =
        Provider.of<GoalService>(context, listen: true);

    goalService.init();
    goalService.progressDailyComplete = _triggerConfetti;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GoalCard(
                  title: "Meta de atividade física",
                  progress: goalService.user!.progressPhisycalAtivity,
                  description: "Realizar 5 tipos de exercício diferentes",
                  onPressed: goalService.incrementProgressAtivity,
                ),
                GoalCard(
                  title: "Meta de ingestão de água",
                  progress: goalService.user!.progressWaterIngest,
                  description: "2 litros por dia",
                  onPressed: goalService.incrementProgressWaterIngest,
                ),
                GoalCard(
                  title: "Meta de sono",
                  progress: goalService.user!.progressSleep,
                  description: "8 horas de sono por noite",
                  onPressed: goalService.incrementProgressSleep,
                ),
                GoalCard(
                  title: "Meta de alimentação",
                  progress: goalService.user!.progressAliementation,
                  description: "5 refeições saudáveis por dia",
                  onPressed: goalService.incrementProgressAliementation,
                ),
                const SizedBox(height: 30),
                TextAnimation(textComplete: goalService.user!.textComplete),
              ],
            ),
          ),
          ConffitGoal(confettiController: _confettiController),
        ],
      ),
    );
  }
}
