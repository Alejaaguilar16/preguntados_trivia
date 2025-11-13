import 'package:flutter_test/flutter_test.dart';
import 'package:preguntados_trivia/domain/question.dart';
import 'package:preguntados_trivia/domain/game_controller.dart';

void main() {
  group('GameController', () {
    final questions = [
      Question(id: '1', image: '', text: 'q1', options: ['a','b','c','d'], answer: 'a'),
      Question(id: '2', image: '', text: 'q2', options: ['a','b','c','d'], answer: 'b'),
    ];

    test('submit correct answer increases score', () {
      final controller = GameController(questions: questions);
      expect(controller.score, 0);
      final wasCorrect = controller.submitAnswer('a');
      expect(wasCorrect, true);
      expect(controller.score, 1);
      //advance
      controller.nextQuestion();
      final wasCorrect2 = controller.submitAnswer('x');
      expect(wasCorrect2, false);
      expect(controller.incorrectCount, 1);
    });

    test('restart resets state', () {
      final controller = GameController(questions: questions);
      controller.submitAnswer('a');
      controller.nextQuestion();
      controller.submitAnswer('x');
      expect(controller.score, 1);
      expect(controller.incorrectCount, 1);
      controller.restart();
      expect(controller.score, 0);
      expect(controller.incorrectCount, 0);
      expect(controller.currentIndex, 0);
    });
  });
}
