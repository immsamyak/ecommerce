import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  final int currentIndex;
  final Function(int) onPageChanged;

  const ImageCarousel({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void didUpdateWidget(ImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _pageController.animateToPage(
        widget.currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Safety check for empty images list
    if (widget.images.isEmpty) {
      return Container(
        height: 300,
        color: Colors.grey[200],
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: 80,
            color: Colors.grey[400],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Main Image Carousel
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: widget.onPageChanged,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    print("Error loading carousel image: $error");
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey[400],
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        
        // Image Thumbnails (only show if there are multiple images)
        if (widget.images.length > 1)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => widget.onPageChanged(index),
                  child: Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.currentIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print("Error loading thumbnail: $error");
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
