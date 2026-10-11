import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/category_tag.dart';
import '../widgets/option_card.dart';
import '../widgets/quiz_progress_bar.dart';
import '../widgets/terminal_card.dart';
import '../widgets/theme_toggle_button.dart';
import '../widgets/adaptive_pane.dart';
import 'result_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  OptionState _stateFor(int i, QuizProvider quiz) {
    if (!quiz.isAnswered) return OptionState.idle;
    if (i == quiz.currentQuestion.correctIndex) return OptionState.correct;
    if (i == quiz.selectedAnswer) return OptionState.wrong;
    return OptionState.dimmed;
  }

  Future<void> _confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres kuis ini akan direset.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Lanjut main'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (leave == true && context.mounted) Navigator.of(context).pop();
  }

  void _onNext(BuildContext context, QuizProvider quiz) {
    if (quiz.isLast) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ResultPage()),
      );
    } else {
      context.read<QuizProvider>().next();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final q = quiz.currentQuestion;
    final scheme = Theme.of(context).colorScheme;
    final gap = Responsive.u(context, 0.04);

    final questionCard = TerminalCard(
      title: 'soal_${quiz.currentIndex + 1}.exe',
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: '> ',
            style: TextStyle(
              color: scheme.primary,
              fontFamily: 'JetBrainsMono',
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: q.text),
        ]),
        style: TextStyle(
          fontSize: Responsive.font(context, 0.048),
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
      ),
    );

    final answerPanel = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < q.options.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: gap * 0.6),
            child: OptionCard(
              index: i,
              text: q.options[i],
              state: _stateFor(i, quiz),
              onTap: quiz.isAnswered
                  ? null
                  : () => context.read<QuizProvider>().selectAnswer(i),
            ),
          ),
        if (quiz.isAnswered) ...[
          Text(
            q.explanation,
            style: TextStyle(
              fontSize: Responsive.font(context, 0.038),
              color: scheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: gap),
        ],
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Kembali',
                icon: Icons.arrow_back_rounded,
                filled: false,
                onPressed:
                quiz.isFirst ? null : context.read<QuizProvider>().previous,
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: AppButton(
                label: quiz.isLast ? 'Selesai' : 'Lanjut',
                icon: quiz.isLast
                    ? Icons.flag_rounded
                    : Icons.arrow_forward_rounded,
                onPressed: quiz.isAnswered ? () => _onNext(context, quiz) : null,
              ),
            ),
          ],
        ),
      ],
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(context);
      },
      child: Scaffold(
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
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'Keluar',
                          onPressed: () => _confirmExit(context),
                          icon: const Icon(Icons.close_rounded),
                        ),
                        Expanded(
                          child: Text(
                            '@${quiz.userName}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'JetBrainsMono',
                              fontWeight: FontWeight.w700,
                              fontSize: Responsive.font(context, 0.036),
                              color: scheme.primary,
                            ),
                          ),
                        ),
                        const ThemeToggleButton(),
                      ],
                    ),
                    SizedBox(height: gap * 0.5),
                    QuizProgressBar(
                      results: quiz.results,
                      currentIndex: quiz.currentIndex,
                    ),
                    SizedBox(height: gap),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryTag(label: q.category),
                        Text(
                          '${quiz.currentIndex + 1}/${quiz.totalQuestions}',
                          style: TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontWeight: FontWeight.w700,
                            fontSize: Responsive.font(context, 0.04),
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: gap),
                    AdaptivePane(first: questionCard, second: answerPanel),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}