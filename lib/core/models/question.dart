class Question {
  String id;
  String question;
  List<String> answers;

  Question({
    this.id,
    this.question,
    this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
      'answers': this.answers,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      question: map['question'],
      answers: (map['answers'] as List).map((value) => value.toString()).toList(),
    );
  }
}