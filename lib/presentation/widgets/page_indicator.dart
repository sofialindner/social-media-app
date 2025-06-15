import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/themes/colors.dart';

class PageIndicator extends StatefulWidget {
  final List<Image> images;

  const PageIndicator({super.key, required this.images});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  final PageController pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return widget.images[index];
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () => pageController.jumpToPage(index),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: AnimatedDot(isActive: _currentPage == index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedDot extends StatelessWidget {
  final bool isActive;

  const AnimatedDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 12 : 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
