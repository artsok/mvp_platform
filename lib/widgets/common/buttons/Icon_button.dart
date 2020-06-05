import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

class IconSvg extends StatelessWidget {
  final String path;
  final double height;
  final double width;

  IconSvg(this.path, {this.height = 45, this.width = 45});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path,
        height: height,
        width: width,
        color: getGosBlueColor(),
        semanticsLabel: 'backspace');
  }
}
