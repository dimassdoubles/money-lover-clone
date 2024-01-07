import 'package:equatable/equatable.dart';

enum TransactionType {
  expense,
  income;
}

class TransactionCategory extends Equatable {
  final String name;
  final String iconPath;
  final TransactionType type;
  const TransactionCategory({
    required this.name,
    required this.iconPath,
    required this.type,
  });

  static List<TransactionCategory> get dummy {
    return _examples;
  }

  @override
  List<Object?> get props => [
        name,
        iconPath,
        type,
      ];
}

List<TransactionCategory> _examples = [
  const TransactionCategory(
    name: "Gaji",
    iconPath: "assets/icons/profits.png",
    type: TransactionType.income,
  ),
  const TransactionCategory(
    name: "Pemberian",
    iconPath: "assets/icons/profits.png",
    type: TransactionType.income,
  ),
  const TransactionCategory(
    name: "Makan & minum",
    iconPath: "assets/icons/spending.png",
    type: TransactionType.expense,
  ),
  const TransactionCategory(
    name: "Tagihan",
    iconPath: "assets/icons/spending.png",
    type: TransactionType.expense,
  ),
  const TransactionCategory(
    name: "Transportasi",
    iconPath: "assets/icons/spending.png",
    type: TransactionType.expense,
  ),
  const TransactionCategory(
    name: "Belanja",
    iconPath: "assets/icons/spending.png",
    type: TransactionType.expense,
  ),
  const TransactionCategory(
    name: "Sedekah",
    iconPath: "assets/icons/spending.png",
    type: TransactionType.expense,
  ),
];
