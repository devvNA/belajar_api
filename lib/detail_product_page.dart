// ignore_for_file: must_be_immutable
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'product_model.dart';

class DetailProductPage extends StatefulWidget {
  Product product;

  DetailProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(builder: (context) {
              return Column(
                children: [
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: 230.0,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        currentIndex = index;
                        setState(() {});
                      },
                    ),
                    items: widget.product.images!.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[250],
                              image: DecorationImage(
                                image: NetworkImage(
                                  imageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        widget.product.images!.asMap().entries.map((entry) {
                      bool isSelected = currentIndex == entry.key;
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: isSelected ? 8 : 8,
                          height: 8.0,
                          margin: const EdgeInsets.only(
                            right: 6.0,
                            top: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.indigo : Colors.grey,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\$${widget.product.price!.toString()}"),
                  Text(widget.product.title!),
                  Text(widget.product.description!),
                  Text(widget.product.stock!.toString()),
                  Text(widget.product.brand!),
                  Text(widget.product.category!),
                  Text(widget.product.rating!.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
