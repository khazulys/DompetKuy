import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/user_provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction.dart';
import '../widgets/avatar_preview.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final transactionProvider = context.watch<TransactionProvider>();
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: context.theme.colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AvatarPreview(
                        config: userProvider.avatarConfig,
                        size: 48,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Halo, ${userProvider.userName}!',
                        style: context.theme.typography.xl2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colors.foreground,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: context.theme.colors.foreground,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              FCard(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saldo Saat Ini',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currencyFormat.format(transactionProvider.totalBalance),
                        style: context.theme.typography.xl5.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colors.foreground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Per ${dateFormat.format(now)}',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Ringkasan ${DateFormat('MMMM', 'id_ID').format(now)}',
                style: context.theme.typography.xl.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 16),
              
              FCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: transactionProvider.monthlyIncome,
                                    color: context.theme.colors.foreground,
                                    radius: 50,
                                    title: '',
                                  ),
                                  PieChartSectionData(
                                    value: transactionProvider.monthlyExpense,
                                    color: context.theme.colors.mutedForeground,
                                    radius: 50,
                                    title: '',
                                  ),
                                ],
                                sectionsSpace: 2,
                                centerSpaceRadius: 60,
                                borderData: FlBorderData(show: false),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sisa',
                                    style: context.theme.typography.sm.copyWith(
                                      color: context.theme.colors.mutedForeground,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currencyFormat.format(
                                      transactionProvider.monthlyIncome -
                                          transactionProvider.monthlyExpense,
                                    ),
                                    style: context.theme.typography.xl.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.theme.colors.foreground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: [
                          FCard(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: context.theme.colors.foreground,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Pemasukan',
                                          style: context.theme.typography.sm.copyWith(
                                            color: context.theme.colors.mutedForeground,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          currencyFormat.format(transactionProvider.monthlyIncome),
                                          style: context.theme.typography.xl.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: context.theme.colors.foreground,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          FCard(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: context.theme.colors.mutedForeground,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Pengeluaran',
                                          style: context.theme.typography.sm.copyWith(
                                            color: context.theme.colors.mutedForeground,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          currencyFormat.format(transactionProvider.monthlyExpense),
                                          style: context.theme.typography.xl.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: context.theme.colors.foreground,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Transaksi Terbaru',
                style: context.theme.typography.xl.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 16),
              
              if (transactionProvider.transactions.isEmpty)
                FCard(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Belum ada transaksi',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
                )
              else
                ...transactionProvider.transactions.take(4).map((transaction) {
                  final dateStr = DateFormat('dd MMM', 'id_ID').format(transaction.date);
                  final isIncome = transaction.type == TransactionType.income;
                  final amountStr = currencyFormat.format(transaction.amount);
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FCard(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: context.theme.colors.muted,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getCategoryIcon(transaction.category),
                            color: context.theme.colors.foreground,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          transaction.title,
                          style: context.theme.typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.theme.colors.foreground,
                          ),
                        ),
                        subtitle: Text(
                          _getCategoryName(transaction.category),
                          style: context.theme.typography.sm.copyWith(
                            color: context.theme.colors.mutedForeground,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${isIncome ? '+' : '-'} $amountStr',
                              style: context.theme.typography.base.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.theme.colors.foreground,
                              ),
                            ),
                            Text(
                              dateStr,
                              style: context.theme.typography.xs.copyWith(
                                color: context.theme.colors.mutedForeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.salary:
        return Icons.work_outline;
      case TransactionCategory.business:
        return Icons.business_center_outlined;
      case TransactionCategory.investment:
        return Icons.trending_up;
      case TransactionCategory.food:
        return Icons.restaurant_outlined;
      case TransactionCategory.transport:
        return Icons.directions_car_outlined;
      case TransactionCategory.shopping:
        return Icons.shopping_cart_outlined;
      case TransactionCategory.entertainment:
        return Icons.movie_outlined;
      case TransactionCategory.health:
        return Icons.local_hospital_outlined;
      case TransactionCategory.education:
        return Icons.school_outlined;
      case TransactionCategory.bills:
        return Icons.receipt_outlined;
      case TransactionCategory.other:
        return Icons.more_horiz;
    }
  }

  String _getCategoryName(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.salary:
        return 'Gaji';
      case TransactionCategory.business:
        return 'Bisnis';
      case TransactionCategory.investment:
        return 'Investasi';
      case TransactionCategory.food:
        return 'Makanan';
      case TransactionCategory.transport:
        return 'Transport';
      case TransactionCategory.shopping:
        return 'Belanja';
      case TransactionCategory.entertainment:
        return 'Hiburan';
      case TransactionCategory.health:
        return 'Kesehatan';
      case TransactionCategory.education:
        return 'Pendidikan';
      case TransactionCategory.bills:
        return 'Tagihan';
      case TransactionCategory.other:
        return 'Lainnya';
    }
  }
}
