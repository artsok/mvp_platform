import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/screens/doctor/doctor_visit_details_screen.dart';
import 'package:mvp_platform/widgets/doctor_visit_item/doctor_visit_item_details.dart';
import 'package:mvp_platform/widgets/doctor_visit_item/doctor_visit_item_header.dart';
import 'package:provider/provider.dart';

class DoctorVisitItem extends StatelessWidget {
  final Client client;
  final VisitExt visit;

  DoctorVisitItem(this.client, this.visit)
      : assert(client != null),
        assert(visit != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DoctorVisitDetailsScreen.routeName,
        arguments: DoctorVisitDetailsScreenArguments(client, visit),
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: client),
          ChangeNotifierProvider.value(value: visit),
        ],
        child: Column(
          children: <Widget>[
            DoctorVisitItemHeader(),
            DoctorVisitItemDetails(),
          ],
        ),
      ),
    );
  }
}
