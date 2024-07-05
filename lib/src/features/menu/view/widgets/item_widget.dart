import 'package:flutter_course/src/features/menu/models/item_model.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import 'package:flutter_course/src/theme/image_sources.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final ItemModel item;

  const ItemWidget({super.key, required this.item});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool get showQuantityButtons => _quantity > 0;

  int _quantity = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: widget.item.imagePath != null
                      ? Image.network(widget.item.imagePath!)
                      : Image.asset(ImageSources.coffeeIcon),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  widget.item.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SizedBox(
                  height: 24,
                  child: showQuantityButtons
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 24,
                              child: Ink(
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: AppColors.lightBlue),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _quantity--;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 9,
                                  ),
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: MediaQuery.sizeOf(context).width > 450
                                    ? const EdgeInsets.symmetric(horizontal: 8)
                                    : const EdgeInsets.symmetric(horizontal: 2),
                                child: SizedBox(
                                  height: 24,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      color: AppColors.lightBlue,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$_quantity',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              child: Ink(
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: AppColors.lightBlue),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_quantity < 10) {
                                        _quantity++;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 9,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : FilledButton(
                          onPressed: () {
                            setState(() {
                              _quantity = 1;
                            });
                          },
                          child: Text(
                            '${widget.item.price} р.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
