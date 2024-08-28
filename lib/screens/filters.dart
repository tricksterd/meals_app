import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/widgets/filter_item.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          FilterItem(
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (bool isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
          ),
          FilterItem(
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (bool isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
          ),
          FilterItem(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (bool isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
          ),
          FilterItem(
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            value: activeFilters[Filter.vegan]!,
            onChanged: (bool isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
          ),
        ],
      ),
    );
  }
}
