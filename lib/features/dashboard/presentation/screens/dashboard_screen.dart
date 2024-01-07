import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/auth/auth.dart' as auth;
import 'package:money_lover_clone/features/auth/presentation/presentation.dart';
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
  final _transactionListCubit = getIt.get<transaction.TransactionListCubit>();
  final _userCubit = getIt.get<auth.AppUserCubit>();

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
        child: BlocBuilder<transaction.TransactionListCubit,
            List<transaction.Transaction>>(
          bloc: _transactionListCubit,
          builder: (context, state) {
            final saldoPlusList = state
                .where((element) =>
                    element.category.type == transaction.TransactionType.income)
                .map(
                  (e) => e.amount,
                )
                .toList();
            int saldoPlus = 0;
            for (final amount in saldoPlusList) {
              saldoPlus += amount;
            }

            final saldoMinusList = state
                .where((element) =>
                    element.category.type ==
                    transaction.TransactionType.expense)
                .map(
                  (e) => e.amount,
                )
                .toList();

            int saldoMinus = 0;
            for (final amount in saldoMinusList) {
              saldoMinus += amount;
            }

            return Padding(
              padding: AppPaddings.large,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Hallo,"),
                              Text(
                                _userCubit.state!.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.logout,
                          ),
                        ),
                      ],
                    ),
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
                          "Rp ${CurrencyUtils.toIdr(saldoPlus - saldoMinus)}",
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
                      children: state
                          .map((e) =>
                              transaction.TransactionItem(transaction: e))
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
