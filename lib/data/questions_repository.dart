import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../domain/question.dart';

class QuestionsRepository {
  //asset JSON
  Future<List<Question>> loadQuestionsFromAsset(String assetPath) async {
    final jsonStr = await rootBundle.loadString(assetPath);
    final List data = json.decode(jsonStr) as List;
    return data.map((e) => Question.fromJson(e)).toList();
  }

  //carga por categoria
  Future<List<Question>> getQuestionsByCategory(String category) async {
  
    final file = 'assets/data/questions_colombia.json';
    final list = await loadQuestionsFromAsset(file);
    list.shuffle();
    return list.take(10).toList();
  }
}
