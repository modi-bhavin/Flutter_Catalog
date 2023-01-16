import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/cart.dart';
import '../../models/catalog.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;
  AddToCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  final _cart = CartModel();

  @override
  Widget build(BuildContext context) {
    bool isInCart = _cart.items.contains(catalog);
    return ElevatedButton(
      onPressed: () {
        isInCart
            ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: "Item is already in cart.".text.xl.make(),
              ))
            : isInCart = isInCart.toggle();
        final _catalog = CatalogModel();
        _cart.catalog = _catalog;
        _cart.add(catalog);

        // setState(() {});
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          // ignore: deprecated_member_use
          context.theme.buttonColor,
        ),
        shape: MaterialStateProperty.all(
          const StadiumBorder(),
        ),
      ),
      child: isInCart
          ? const Icon(Icons.done)
          : Icon(CupertinoIcons.cart_badge_plus),
    );
  }
}
