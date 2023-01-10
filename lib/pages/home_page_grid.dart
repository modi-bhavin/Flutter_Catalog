import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/models/catalog.dart';

import '../widgets/drawer.dart';
import '../widgets/item_widget.dart';

class HomePageGrid extends StatefulWidget {
  const HomePageGrid({super.key});

  @override
  State<HomePageGrid> createState() => _HomePageGridState();
}

class _HomePageGridState extends State<HomePageGrid> {
  final int days = 30;

  final String name = "Bhavin";

  get itemBuilder => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];

    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text(
          "Catalog App",
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (CatalogModel.items != null && CatalogModel.items!.isNotEmpty)
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16),
                  itemBuilder: ((context, index) {
                    final item = CatalogModel.items![index];
                    return Card(
                        elevation: 0.5,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: GridTile(
                          header: Container(
                            padding: const EdgeInsets.all(12),
                            decoration:
                                const BoxDecoration(color: Colors.deepPurple),
                            child: Text(
                              item.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          footer: Container(
                            padding: const EdgeInsets.all(12),
                            decoration:
                                const BoxDecoration(color: Colors.black),
                            child: Text(
                              "\$${item.price.toString()}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          child: Image.network(
                            item.image,
                          ),
                        ));
                  }),
                  itemCount: CatalogModel.items?.length,
                )
              // ignore: prefer_const_constructors
              : Center(
                  child: const CircularProgressIndicator(),
                )),
      drawer: MyDrawer(),
    );
  }
}
