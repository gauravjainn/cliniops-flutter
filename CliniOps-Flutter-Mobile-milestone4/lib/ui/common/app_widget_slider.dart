import 'package:clini_app/data/data.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:flutter/material.dart';
import 'package:clini_app/utils/utils.dart';

class AppWidgetSlider extends StatefulWidget {
  final List<Widget> children;
  final bool Function(int)? onBackPress;
  final Future<bool> Function(int)? onNextPress;

  const AppWidgetSlider({
    required this.children,
    this.onBackPress,
    this.onNextPress,
  });

  @override
  _AppWidgetSliderState createState() => _AppWidgetSliderState();
}

class _AppWidgetSliderState extends State<AppWidgetSlider> {
  final _controller = PageController();
  final _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, ori) {
      var isLandS = ori == Orientation.landscape;
      return Column(
        children: [
          Expanded(
            child: PageView(
              children: widget.children,
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (val) => _selectedIndex.value = val,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (_, int val, __) {
              final isLastIndex = val == widget.children.length - 1;
              final isFirstIndex = val == 0;
              return Visibility(
                visible: !isLastIndex,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: isFirstIndex ? null : _handlePrevPage,
                      child: AnimatedOpacity(
                        opacity: isFirstIndex ? 0.5 : 1,
                        duration: animDuration,
                        child: Image(
                          image: const AssetImage(Images.arrowLeft),
                          width: isLandS?38.r : 48.r,
                          height: isLandS?38.r :48.r,
                        ),
                      ),
                    ),
                    sizedBoxWithWidth(isLandS?16 : 48),
                    InkWell(
                      onTap: isLastIndex ? null : _handleNextPage,
                      child: AnimatedOpacity(
                        opacity: isLastIndex ? 0.5 : 1,
                        duration: animDuration,
                        child: Image(
                          image: const AssetImage(Images.arrowRight),
                          width: isLandS?38.r :48.r,
                          height: isLandS?38.r :48.r,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          sizedBoxWithHeight(isLandS?12: 32),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 8.w,
            runSpacing: 8.w,
            children: [
              for (var i = 0; i < widget.children.length; i++) ...{
                ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder: (_, int val, __) => AnimatedContainer(
                    duration: animDuration,
                    width: i == val ? 15.w : 10.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: i == val
                          ? AppColors.pillColorSelected
                          : AppColors.greyGradientColor,
                    ),
                  ),
                ),
              }
            ],
          ),
          sizedBoxWithHeight(isLandS?16 :32),
        ],
      );
    });
  }

  void _handlePrevPage() {
    final isSuccess = widget.onBackPress?.call(_selectedIndex.value) ?? true;
    if (isSuccess) {
      _controller.previousPage(
        duration: animDuration,
        curve: Curves.ease,
      );
    }
  }

  void _handleNextPage() async {
    final isSuccess =
        await widget.onNextPress?.call(_selectedIndex.value) ?? true;
    if (isSuccess) {
      _controller.nextPage(
        duration: animDuration,
        curve: Curves.ease,
      );
    }
  }
}
