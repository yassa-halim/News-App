import 'package:flutter/material.dart';
import 'package:news_c18_dokki/core/utils/extensions.dart';

class HomeDrawer extends StatelessWidget {
  final Function onHomePress;
  const HomeDrawer({required this.onHomePress , super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                "News",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              onHomePress();
            },
            child: Row(
              children: [
                Icon(Icons.home, color: context.colorScheme.primary),
                16.horizontalSpace,
                Text("Go To Home"),
              ],
            ).withHorizontalPadding(16).withVerticalPadding(8),
          ),
        ],
      ),
    );
  }
}
