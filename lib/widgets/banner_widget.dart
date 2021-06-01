import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/banner_model.dart';

class BannerWidget extends StatefulWidget {
  BannerWidget({@required this.banners});

  final List<BannerModel> banners;

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int activeBanner = 0;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final double height = MediaQuery.of(context).size.width * 0.5;
        return Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeBanner = index;
                    });
                  }),
              items: widget.banners
                  .map((banner) => Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          banner.image,
                          fit: BoxFit.cover,
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
                          widget.banners.length,
                          (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: activeBanner == index
                                    ? Colors.white
                                    : Colors.black12,
                              )))),
                ))
          ],
        );
      },
    );
  }
}
