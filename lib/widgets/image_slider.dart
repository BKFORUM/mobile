import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int activeIndex = 0;

  List<String> urlImages = [
    'https://www.udn.vn/Portals/0/1doan%20thanh%20nien%20bk.jpg',
    'https://dut.udn.vn/Files/k.xdtl/images/ASIIN/ASIIN_02.png',
    'https://en.dut.udn.vn/uploads/2023/09/21/d7145ada8d30421a8a4256db1c44d2ad.jpg',
    'https://www.udn.vn/app/webroot/upload/images/dhkinhte_xnnx%20(1).jpg',
    'https://media.baoquangninh.vn/upload/image/202302/medium/2053824_131e8b5942608a38103bd8c6bbd8e49c.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                initialPage: 0,
                height: 400,
                aspectRatio: 1 / 1,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                enlargeFactor: 0,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              items: urlImages.map((url) {
                return Image.network(url, fit: BoxFit.cover);
              }).toList(),
            ),
            Positioned(
              left: 0, right: 0, bottom: 8,
              child: Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: urlImages.length,
                  effect: ColorTransitionEffect(
                    spacing: 4.0,
                    dotWidth: 8.0,
                    dotHeight: 8.0,
                    dotColor: Colors.black12,
                    activeDotColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.7),
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}