import 'package:flutter/material.dart';

class MealDetailsRegularText extends StatelessWidget {
  const MealDetailsRegularText(
    this.content, {
    super.key,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Text(content,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground, fontSize: 16)),
    );
  }
}
