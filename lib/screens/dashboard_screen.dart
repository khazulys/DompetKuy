import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/user_provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/goal_provider.dart';
import '../models/transaction.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showExpense = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final transactionProvider = context.watch<TransactionProvider>();
    final goalProvider = context.watch<GoalProvider>();
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: context.theme.colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${userProvider.userName} 👋',
                style: context.theme.typography.xl3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kelola keuangan Anda dengan mudah',
                style: context.theme.typography.sm.copyWith(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 24),
              
              FCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Saldo',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currencyFormat.format(transactionProvider.totalBalance),
                        style: context.theme.typography.xl4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colors.foreground,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 16,
                                      color: context.theme.colors.mutedForeground,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Pemasukan',
                                      style: context.theme.typography.xs.copyWith(
                                        color: context.theme.colors.mutedForeground,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currencyFormat.format(transactionProvider.monthlyIncome),
                                  style: context.theme.typography.lg.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colors.foreground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 16,
                                      color: context.theme.colors.mutedForeground,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Pengeluaran',
                                      style: context.theme.typography.xs.copyWith(
                                        color: context.theme.colors.mutedForeground,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currencyFormat.format(transactionProvider.monthlyExpense),
                                  style: context.theme.typography.lg.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colors.foreground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Statistik Bulan Ini',
                    style: context.theme.typography.lg.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.theme.colors.foreground,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: context.theme.colors.muted,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _showExpense = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: !_showExpense
                                  ? context.theme.colors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Pemasukan',
                              style: context.theme.typography.xs.copyWith(
                                color: !_showExpense
                                    ? context.theme.colors.primaryForeground
                                    : context.theme.colors.mutedForeground,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _showExpense = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _showExpense
                                  ? context.theme.colors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Pengeluaran',
                              style: context.theme.typography.xs.copyWith(
                                color: _showExpense
                                    ? context.theme.colors.primaryForeground
                                    : context.theme.colors.mutedForeground,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              FCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildChartContent(transactionProvider, context),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Target Tabungan',
                style: context.theme.typography.lg.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 12),
              
              if (goalProvider.activeGoals.isEmpty)
                FCard(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Belum ada target tabungan',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
                )
              else
                ...goalProvider.activeGoals.take(3).map((goal) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FCard(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  goal.name,
                                  style: context.theme.typography.base.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colors.foreground,
                                  ),
                                ),
                                Text(
                                  '${(goal.progress * 100).toStringAsFixed(0)}%',
                                  style: context.theme.typography.sm.copyWith(
                                    color: context.theme.colors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: goal.progress,
                                backgroundColor: context.theme.colors.muted,
                                valueColor: AlwaysStoppedAnimation(
                                  context.theme.colors.primary,
                                ),
                                minHeight: 8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currencyFormat.format(goal.currentAmount),
                                  style: context.theme.typography.sm.copyWith(
                                    color: context.theme.colors.foreground,
                                  ),
                                ),
                                Text(
                                  currencyFormat.format(goal.targetAmount),
                                  style: context.theme.typography.sm.copyWith(
                                    color: context.theme.colors.mutedForeground,
                                  ),
                                ),
                              ],
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

  Widget _buildChartContent(
    TransactionProvider provider,
    BuildContext context,
  ) {
    final data = _showExpense 
        ? provider.expenseByCategory 
        : provider.incomeByCategory;
    
    if (data.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            _showExpense 
                ? 'Belum ada data pengeluaran bulan ini'
                : 'Belum ada data pemasukan bulan ini',
            style: context.theme.typography.sm.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: _buildPieChartSections(data, context),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              borderData: FlBorderData(show: false),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {},
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildLegend(data, context),
      ],
    );
  }

  Widget _buildLegend(
    Map<TransactionCategory, double> data,
    BuildContext context,
  ) {
    final total = data.values.fold<double>(0, (sum, value) => sum + value);
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: data.entries.map((entry) {
        final percentage = (entry.value / total * 100).toStringAsFixed(1);
        final color = _getCategoryColor(entry.key);
        
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 72) / 2,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getCategoryName(entry.key),
                      style: context.theme.typography.xs.copyWith(
                        color: context.theme.colors.foreground,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '$percentage% • ${currencyFormat.format(entry.value)}',
                      style: context.theme.typography.xs.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    Map<TransactionCategory, double> data,
    BuildContext context,
  ) {
    final total = data.values.fold<double>(0, (sum, value) => sum + value);
    
    return data.entries.map((entry) {
      final percentage = (entry.value / total * 100).toStringAsFixed(0);
      final color = _getCategoryColor(entry.key);
      
      return PieChartSectionData(
        value: entry.value,
        title: '$percentage%',
        color: color,
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        ),
      );
    }).toList();
  }

  Color _getCategoryColor(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.salary:
        return const Color(0xFF4CAF50);
      case TransactionCategory.business:
        return const Color(0xFF2196F3);
      case TransactionCategory.investment:
        return const Color(0xFF9C27B0);
      case TransactionCategory.food:
        return const Color(0xFFFF9800);
      case TransactionCategory.transport:
        return const Color(0xFF00BCD4);
      case TransactionCategory.shopping:
        return const Color(0xFFE91E63);
      case TransactionCategory.entertainment:
        return const Color(0xFFFF5722);
      case TransactionCategory.health:
        return const Color(0xFF8BC34A);
      case TransactionCategory.education:
        return const Color(0xFF3F51B5);
      case TransactionCategory.bills:
        return const Color(0xFFF44336);
      case TransactionCategory.other:
        return const Color(0xFF9E9E9E);
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
