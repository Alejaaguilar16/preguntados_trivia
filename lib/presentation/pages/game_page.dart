import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/question.dart';
import '../../domain/game_controller.dart';
import '../../data/questions_repository.dart';

class GamePage extends StatefulWidget {
  final String categoria;
  const GamePage({super.key, required this.categoria});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final QuestionsRepository _repo = QuestionsRepository();
  GameController? _controller;
  bool _loading = true;
  bool _showCountdown = true;
  int _countdown = 3;

  Timer? _questionTimer;
  int _timeLeft = 10;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _loading = true;
    });
    final questions = await _repo.getQuestionsByCategory(widget.categoria);
    _controller = GameController(questions: questions);
    setState(() {
      _loading = false;
      _showCountdown = true;
      _countdown = 3;
    });
    _startPreCountdown();
  }

  Future<void> _startPreCountdown() async {
    for (int i = 3; i > 0; i--) {
      setState(() => _countdown = i);
      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() {
      _showCountdown = false;
    });
    _startQuestionTimer();
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    setState(() => _timeLeft = 10);
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => _timeLeft--);
      if (_timeLeft <= 0) {
        t.cancel();
        _onTimeUp();
      }
    });
  }

  void _onTimeUp() {
    //mostrar diálogo de tiempo
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('¡Se acabó el tiempoooooooo!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/tiempo.gif', height: 120),
            const SizedBox(height: 10),
            const Text('Perdiste el tiempo para responder.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Salir'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _restartGame();
            },
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }

  void _submitAnswer(String option) {
    if (_controller == null) return;
    final wasCorrect = _controller!.submitAnswer(option);
    //detener timer momentáneamente
    _questionTimer?.cancel();
    setState(() {});
    //mostrar color (la UI cambia según controller.selectedOption)
    Future.delayed(const Duration(seconds: 1), () {
      if (_controller!.incorrectCount >= 2) {
        _showLostDialog();
      } else if (!_controller!.nextQuestion()) {
        _showEndDialog();
      } else {
        //siguiente pregunta: reset timer
        setState(() => _timeLeft = 10);
        _startQuestionTimer();
      }
    });
  }

  void _showLostDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('¡Has perdido!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/gameover.gif', height: 150),
            const SizedBox(height: 10),
            const Text('Has cometido dos errores. ¡Inténtalo de nuevo!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Salir'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _restartGame();
            },
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }

  void _showEndDialog() {
    if (!mounted || _controller == null) return;
    final c = _controller!;
    if (c.score == c.questions.length) {
      //todas correctas
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text(' ¡Felicitacionessssssssssss, eres muy inteligenteeee!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/felicitaciones.gif', height: 150),
              const SizedBox(height: 10),
              const Text('¡Completaste todo!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Juego terminado'),
          content: Text('Tu puntaje: ${c.score} / ${c.questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Salir'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _restartGame();
              },
              child: const Text('Reiniciar'),
            ),
          ],
        ),
      );
    }
  }

  void _restartGame() {
    _questionTimer?.cancel();
    _controller?.restart();
    setState(() {
      _showCountdown = true;
      _countdown = 3;
    });
    _startPreCountdown();
  }

  @override
  void dispose() {
    _questionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final c = _controller!;
    final q = c.currentQuestion;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/fondo2.png', fit: BoxFit.cover)),
          Container(), ////////COLORRRR
          SafeArea(
            child: Center(
              child: _showCountdown
                  ? Text('$_countdown', style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Barra superior
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.exit_to_app, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text('$_timeLeft s', style: const TextStyle(color: Colors.yellow, fontSize: 22)),
                            IconButton(icon: const Icon(Icons.refresh, color: Colors.white), onPressed: _restartGame),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Image.asset(q.image, height: 200, fit: BoxFit.contain),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(q.text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 30),
/// Opciones
...q.options.map((option) {
  Color btnColor = Colors.pinkAccent;
  if (c.selectedOption != null) {
    if (option == q.answer) btnColor = Colors.green;
    else if (option == c.selectedOption && option != q.answer) btnColor = Colors.red;
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        minimumSize: const Size(250, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: c.selectedOption == null ? () => _submitAnswer(option) : () {},
      child: Text(option, style: TextStyle(fontSize: 18, color: Colors.white)),
    ),
  );
}).toList(),

                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
