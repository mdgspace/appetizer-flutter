// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

List<Faq> faqFromJson(String str) =>
    List<Faq>.from(json.decode(str).map((x) => Faq.fromJson(x)));

String faqToJson(List<Faq> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Faq {
  int id;
  String question;
  String answer;

  Faq({
    this.id,
    this.question,
    this.answer,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json['id'],
        question: json['question'],
        answer: json['answer'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answer': answer,
      };
}
