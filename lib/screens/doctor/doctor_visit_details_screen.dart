import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/providers/request/rating_provider.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:mvp_platform/widgets/visit_details/available_actions.dart';
import 'package:mvp_platform/widgets/visit_details/comment.dart';
import 'package:mvp_platform/widgets/visit_details/doctor_info.dart';
import 'package:mvp_platform/widgets/visit_details/med_organization_info.dart';
import 'package:mvp_platform/widgets/visit_details/patient_info.dart';
import 'package:mvp_platform/widgets/visit_details/visit_date_time.dart';
import 'package:mvp_platform/widgets/visit_details/visit_status_header.dart';
import 'package:provider/provider.dart';

class DoctorVisitDetailsScreen extends StatelessWidget {
  static final routeName = '/doctor-visit-details-screen';
  final RatingProvider rating = RatingProvider();
  final VisitExtProvider visitExt = VisitExtProvider();

  DoctorVisitDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DoctorVisitDetailsScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    final client = args.client;
    final visitId = args.visitId;
    visitExt.fetchData(visitId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop("I love Nutella"),
        ),
        title: const Text('Запись на прием'),
      ),
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: client),
            ChangeNotifierProvider.value(value: rating),
            ChangeNotifierProvider.value(value: visitExt),
          ],
          child: Consumer<VisitExtProvider>(builder: (_, visitExt, __) {
            if (visitExt.requestStatus == RequestStatus.success ||
                visitExt.requestStatus == RequestStatus.ready) {
              return Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      VisitStatusHeader(),
                      VisitDateTime(),
                      PatientInfo(),
                      DoctorInfo(),
                      MedOrganizationInfo(),
                      SizedBox(height: 8.0),
                      AvailableActions(),
                      Comment(),
                    ],
                  ),
                ),
              );
            }
            if (visitExt.requestStatus == RequestStatus.error) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Возникла ошибка',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            visitExt.errorMessage,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                        top: 16.0,
                      ),
                      child: GosFlatButton(
                        textColor: Colors.white,
                        backgroundColor: getGosBlueColor(),
                        onPressed: () => visitExt.fetchData(visitId),
                        text: 'Попробовать снова',
                        width: 320,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: const GosCupertinoLoadingIndicator(),
            );
          }),
        ),
      ),
    );
  }
}

class DoctorVisitDetailsScreenArguments {
  final Client client;
  final String visitId;

  DoctorVisitDetailsScreenArguments(this.client, this.visitId);
}
