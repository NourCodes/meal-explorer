import 'package:flutter/material.dart';
import 'package:meal_app/widgets/tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function(String identifier) onSelectedPage;
  const MyDrawer({Key? key, required this.onSelectedPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text("Cooking",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ],
            ),
          ),
          myTile(
            icons: Icons.fastfood,
            text: "Meals",
            onTapped: () {
              onSelectedPage("meals");
            },
          ),
          myTile(
            icons: Icons.settings,
            text: "Filters",
            onTapped: () {
              onSelectedPage("filter");
            },
          ),
        ],
      ),
    );
  }
}
