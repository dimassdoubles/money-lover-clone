import 'package:money_lover_clone/features/transaction/transaction.dart';

class TransactionMapper {
  TransactionMapper._();
  static Transaction fromJson(String id, Map<String, dynamic> json) {
    late TransactionType type;

    switch (json["categoryType"]) {
      case "expense":
        type = TransactionType.expense;
        break;
      case "income":
        type = TransactionType.income;
        break;
    }

    return Transaction(
      id: id,
      amount: json["amount"],
      category: TransactionCategory(
        name: json["categoryName"],
        iconPath: json["categoryIconPath"],
        type: type,
      ),
      description: json["description"],
      dateTime: DateTime.parse(json["dateTime"]),
      image: json["image"],
    );
  }
}
