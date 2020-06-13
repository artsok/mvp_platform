import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/providers/request/actions/select_medical_organization_action_provider.dart';
import 'package:mvp_platform/providers/request/birth_smo_insured_infant_provider.dart';
import 'package:mvp_platform/providers/request/medical_organizations_provider.dart';
import 'package:mvp_platform/repository/response/dto/medical_organization.dart';
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
              switch (medicalOrganizations.requestStatus) {
                case (RequestStatus.success):
                  if (selectedOrganization == null) {
                    selectedOrganization = medicalOrganizations.data[0];
                  }
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
                            selectOrganization(medicalOrganizations.data
                                .firstWhere((c) => c.name == organizationName));
                          },
                          underline: Container(),
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          value: selectedOrganization.name ?? '',
                          items: medicalOrganizations.data
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
                case RequestStatus.error:
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
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => SelectMedOrganizationActionProvider()),
                    ChangeNotifierProvider.value(value: BirthSmoProvider()),
                  ],
                  child: Consumer2<SelectMedOrganizationActionProvider,
                      BirthSmoProvider>(
                    builder: (_, medOrganizationSelect, birthInfo, __) {
                      return GosFlatButton(
                        width: 320,
                        textColor: Colors.white,
                        backgroundColor: '#2763AA'.colorFromHex(),
                        onPressed: medOrganizationSelect.processStatus ==
                                RequestStatus.processing
                            ? () {}
                            : () {
                                medOrganizationSelect
                                    .selectMedicalOrganization(
                                        birthInfo.client
                                            .getPolicy()
                                            .getNumber(),
                                        selectedOrganization.id)
                                    .then(
                                      (_) => Navigator.of(context).pushNamed(
                                        MedicalOrganizationSuccessScreen
                                            .routeName,
                                        arguments:
                                            MedicalOrganizationSuccessScreenArguments(
                                          birthInfo.client,
                                          selectedOrganization,
                                        ),
                                      ),
                                    );
                              },
                        text: 'Выбрать >',
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
