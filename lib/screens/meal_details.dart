import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/widgets/meal_details_regular_text.dart';
import 'package:meals_app/widgets/meal_details_title.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                        turns: Tween<double>(begin: 0.8, end: 1.0)
                            .animate(animation),
                        child: child);
                  },
                  child: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    key: ValueKey(isFavorite),
                  )),
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? 'Meal added as a favorite!'
                        : 'Meal removed.')));
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(meal.imageUrl,
                  height: 300, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MealDetailsTitle('Ingredients'),
                    const SizedBox(height: 5),
                    for (final String ingredient in meal.ingredients)
                      MealDetailsRegularText(ingredient),
                    const SizedBox(height: 14),
                    const MealDetailsTitle('Steps'),
                    const SizedBox(height: 5),
                    for (int index = 0; index < meal.steps.length; index++)
                      MealDetailsRegularText(
                          '${index + 1}. ${meal.steps[index]}'),
                  ]),
            ),
            const SizedBox(height: 14),
          ],
        ));
  }
}
