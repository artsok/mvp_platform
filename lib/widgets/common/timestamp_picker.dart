import 'package:flutter/material.dart';
import 'package:mvp_platform/typedefs/callbacks.dart';
import 'package:mvp_platform/utils/datetime_utils.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';

class TimestampPicker extends StatefulWidget {
  final List<DateTime> _timestamps;
  final DateTimeConsumerCallback _callback;

  int activeTimeIndex = -1;

  TimestampPicker({
    @required DateTime from,
    @required DateTime to,
    @required Duration interval,
    DateTimeConsumerCallback callback,
    Key key,
  })  : assert(from != null && to != null && interval != null),
        assert(from.millisecondsSinceEpoch < to.millisecondsSinceEpoch),
        assert(interval.inMilliseconds <
            to.millisecondsSinceEpoch - from.millisecondsSinceEpoch),
        _timestamps = DateTimeUtils.range(from, to, interval),
        _callback = callback,
        super(key: key);

  @override
  _TimestampPickerState createState() => _TimestampPickerState();
}

class _TimestampPickerState extends State<TimestampPicker> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('16 июня 2020, вторник'),
        Container(
          width: 300,
          height: 400,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: widget._timestamps.length,
            itemBuilder: (ctx, i) {
              DateTime current = widget._timestamps[i];
              return GosFlatButton(
                text:
                    '${current.hour}:${current.minute == 0 ? "00" : current.minute}',
                backgroundColor: widget.activeTimeIndex == i ? null : Colors.white,
                onPressed: () {
                  setState(() {
                    widget.activeTimeIndex = i;
                    widget._callback(current);
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
