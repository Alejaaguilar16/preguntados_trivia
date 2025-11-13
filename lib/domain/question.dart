class Question {
  final String id;
  final String image;
  final String text;
  final List<String> options;
  final String answer;

  Question({
    required this.id,
    required this.image,
    required this.text,
    required this.options,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'].toString(),
      image: json['image'] as String,
      text: json['text'] as String,
      options: List<String>.from(json['options'] ?? []),
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'text': text,
        'options': options,
        'answer': answer,
      };
}
