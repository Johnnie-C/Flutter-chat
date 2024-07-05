import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.actions
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: Navigator.canPop(context)
          ? _backButton(context)
          : null,
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _backButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).colorScheme.onSurface,
        size: 24,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
