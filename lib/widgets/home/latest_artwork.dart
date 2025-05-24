import 'package:flutter/material.dart';
import 'package:artlens/models/artwork.dart';
import 'package:artlens/widgets/artwork_list/artwork_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestArtworkCards extends StatefulWidget {
  final List<Artwork> artworks;

  const LatestArtworkCards({super.key, required this.artworks});

  @override
  State<LatestArtworkCards> createState() => _LatestArtworkCardsState();
}

class _LatestArtworkCardsState extends State<LatestArtworkCards> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    if (widget.artworks.isEmpty) {
      return const SizedBox();
    }
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 260.r,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.artworks.length,
              itemBuilder: (context, index) {
                return ArtworkItem(
                  widget.artworks[index],
                  margin: EdgeInsets.symmetric(
                    vertical: 10.r,
                    horizontal: 15.r,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          SmoothPageIndicator(
            controller: _controller,
            count: widget.artworks.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
