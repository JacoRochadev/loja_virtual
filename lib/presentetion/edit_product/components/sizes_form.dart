import 'package:flutter/material.dart';
import 'package:loja_virtual/components/custom_icon_button.dart';
import 'package:loja_virtual/models/item_size.dart';
import '../../../models/product.dart';
import 'edit_item_size.dart';

class SizesForm extends StatelessWidget {
  final ProductModel product;
  const SizesForm({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormField<List<ItemSize>>(
          initialValue: product.sizes,
          validator: (sizes) {
            if (sizes.isEmpty) {
              return 'Insira um tamanho';
            }
            return null;
          },
          builder: (state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tamanhos',
                      style: Theme.of(context).textTheme.titleMedium.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    CustomIconButton(
                      iconData: Icons.add,
                      color: Colors.black,
                      onTap: () {
                        state.value.add(ItemSize());
                        state.didChange(state.value);
                      },
                    ),
                  ],
                ),
                Column(
                  children: state.value.map((size) {
                    return EditItemSize(
                      key: ObjectKey(size),
                      size: size,
                      onRemove: () {
                        state.value.remove(size);
                        state.didChange(state.value);
                      },
                      onMoveUp: size != state.value.first
                          ? () {
                              final index = state.value.indexOf(size);
                              state.value.remove(size);
                              state.value.insert(index - 1, size);
                              state.didChange(state.value);
                            }
                          : null,
                      onMoveDown: size != state.value.last
                          ? () {
                              final index = state.value.indexOf(size);
                              state.value.remove(size);
                              state.value.insert(index + 1, size);
                              state.didChange(state.value);
                            }
                          : null,
                    );
                  }).toList(),
                ),
                if (state.hasError)
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.errorText,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
