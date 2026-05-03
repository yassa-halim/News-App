import 'package:flutter/material.dart';
import 'package:news_c18_dokki/core/utils/extensions.dart';
import 'package:news_c18_dokki/data/models/category.dart';

class HomeTab extends StatelessWidget {

  final Function(Category) onCategorySelected;
  const HomeTab({required this.onCategorySelected , super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: categories.length,
      separatorBuilder: (_, _) => 16.verticalSpace,
      itemBuilder: (_, index) => InkWell(
        onTap: (){
          onCategorySelected(categories[index]);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(categories[index].image.getImagePath(context)),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  index % 2 == 0
                      ? Expanded(child: 0.horizontalSpace)
                      : 0.horizontalSpace,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: .spaceBetween,
                      crossAxisAlignment: .center,
                      children: [
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            fontSize: 24,
                            color: context.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface.withAlpha(80),
                            borderRadius: BorderRadiusGeometry.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              index % 2 != 0
                                  ? Container(
                                      padding: .all(16),
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.surface,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 32,
                                        color: context.colorScheme.primary,
                                      ),
                                    )
                                  : 0.horizontalSpace,

                              Text(
                                "View All",
                                style: context.textTheme.labelLarge!.copyWith(
                                  fontSize: 20,
                                ),
                              ).withPadding(12),
                              index % 2 == 0
                                  ? Container(
                                      padding: .all(16),
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.surface,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 32,
                                        color: context.colorScheme.primary,
                                      ),
                                    )
                                  : 0.horizontalSpace,
                            ],
                          ),
                        ),
                      ],
                    ).withVerticalPadding(24).withHorizontalPadding(8),
                  ),
                  index % 2 != 0
                      ? Expanded(child: 0.horizontalSpace)
                      : 0.horizontalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
