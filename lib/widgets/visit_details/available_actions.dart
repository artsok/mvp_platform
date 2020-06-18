import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvp_platform/models/enums/rate.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';
import 'package:mvp_platform/providers/request/rating_provider.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:mvp_platform/widgets/common/popup_menu.dart';
import 'package:mvp_platform/widgets/common/rate_popup_menu_button.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

class AvailableActions extends StatelessWidget {
  AvailableActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: const Text(
              'Доступные действия',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Consumer2<VisitExtProvider, RatingProvider>(
              builder: (ctx, visitExtProvider, rating, __) {
            final visit = visitExtProvider.visitExt;
            if (visit.status.toVisitStatus() == VisitStatus.serviceCompleted) {
              if (visit.rating != null) {
//                return Container();
              }
//              if (rating.requestStatus == RequestStatus.error) {
//                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//                  Scaffold.of(ctx).showSnackBar(SnackBar(
//                      content: Text(
//                    'Ошибка: ${rating.errorMessage}',
//                  )));
//                  errorFlushbar(rating.errorMessage);
//                  rating.requestStatus = RequestStatus.ready;
//                });
//              rating.requestStatus = RequestStatus.ready;
//              }
              if (rating.requestStatus == RequestStatus.ready ||
                  rating.requestStatus == RequestStatus.error) {
                return _buildRateButton(visitExtProvider, rating);
              }
              if (rating.requestStatus == RequestStatus.success) {
//                return Container();
                return _buildRateButton(visitExtProvider, rating);
              }
              return const GosCupertinoLoadingIndicator();
            } else {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Отменить запись',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Перенести запись',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ],
    );
  }

  Widget _buildRateButton(
      VisitExtProvider visitExtProvider, RatingProvider rating) {
    final visit = visitExtProvider.visitExt;
    return PopupMenuButton(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Оцените услугу',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.blue[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      itemBuilder: (_) => [
        RatePopupMenu(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: <Widget>[
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate1.value,
                        comment: visit.ratingComment);
                    visitExtProvider.fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate1,
                ),
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate2.value,
                        comment: visit.ratingComment);
                    visitExtProvider.fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate2,
                ),
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate3.value,
                        comment: visit.ratingComment);
                    visitExtProvider.fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate3,
                ),
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate4.value,
                        comment: visit.ratingComment);
                    visitExtProvider.fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate4,
                ),
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate5.value,
                        comment: visit.ratingComment);
                    visitExtProvider.fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void errorFlushbar(BuildContext context, String errorMessage) {
    Flushbar(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.red.shade800, Colors.redAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Попробуйте еще раз',
      message: 'Возникла ошибка [$errorMessage]',
    )..show(context);
  }
}
