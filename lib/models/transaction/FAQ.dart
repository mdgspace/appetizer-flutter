// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

Faq faqFromJson(String str) => Faq.fromJson(json.decode(str));

String faqToJson(Faq data) => json.encode(data.toJson());

class Faq {
  String id;
  String question;
  String answer;

  Faq({
    this.id,
    this.question,
    this.answer,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => new Faq(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
  };
}
