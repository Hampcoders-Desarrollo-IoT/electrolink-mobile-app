import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/dashboard_data.dart';

class QuickActionsSection extends StatelessWidget {
  final List<QuickAction> actions;
  final void Function(String label)? onActionTap;

  const QuickActionsSection({
    super.key,
    required this.actions,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 56,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: actions.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final action = actions[index];
              final isFirst = index == 0;
              return GestureDetector(
                onTap: () => onActionTap?.call(action.label),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.lightGray),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _iconForAction(action.icon),
                        size: 20,
                        color: isFirst ? AppColors.darkNavy : AppColors.grayText,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        action.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isFirst ? AppColors.darkNavy : AppColors.grayText,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _iconForAction(String icon) {
    switch (icon) {
      case 'add':
        return Icons.add_circle_outline;
      case 'receipt':
        return Icons.receipt_long_outlined;
      case 'support':
        return Icons.support_agent;
      case 'history':
        return Icons.history;
      default:
        return Icons.circle;
    }
  }
}
