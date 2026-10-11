import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_image.dart';
import '../widgets/terminal_card.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: context.read<QuizProvider>().userName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    final name = _controller.text.trim();
    if (name.length < 2) {
      setState(() => _error = 'Nama minimal 2 karakter');
      return;
    }
    final quiz = context.read<QuizProvider>();
    quiz.setUserName(name);
    quiz.restart();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuizPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final gap = Responsive.u(context, 0.04);
    final total = context.read<QuizProvider>().totalQuestions;

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
                  const Align(
                    alignment: Alignment.centerRight,
                    child: ThemeToggleButton(),
                  ),
                  Center(
                    child: AppImage(
                      asset: 'assets/images/logo.png',
                      fallbackIcon: Icons.terminal_rounded,
                      size: Responsive.u(context, 0.35),
                    ),
                  ),
                  SizedBox(height: gap),
                  Text(
                    'KuisKita',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.font(context, 0.1, max: 52),
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                    ),
                  ),
                  Text(
                    'Jelajah Dunia Digital · $total misi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontWeight: FontWeight.w700,
                      fontSize: Responsive.font(context, 0.034),
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: gap * 1.5),
                  TerminalCard(
                    title: 'login.sh',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '> masukkan nama pemain',
                          style: TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontWeight: FontWeight.w700,
                            fontSize: Responsive.font(context, 0.036),
                            color: scheme.primary,
                          ),
                        ),
                        SizedBox(height: gap * 0.6),
                        TextField(
                          controller: _controller,
                          maxLength: 20,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                            fontSize: Responsive.font(context, 0.045),
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (_) {
                            if (_error != null) setState(() => _error = null);
                          },
                          onSubmitted: (_) => _start(),
                          decoration: InputDecoration(
                            hintText: 'contoh: Budi',
                            counterText: '',
                            errorText: _error,
                            prefixIcon: const Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Responsive.u(context, 0.03)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: gap * 1.5),
                  AppButton(
                    label: 'Mulai Misi',
                    icon: Icons.play_arrow_rounded,
                    onPressed: _start,
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