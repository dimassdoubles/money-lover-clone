import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart'
    as transaction;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary500,
        shape: const CircleBorder(
          side: BorderSide(
            color: AppColors.primary500,
          ),
        ),
        foregroundColor: AppColors.neutral100,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const transaction.AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text("Dashboard"),
      ),
    );
  }
}
