import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ImageSlider extends StatefulWidget {
  final List<String>? urlImages;

  ImageSlider(this.urlImages);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {

    if (widget.urlImages == null || widget.urlImages!.isEmpty) {
      return Container();
    }
    return Container(
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              height: 400,
              aspectRatio: 1 / 1,
              viewportFraction: 1,
              enableInfiniteScroll: widget.urlImages!.length > 1,
              enlargeCenterPage: true,
              enlargeFactor: 0,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
            items: widget.urlImages!.map((url) {
              return Image.network(url, fit: BoxFit.cover);
            }).toList(),
          ),
          if(widget.urlImages!.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: widget.urlImages!.length,
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