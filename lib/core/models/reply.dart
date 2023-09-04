class Reply {
  String id;
  String questionId;
  String replier;
  String answer;
  DateTime repliedAt;
  String repliedAtStr;

  Reply({
    this.id,
    this.replier,
    this.answer,
    this.repliedAt,
    this.repliedAtStr,
    this.questionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'replier': this.replier,
      'answer': this.answer,
      'repliedAt': this.repliedAt,
      'repliedAtStr': this.repliedAtStr,
    };
  }

  factory Reply.fromMap(Map<String, dynamic> map) {
    return Reply(
      id: map['id'],
      replier: map['replier'],
      repliedAt: (map['repliedAt'] is DateTime)
        ? map['repliedAt']
        : map['repliedAt'].toDate(),
      repliedAtStr: map['repliedAtStr'],
      answer: map['answer'],
    );
  }
}