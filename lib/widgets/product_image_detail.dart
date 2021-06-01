import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';
import 'package:flutter_chabhuoy/repository/product_repository.dart';
import 'package:provider/provider.dart';

class ProductImageDetail extends StatefulWidget {
  ProductImageDetail({@required this.images, @required this.controller});

  final List<ProductImage> images;
  final CarouselController controller;

  @override
  _ProductImageDetailState createState() => _ProductImageDetailState();
}

class _ProductImageDetailState extends State<ProductImageDetail> {
  final CarouselController _controller = CarouselController();

  int activeBanner = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.width * 0.9;

    return Stack(
      children: [
        CarouselSlider(
          carouselController: widget.controller,
          options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  activeBanner = index;
                });
              }),
          items: widget.images
              .map((image) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      image.imageName,
                      fit: BoxFit.fitWidth,
                    ),
                  ))
              .toList(),
        ),
        Positioned(
            bottom: 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      widget.images.length,
                      (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: activeBanner == index
                                ? Colors.orange
                                : Colors.orange.shade100,
                          )))),
            ))
      ],
    );
  }
}
