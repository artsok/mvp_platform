import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/providers/medical_organizations/medical_organizations_provider.dart';
import 'package:mvp_platform/repository/response/dto/medical_organization.dart';
import 'package:mvp_platform/repository/rest_api.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_success_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:provider/provider.dart';

class MedicalOrganizationFormScreen extends StatefulWidget {
  static const routeName = '/hospital-form-screen';

  @override
  _MedicalOrganizationFormScreenState createState() =>
      _MedicalOrganizationFormScreenState();
}



class _MedicalOrganizationFormScreenState
    extends State<MedicalOrganizationFormScreen> {

  MedicalOrganization selectedOrganization;
  InsuranceType insuranceType = InsuranceType.digital;

  void selectOrganization(MedicalOrganization organization) {
    setState(() {
      selectedOrganization = organization;
    });
  }

  _changeMedicalOrganization() async {
    await Service().changeMedicalOrganization("6394589773000297", "390870");
  }

  @override
  Widget build(BuildContext context) {
    final MedicalOrganizationsProvider medicalOrganizations =
        MedicalOrganizationsProvider();
    List<UnfoldedStep> steps = [
      UnfoldedStep(
        title: Container(
          width: 290,
          child: const Text(
            'Выберите лечебно-профилактическое учреждение для прикрепления',
          ),
        ),
        content: FutureProvider(
          create: (_) => medicalOrganizations.fetchData(),
          child: Consumer<MedicalOrganizationsProvider>(
            builder: (_, medicalOrganizations, __) {
              if (medicalOrganizations == null) {
                return GosCupertinoLoadingIndicator();
              }
              switch (medicalOrganizations.data.responseStatus) {
                case (ResponseStatus.success):
                  selectedOrganization = medicalOrganizations.data.data[0];
                  return Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: DropdownButton(
                          hint: Container(
                            width: 260,
                            height: 40,
                            child: const Text('Мед.учреждение'),
                          ),
                          onChanged: (organizationName) {
                            selectOrganization(medicalOrganizations.data.data
                                .firstWhere((c) => c.name == organizationName));
                          },
                          style: TextStyle(fontSize: 9.0, color: Colors.black),
                          value: selectedOrganization.name ?? '',
                          items: medicalOrganizations.data.data
                              .map(
                                (hospital) => DropdownMenuItem(
                                  child: Container(
                                    width: 240,
                                    child: Text('${hospital.name}\n'),
                                  ),
                                  value: hospital.name,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 400,
                              maxHeight: 400,
                            ),
                            child: Image.asset(
                              selectedOrganization.photoPath,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                case ResponseStatus.error:
                  return Center(
                    child: const Text(
                      'Ошибка при загрузке данных',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                      ),
                    ),
                  );
                default:
                  return GosCupertinoLoadingIndicator();
              }
            },
          ),
        ),
        isActive: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Подача заявления о выборе страховой и медицнской организации для ребёнка',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WizardHeader(
              'assets/icons/notificationIcon.png',
              'Прикрепление ребёнка к медицинской организации',
            ),
            UnfoldedStepper(
              physics: ClampingScrollPhysics(),
              controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
                  Container(),
              steps: steps,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GosFlatButton(
                  width: 320,
                  textColor: Colors.white,
                  backgroundColor: '#2763AA'.colorFromHex(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text(
                          'Вы желаете обслуживаться в ${selectedOrganization.name}',
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text('Отменить'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                              child: const Text('Да, подтверждаю'),
                              onPressed: () => {


                                    Navigator.of(context).pushNamed(
                                      MedicalOrganizationSuccessScreen
                                          .routeName,
                                      arguments:
                                          MedicalOrganizationSuccessScreenArguments(
                                        selectedOrganization,
                                      ),
                                    ),
                                  }),
                        ],
                      ),
                    );
                    _changeMedicalOrganization();
                    Navigator.of(context).pushNamed(
                      MedicalOrganizationSuccessScreen.routeName,
                      arguments: MedicalOrganizationSuccessScreenArguments(
                          selectedOrganization),
//                    showDialog(
//                      context: context,
//                      builder: (context) => CupertinoAlertDialog(
//                        title: Text(
//                          'Вы желаете обслуживаться в ${selectedHospital.name}',
//                        ),
//                        actions: <Widget>[
//                          CupertinoDialogAction(
//                            child: const Text('Отменить'),
//                            onPressed: () => Navigator.of(context).pop(),
//                          ),
//                          CupertinoDialogAction(
//                            child: const Text('Да, подтверждаю'),
//                            onPressed: () => Navigator.of(context).pushNamed(
//                              SuccessfulHospitalScreen.routeName,
//                              arguments: SuccessfulHospitalScreenArguments(
//                                selectedHospital,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
                    );
                  },
                  text: 'Выбрать >',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
