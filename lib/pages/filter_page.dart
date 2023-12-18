import 'package:flutter/material.dart';

import '../widgets/switch_tile.dart';

enum Filters {
  glutenFree,
  vegan,
  lactoseFree,
  vegetarian,
}

class FilterPage extends StatefulWidget {
  final Map<Filters, bool> selectedFilters;
  const FilterPage({Key? key, required this.selectedFilters}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var _glutenFreeFilter = false;
  var _lactoseFreeFilter = false;
  var _vegetarianFreeFilter = false;
  var _veganFreeFilter = false;

  @override
  void initState() {
    _glutenFreeFilter = widget.selectedFilters[Filters.glutenFree]!;
    _lactoseFreeFilter = widget.selectedFilters[Filters.lactoseFree]!;
    _vegetarianFreeFilter = widget.selectedFilters[Filters.vegetarian]!;
    _veganFreeFilter = widget.selectedFilters[Filters.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) return;

          return Navigator.of(context).pop({
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
