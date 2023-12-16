import 'package:flutter/material.dart';

class myTile extends StatelessWidget {
  final IconData icons;
  final String text;
  final void Function ()? onTapped;
   const myTile({Key? key, required this.icons, required this.text, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Icon(
        icons,
        size: 20,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      onTap: onTapped,
    );
  }
}
