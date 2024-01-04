import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

class SelectCategoryScreen extends StatefulWidget {
  final TransactionCategory? _currentCatgory;
  final void Function(TransactionCategory category)? _onSelectedCategory;
  const SelectCategoryScreen({
    super.key,
    void Function(TransactionCategory category)? onSelectedCategory,
    TransactionCategory? currentCategory,
  })  : _onSelectedCategory = onSelectedCategory,
        _currentCatgory = currentCategory;

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  TransactionType type = TransactionType.expense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pilih kategori transaksi",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: AppPaddings.large,
        child: Column(
          children: [
            Container(
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: AppBorderRadiuses.medium,
                border: Border.all(
                  color: AppColors.neutral200,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          type = TransactionType.expense;
                        });
                      },
                      borderRadius: AppBorderRadiuses.medium,
                      child: Container(
                        height: 42,
                        padding: AppPaddings.hMedium,
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadiuses.medium,
                          color: type == TransactionType.expense
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Pengeluaran",
                            style: TextStyle(
                              fontWeight: type == TransactionType.expense
                                  ? FontWeight.w500
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          type = TransactionType.income;
                        });
                      },
                      borderRadius: AppBorderRadiuses.medium,
                      child: Container(
                        height: 42,
                        padding: AppPaddings.hMedium,
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadiuses.medium,
                          color: type == TransactionType.income
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Pemasukan",
                            style: TextStyle(
                              fontWeight: type == TransactionType.income
                                  ? FontWeight.w500
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap.vLarge,
            Expanded(
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: TransactionCategory.dummy
                      .where((element) => element.type == type)
                      .map(
                        (e) => ListTile(
                          onTap: () {
                            widget._onSelectedCategory?.call(e);
                            Navigator.pop(context);
                          },
                          selected: e == widget._currentCatgory,
                          selectedColor: Colors.white,
                          selectedTileColor: AppColors.primary500,
                          title: Text(e.name),
                        ),
                      )
                      .toList(),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
