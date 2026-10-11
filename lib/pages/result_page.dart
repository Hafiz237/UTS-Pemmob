import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../core/responsive.dart';
import '../models/question.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_image.dart';
import '../widgets/category_tag.dart';
import '../widgets/terminal_card.dart';
import '../widgets/theme_toggle_button.dart';
import '../widgets/adaptive_pane.dart';
import 'quiz_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  void _playAgain(BuildContext context) {
    context.read<QuizProvider>().restart();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const QuizPage()),
    );
  }

  void _changePlayer(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final scheme = Theme.of(context).colorScheme;
    final gap = Responsive.u(context, 0.04);

    final summary = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: AppImage(
            asset: 'assets/images/trophy.png',
            fallbackIcon: Icons.emoji_events_rounded,
            size: Responsive.u(context, 0.3),
          ),
        ),
        SizedBox(height: gap),
        Text(
          'Misi selesai, ${quiz.userName}!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.font(context, 0.06),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: gap),
        TerminalCard(
          title: 'hasil.log',
          child: Column(
            children: [
              Text(
                '${quiz.score}/${quiz.totalQuestions}',
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontWeight: FontWeight.w700,
                  fontSize: Responsive.font(context, 0.15, max: 64),
                  color: scheme.primary,
                ),
              ),
              Text(
                'Nilai: ${quiz.percentage}',
                style: TextStyle(
                  fontSize: Responsive.font(context, 0.04),
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: gap * 0.6),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.u(context, 0.04),
                  vertical: Responsive.u(context, 0.02),
                ),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius:
                  BorderRadius.circular(Responsive.u(context, 0.03)),
                ),
                child: Text(
                  'RANK: ${quiz.rank}',
                  style: TextStyle(
                    fontFamily: 'JetBrainsMono',
                    fontWeight: FontWeight.w700,
                    fontSize: Responsive.font(context, 0.04),
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TerminalCard(
          title: 'review.log',
          child: Column(
            children: [
              for (int i = 0; i < quiz.totalQuestions; i++)
                _ReviewRow(
                  number: i + 1,
                  question: quiz.questions[i],
                  isCorrect: quiz.isCorrectAt(i),
                ),
            ],
          ),
        ),
        SizedBox(height: gap * 1.5),
        AppButton(
          label: 'Main Lagi',
          icon: Icons.replay_rounded,
          onPressed: () => _playAgain(context),
        ),
        SizedBox(height: gap * 0.6),
        AppButton(
          label: 'Ganti Pemain',
          icon: Icons.person_rounded,
          filled: false,
          onPressed: () => _changePlayer(context),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Responsive.u(context, 0.05)),
            child: ConstrainedBox(
              constraints:
              BoxConstraints(maxWidth: Responsive.pageWidth(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: ThemeToggleButton(),
                  ),
                  AdaptivePane(first: summary, second: details),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.number,
    required this.question,
    required this.isCorrect,
  });

  final int number;
  final Question question;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = isCorrect ? AppColors.success(context) : scheme.error;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.u(context, 0.02)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: color,
            size: Responsive.font(context, 0.06),
          ),
          SizedBox(width: Responsive.u(context, 0.03)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryTag(label: question.category),
                SizedBox(height: Responsive.u(context, 0.015)),
                Text(
                  '$number. ${question.text}',
                  style: TextStyle(
                    fontSize: Responsive.font(context, 0.038),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!isCorrect)
                  Text(
                    'Jawaban benar: ${question.options[question.correctIndex]}',
                    style: TextStyle(
                      fontSize: Responsive.font(context, 0.034),
                      color: color,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}