import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';
import '../widgets/switch_tile.dart';

class FilterPage extends ConsumerWidget {
  const FilterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
      ),
      body: Column(
        children: [
          SwitchTile(
            text: "Gluten-free",
            description: "Only include gluten-free meals",
            filter: activeFilters[Filters.glutenFree]!,
            onFilter: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filters.glutenFree, value);
            },
          ),
          SwitchTile(
            text: "Vegan-free",
            description: "Only include vegan meals",
            filter: activeFilters[Filters.vegan]!,
            onFilter: (value) {
              ref.read(filterProvider.notifier).setFilter(Filters.vegan, value);
            },
          ),
          SwitchTile(
            text: "Lactose-free",
            description: "Only include lactose-free meals",
            filter: activeFilters[Filters.lactoseFree]!,
            onFilter: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filters.lactoseFree, value);
            },
          ),
          SwitchTile(
            text: "Vegetarian-free",
            description: "Only include vegetarian meals",
            filter: activeFilters[Filters.vegetarian]!,
            onFilter: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filters.vegetarian, value);
            },
          ),
        ],
      ),
    );
  }
}
