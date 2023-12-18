import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';
import '../widgets/switch_tile.dart';

class FilterPage extends ConsumerStatefulWidget {
  const FilterPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage> {
  var _glutenFreeFilter = false;
  var _lactoseFreeFilter = false;
  var _vegetarianFreeFilter = false;
  var _veganFreeFilter = false;

  @override
  void initState() {
    final activeFilters = ref.read(filterProvider);
    _glutenFreeFilter = activeFilters[Filters.glutenFree]!;
    _lactoseFreeFilter = activeFilters[Filters.lactoseFree]!;
    _vegetarianFreeFilter = activeFilters[Filters.vegetarian]!;
    _veganFreeFilter = activeFilters[Filters.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
      ),
      body: PopScope(
        onPopInvoked: (didPop) async {
          ref.read(filterProvider.notifier).setFilters({
            Filters.glutenFree: _glutenFreeFilter,
            Filters.lactoseFree: _lactoseFreeFilter,
            Filters.vegan: _veganFreeFilter,
            Filters.vegetarian: _vegetarianFreeFilter,
          });
        },
        child: Column(
          children: [
            SwitchTile(
              text: "Gluten-free",
              description: "Only include gluten-free meals",
              filter: _glutenFreeFilter,
              onFilter: (value) {
                setState(() {
                  _glutenFreeFilter = value;
                });
              },
            ),
            SwitchTile(
              text: "Vegan-free",
              description: "Only include vegan meals",
              filter: _veganFreeFilter,
              onFilter: (value) {
                setState(() {
                  _veganFreeFilter = value;
                });
              },
            ),
            SwitchTile(
              text: "Lactose-free",
              description: "Only include lactose-free meals",
              filter: _lactoseFreeFilter,
              onFilter: (value) {
                setState(() {
                  _lactoseFreeFilter = value;
                });
              },
            ),
            SwitchTile(
              text: "Vegetarian-free",
              description: "Only include vegetarian meals",
              filter: _vegetarianFreeFilter,
              onFilter: (value) {
                setState(() {
                  _vegetarianFreeFilter = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
