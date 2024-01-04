import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart'
    as transaction;
import 'package:money_lover_clone/service_locator/service_locator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _transactionBloc = getIt.get<transaction.TransactionBloc>();

  @override
  void initState() {
    _transactionBloc.add(transaction.GetTransactionList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary500,
        shape: const CircleBorder(
          side: BorderSide(
            color: AppColors.primary500,
          ),
        ),
        foregroundColor: AppColors.neutral100,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const transaction.AddTransactionScreen(),
            ),
          );

          _transactionBloc.add(transaction.GetTransactionList());
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.large,
          child: BlocBuilder<transaction.TransactionBloc,
              transaction.TransactionState>(
            bloc: _transactionBloc,
            builder: (context, state) {
              if (state is transaction.Success) {
                final saldoPlus = state.transactionList!
                    .where((element) =>
                        element.category.type ==
                        transaction.TransactionType.income)
                    .map(
                      (e) => e.amount,
                    )
                    .toList()
                    .reduce((value, element) => value + element);
                final saldoMinus = state.transactionList!
                    .where((element) =>
                        element.category.type ==
                        transaction.TransactionType.expense)
                    .map(
                      (e) => e.amount,
                    )
                    .toList()
                    .reduce((value, element) => value + element);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SafeArea(
                      child: Text("Hallo, Dimas"),
                    ),
                    Gap.vLarge,
                    Container(
                      width: 1.sw,
                      padding: AppPaddings.medium,
                      decoration: BoxDecoration(
                        color: AppColors.primary500,
                        borderRadius: AppBorderRadiuses.medium,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap.vMedium,
                          const Text(
                            "Total saldo",
                            style: TextStyle(
                              color: AppColors.neutral100,
                            ),
                          ),
                          Gap.vSmall,
                          Text(
                            "Rp ${saldoPlus - saldoMinus}",
                            style: const TextStyle(
                              color: AppColors.neutral100,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap.vMedium,
                        ],
                      ),
                    ),
                    Gap.vLarge,
                    Gap.vLarge,
                    const Text("Daftar transaksi"),
                    Gap.vMedium,
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppBorderRadiuses.medium,
                      ),
                      child: Column(
                        children: state.transactionList!
                            .map((e) =>
                                transaction.TransactionItem(transaction: e))
                            .toList(),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
