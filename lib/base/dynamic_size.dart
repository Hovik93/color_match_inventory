import 'dart:ui';

double devicePixelRatio = window.devicePixelRatio;
double width = window.physicalSize.width / devicePixelRatio;
double height = window.physicalSize.height / devicePixelRatio;
double deviceTopPadding = window.padding.top / devicePixelRatio;
double deviceBottomPadding = window.padding.bottom / devicePixelRatio;

class DynamicSize {
  static const double smallScreenWidth = 340.0;
  static const double initialWidth = 410.0;
  static const double initialHeight = 700.0;
  static const double initialAspectRatio = 0.46;

  static double size({
    required double screenWidth,
    required double size,
  }) {
    double _size = size;

    _size = screenWidth / initialWidth * size;
    if (window.physicalSize.aspectRatio >= 0.65) {
      _size *= window.physicalSize.aspectRatio;
    }

    // if (AppModel().ui.deviceIsIpad &&
    //     MediaQuery.of(GlobalContext.context).orientation ==
    //         Orientation.landscape) _size = size;
    return _size;
  }

  static double font({
    required double screenWidth,
    required double size,
    required double aspectRatio,
  }) {
    // if (AppModel().ui.deviceIsIpad) return size + 3;
    if (aspectRatio >= 0.65) return size;
    return screenWidth / initialWidth * size;
  }

  static double inputPadding({required double screenWidth}) {
    const double inputContentPaddingVerticalMin = 7.0;
    const double inputContentPaddingVerticalMax = 14.0;

    double contentPadding = inputContentPaddingVerticalMin;
    if (screenWidth >= 330) {
      contentPadding = inputContentPaddingVerticalMax;
    }
    return contentPadding;
  }

  static double margin({
    required double screenWidth,
    required double margin,
  }) {
    const double marginMin = 5.0;
    const double marginMax = 17.0;
    double marginLinkedInScreenWidth = screenWidth / initialWidth * margin;
    if (marginLinkedInScreenWidth < marginMax) {
      marginLinkedInScreenWidth = marginMax;
    }
    if (marginLinkedInScreenWidth < marginMin) {
      marginLinkedInScreenWidth = marginMin;
    }
    return marginLinkedInScreenWidth;
  }

  static double accountImageSize({
    required double size,
    required double screenWidth,
  }) {
    const double heightMin = 50.0;
    const double heightMax = 100.0;
    double _height = screenWidth / initialWidth * size;
    if (_height > heightMax) {
      _height = heightMax;
    }
    if (_height < heightMin) {
      _height = heightMin;
    }
    return _height;
  }
}
