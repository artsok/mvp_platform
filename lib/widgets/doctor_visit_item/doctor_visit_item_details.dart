import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/doctor.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';
import 'package:mvp_platform/models/enums/rate.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/widgets/common/popup_menu.dart';
import 'package:mvp_platform/widgets/common/rate_popup_menu_button.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

class DoctorVisitItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final visit = Provider.of<VisitExt>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: visit.status.toVisitStatus().colors().item2,
        child: visit.doctor == null
            ? Container(
                height: 50.0,
                width: double.infinity,
                child:
                    Text(visit.service?.name == null ? '' : visit.service.name))
            : Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (visit.doctor.lastName != null)
                                  Text(
                                    visit.doctor.lastName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                Text(
                                  '${visit.doctor.firstName == null ? '' : '${visit.doctor.firstName} '}${visit.doctor.midName == null ? '' : visit.doctor.midName}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(visit.doctor.specialty ?? ''),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        width: 80.0,
                        height: 80.0,
                        child: ClipRRect(
                          child: Image.asset(visit.doctor.photoPath),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Expanded(
                        child: Text(
                          visit.service.name ?? '',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      if (visit.status.toVisitStatus() ==
                          VisitStatus.serviceCompleted)
                        GestureDetector(
                          onTap: () {
                            visit.status = VisitStatus.serviceRegistered
                                .toString()
                                .split('.')[1];
                          },
                          child: visit.rating != null
                              ? Container()
                              : PopupMenuButton(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Оцените услугу',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (_) => [
                                    RatePopupMenu(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Row(
                                          children: <Widget>[
                                            RatePopupMenuButton(
                                              callback: () => visit.rating =
                                                  Rate.rate1.value,
                                              rate: Rate.rate1,
                                            ),
                                            RatePopupMenuButton(
                                              callback: () => visit.rating =
                                                  Rate.rate2.value,
                                              rate: Rate.rate2,
                                            ),
                                            RatePopupMenuButton(
                                              callback: () => visit.rating =
                                                  Rate.rate3.value,
                                              rate: Rate.rate3,
                                            ),
                                            RatePopupMenuButton(
                                              callback: () => visit.rating =
                                                  Rate.rate4.value,
                                              rate: Rate.rate4,
                                            ),
                                            RatePopupMenuButton(
                                              callback: () => visit.rating =
                                                  Rate.rate5.value,
                                              rate: Rate.rate5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
