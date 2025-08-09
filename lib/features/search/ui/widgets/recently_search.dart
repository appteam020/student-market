import 'package:flutter/material.dart';
import 'package:market_student/core/theme/colors.dart';

class RecentSearchItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RecentSearchItem({
    super.key,
    required this.text,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero, // هذا هو المهم
      leading: Icon(Icons.history, color: colors.textSecondary),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.textSecondary,
            ),
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: Icon(Icons.close, color: colors.textSecondary),
        onPressed: onDelete,
      ),
    );
  }
}
