import 'dart:developer';

import 'package:belajar_api/detail_product_page.dart';
import 'package:belajar_api/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListProdukPage extends StatelessWidget {
  const ListProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = snapshot.data![index];

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              backgroundImage: NetworkImage(
                                product.thumbnail!,
                              ),
                            ),
                            title: Text(product.title!),
                            subtitle: Text(product.description!),
                            trailing: Text("\$${product.price!.toString()}"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailProductPage(
                                          product: product,
                                        )),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<List<Product>> getProducts() async {
  try {
    var response = await Dio().get(
      "https://dummyjson.com/products",
    );
    final List<dynamic> responseData = response.data["products"];
    List<Product> products =
        responseData.map((json) => Product.fromJson(json)).toList();
    log(response.toString());
    return products;
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}
