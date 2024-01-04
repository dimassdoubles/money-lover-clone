import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _amountCtrlr = TextEditingController(text: "0");

  @override
  void dispose() {
    _amountCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        title: const Text(
          "Tambah transaksi",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: AppPaddings.large,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: AppPaddings.hMedium,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.neutral900,
                          ),
                          borderRadius: AppBorderRadiuses.small,
                        ),
                        child: const Text("IDR"),
                      ),
                      Gap.hLarge,
                      Expanded(
                        child: TextFormField(
                          controller: _amountCtrlr,
                          style: const TextStyle(
                            color: AppColors.primary500,
                            fontSize: 32,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primary500,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primary500,
                                width: 2,
                              ),
                            ),
                          ),
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  Gap.vLarge,
                ],
              ),
            ),
          ),
          Container(
            padding: AppPaddings.large,
            color: AppColors.neutral100,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary500,
                foregroundColor: AppColors.neutral100,
                elevation: 0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.x3),
                width: 1.sw,
                child: const Text(
                  "Simpan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const Calculator(),
        ],
      ),
    );
  }
}
