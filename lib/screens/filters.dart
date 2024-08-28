import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/widgets/filter_item.dart';
import 'package:meals_app/providers/filters_provider.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  @override
  void initState() {
    final activeFilters = ref.read(filtersProvider);
    _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
    _veganFilterSet = activeFilters[Filter.vegan]!;

    super.initState();
  }

  void _changeStateOfGlutenFree(bool isChecked) {
    setState(() {
      _glutenFreeFilterSet = isChecked;
    });
  }

  void _changeStateOfLactoseFree(bool isChecked) {
    setState(() {
      _lactoseFreeFilterSet = isChecked;
    });
  }

  void _changeStateOfVegetarian(bool isChecked) {
    setState(() {
      _vegetarianFilterSet = isChecked;
    });
  }

  void _changeStateOfVegan(bool isChecked) {
    setState(() {
      _veganFilterSet = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        // drawer: MainDrawer(onSelectScreen: (identifier) {
        //   Navigator.of(context).pop();
        //   if (identifier == 'meals') {
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (ctx) => const TabsScreen()));
        //   }
        // }),
        body: PopScope(
          canPop: true,
          onPopInvoked: (bool didPop) {
            if (didPop) return;
            ref.read(filtersProvider.notifier).setFilters({
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
              Filter.vegan: _veganFilterSet
            });
          },
          child: Column(
            children: [
              FilterItem(
                title: 'Gluten-free',
                subtitle: 'Only include gluten-free meals.',
                value: _glutenFreeFilterSet,
                onChanged: _changeStateOfGlutenFree,
              ),
              FilterItem(
                title: 'Lactose-free',
                subtitle: 'Only include lactose-free meals.',
                value: _lactoseFreeFilterSet,
                onChanged: _changeStateOfLactoseFree,
              ),
              FilterItem(
                title: 'Vegetarian',
                subtitle: 'Only include vegetarian meals.',
                value: _vegetarianFilterSet,
                onChanged: _changeStateOfVegetarian,
              ),
              FilterItem(
                title: 'Vegan',
                subtitle: 'Only include vegan meals.',
                value: _veganFilterSet,
                onChanged: _changeStateOfVegan,
              ),
            ],
          ),
        ));
  }
}
