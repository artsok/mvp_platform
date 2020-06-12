import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/models/enums/dialog_process_status.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/providers/dialogs/select_med_organization/select_med_organization_provider.dart';
import 'package:mvp_platform/providers/smo_form/med_insurance_provider.dart';
import 'package:mvp_platform/repository/response/dto/medical_insurance_organization.dart';
import 'package:mvp_platform/repository/rest_api.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_info_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/smo/child/child_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SmoFormScreen extends StatefulWidget {
  static const routeName = '/smo-form-screen';

  @override
  _SmoFormScreenState createState() => _SmoFormScreenState();
}

class _SmoFormScreenState extends State<SmoFormScreen> {
  Child selectedChild = Children.children[0];

  MedicalInsuranceOrganization selectedOrganization;
  InsuranceType insuranceType = InsuranceType.digital;

  void selectInsuranceOrganization(MedicalInsuranceOrganization organization) {
    setState(() {
      selectedOrganization = organization;
    });
  }

  Future<String> getBirthActId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('birthActId');
  }

  @override
  Widget build(BuildContext context) {
    final insurancesProvider = MedInsuranceProvider();
    List<UnfoldedStep> steps = [
      UnfoldedStep(
        title: Container(
          width: 290,
          child: const Text(
            'Пожалуйста, выберите ребенка, которому требуется выбрать страховую медицинскую организацию и оформить полис ОМС',
          ),
        ),
        content: Wrap(
          children: <Widget>[
            DropdownButton(
              hint: Container(
                  width: 243,
                  height: 60,
                  child:
                      const Text('Фамилия, имя, отчество новорожденного(-ой)')),
              onChanged: (fullname) {
                setState(() {
                  selectedChild = Children.children
                      .firstWhere((c) => c.fullname == fullname);
                });
              },
              value: selectedChild.fullname,
              items: Children.children
                  .map(
                    (child) => DropdownMenuItem(
                      child: Text(child.fullname),
                      value: child.fullname,
                    ),
                  )
                  .toList(),
            ),
            ChildInfo(selectedChild),
          ],
        ),
        isActive: true,
      ),
      UnfoldedStep(
        title: Container(
          width: 290,
          child: const Text(
            'Пожалуйста, выберите страховую медицинскую организацию',
          ),
        ),
        content: FutureProvider(
          create: (_) => insurancesProvider.fetchData(),
          child: Consumer<MedInsuranceProvider>(
            builder: (_, organizations, __) {
              if (organizations == null) {
                return const GosCupertinoLoadingIndicator();
              } else {
                switch (organizations.responseStatus) {
                  case ResponseStatus.success:
                    if (selectedOrganization == null) {
                      final defaultOrganization =
                          organizations.getDefaultOrganization();
                      selectedOrganization = defaultOrganization != null
                          ? defaultOrganization
                          : organizations.data[0];
                    }
                    return Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Ваша страховая компания:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4,
                                        bottom: 16,
                                      ),
                                      child: const Text(
                                        'АО «СОГАЗ Мед» СОГАЗ МЕД',
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Страховая компания ребёнка: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                DropdownButton(
                                  hint: Container(
                                    width: 260,
                                    child: const Text('Страховая компания'),
                                  ),
                                  onChanged: (name) {
                                    selectInsuranceOrganization(organizations
                                        .data
                                        .firstWhere((c) => c.name == name));
                                  },
                                  value: selectedOrganization.name,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                  underline: Container(),
                                  items: organizations.data
                                      .map(
                                        (company) => DropdownMenuItem(
                                          child: Container(
                                              width: 240,
                                              child: Text('${company.name}\n')),
                                          value: company.name,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                    return const GosCupertinoLoadingIndicator();
                }
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
            'Подача заявления о выборе Страхового медицинского осмотра'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                padding: const EdgeInsets.only(bottom: 56),
                child: GosFlatButton(
                  width: 320,
                  textColor: Colors.white,
                  backgroundColor: '#2763AA'.colorFromHex(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => SelectMedOrganizationProvider(),
                        child: Consumer<SelectMedOrganizationProvider>(
                          builder: (_, medOrganizationSelect, __) {
                            return CupertinoAlertDialog(
                              title: medOrganizationSelect.processStatus ==
                                      DialogProcessStatus.started
                                  ? const CupertinoActivityIndicator(
                                      radius: 25.0)
                                  : medOrganizationSelect.processStatus ==
                                          DialogProcessStatus.error
                                      ? Container(
                                          width: double.infinity,
                                          child: const Text(
                                            'Произошла ошибка',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Text(
                                              'Вы выбрали страховую медицинскую организацию  ${selectedOrganization.name}. Нажимая на кнопку «Да, согласен» Вы подтверждаете согласие с условиями договора ${selectedOrganization.name}.',
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 16,
                                              ),
                                              child: Text(
                                                "Ознакомиться с договором",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: const Text('Отменить'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                CupertinoDialogAction(
                                    child: const Text('Да, согласен'),
                                    onPressed: () => {
                                          medOrganizationSelect
                                              .applyForInsurance(
                                                  selectedOrganization.id)
                                              .then((result) {
                                            if (medOrganizationSelect
                                                    .processStatus ==
                                                DialogProcessStatus.success) {
                                              Navigator.of(context).pushNamed(
                                                  MedicalOrganizationInfoScreen
                                                      .routeName);
                                            }
                                          }),
                                        }
//                                  onPressed: () =>
//                                      Navigator.of(context).pushNamed(
//                                    SmoSuccessScreen.routeName,
//                                    arguments: SmoSuccessScreenArguments(
//                                      selectedChild,
//                                      selectedInsuranceCompany,
//                                    ),
//                                  ),
                                    ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                  text: 'Оформить >',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
