import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.star),
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
            Image.network(meal.imageUrl,
                height: 300, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ingredients',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    for (final String ingredient in meal.ingredients)
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Text(ingredient,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16)),
                      ),
                    const SizedBox(height: 14),
                    Text('Steps',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    for (int index = 0; index < meal.steps.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Text('${index + 1}. ${meal.steps[index]}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16)),
                      )
                  ]),
            ),
            const SizedBox(height: 14),
          ],
        ));
  }
}
