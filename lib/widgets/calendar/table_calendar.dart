library table_calendar;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';
import 'package:mvp_platform/providers/request/visits_info_provider.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/calendar/widgets/pin.dart';
import 'package:provider/provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

part 'calendar.dart';
part 'calendar_controller.dart';
part 'customization/calendar_builders.dart';
part 'customization/calendar_style.dart';
part 'customization/days_of_week_style.dart';
part 'customization/header_style.dart';
part 'widgets/cell_widget.dart';
part 'widgets/custom_icon_button.dart';
