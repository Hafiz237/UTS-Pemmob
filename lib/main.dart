import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'core/responsive.dart';
import 'providers/quiz_provider.dart';
import 'widgets/app_button.dart';
import 'widgets/category_tag.dart';
import 'widgets/option_card.dart';
import 'widgets/quiz_progress_bar.dart';
import 'widgets/terminal_card.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KuisKita',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  OptionState _stateFor(int i, QuizProvider quiz) {
    if (!quiz.isAnswered) return OptionState.idle;
    if (i == quiz.currentQuestion.correctIndex) return OptionState.correct;
    if (i == quiz.selectedAnswer) return OptionState.wrong;
    return OptionState.dimmed;
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final q = quiz.currentQuestion;
    final scheme = Theme.of(context).colorScheme;
    final gap = Responsive.u(context, 0.04);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Responsive.u(context, 0.05)),
            child: ConstrainedBox(
              constraints:
              BoxConstraints(maxWidth: Responsive.contentWidth(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                  TerminalCard(
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
                  ),
                  SizedBox(height: gap),
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
                          onPressed: quiz.isFirst
                              ? null
                              : context.read<QuizProvider>().previous,
                        ),
                      ),
                      SizedBox(width: gap),
                      Expanded(
                        child: AppButton(
                          label: quiz.isLast ? 'Selesai' : 'Lanjut',
                          icon: Icons.arrow_forward_rounded,
                          onPressed: quiz.isAnswered && !quiz.isLast
                              ? context.read<QuizProvider>().next
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}