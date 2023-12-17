import 'package:flutter/material.dart';

class SwitchTile extends StatelessWidget {
  final String text;
  final String description;
  final void Function (bool value) onFilter;
  final bool filter;

  const SwitchTile({Key? key, required this.onFilter, required this.text, required this.description, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SwitchListTile(
      value: filter,
      onChanged: (value) {
        onFilter(value);
      },
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 30, right: 25),
    );
  }
}
