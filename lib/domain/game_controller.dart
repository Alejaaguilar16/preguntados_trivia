import 'question.dart';

class GameController {
  final List<Question> questions;
  int currentIndex = 0;
  int score = 0;
  int incorrectCount = 0;
  String? selectedOption;

  GameController({required this.questions});

  Question get currentQuestion => questions[currentIndex];
  bool get isLastQuestion => currentIndex >= questions.length - 1;
  bool get isFinished => currentIndex >= questions.length;

  //Devuelve true si la respuesta fue correcta
  bool submitAnswer(String option) {
    if (isFinished) return false;
    selectedOption = option;
    final correct = currentQuestion.answer;
    final wasCorrect = option == correct;
    if (wasCorrect) score++;
    else incorrectCount++;
    return wasCorrect;
  }

  //Devuelve true si hay siguiente
  bool nextQuestion() {
    if (isLastQuestion) {
      currentIndex = questions.length; 
      return false;
    } else {
      currentIndex++;
      selectedOption = null;
      return true;
    }
  }

  void restart() {
    currentIndex = 0;
    score = 0;
    incorrectCount = 0;
    selectedOption = null;
  }
}
