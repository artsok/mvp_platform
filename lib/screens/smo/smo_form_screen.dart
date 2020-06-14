import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/providers/request/birth_smo_insured_infant_provider.dart';
import 'package:mvp_platform/providers/request/dialogs/select_smo_dialog_provider.dart';
import 'package:mvp_platform/providers/request/med_insurance_provider.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/medical_insurance_organization.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_info_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/smo/child_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SmoFormScreen extends StatefulWidget {
  static const routeName = '/smo-form-screen';

  @override
  _SmoFormScreenState createState() => _SmoFormScreenState();
}

class _SmoFormScreenState extends State<SmoFormScreen> {
  Client selectedChild;
  MedicalInsuranceOrganization selectedOrganization;
  InsuranceType insuranceType = InsuranceType.digital;

  void selectInsuranceOrganization(MedicalInsuranceOrganization organization) {
    setState(() {
      selectedOrganization = organization;
    });
  }

  void selectChild(Client child) {
    setState(() {
      selectedChild = child;
    });
  }

  Future<String> getBirthActId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('birthActId');
  }

  @override
  Widget build(BuildContext context) {
    final BirthSmoProvider birthSmo = BirthSmoProvider();
    birthSmo.client ?? birthSmo.fetchData();
    selectedChild = birthSmo.client;
    final insurancesProvider = MedInsuranceProvider();
    insurancesProvider.data ?? insurancesProvider.fetchData();
    List<UnfoldedStep> steps = [
      UnfoldedStep(
        title: Container(
          width: 290,
          child: const Text(
            'Пожалуйста, выберите ребенка, которому требуется выбрать страховую медицинскую организацию и оформить полис ОМС',
          ),
        ),
        content: Consumer<BirthSmoProvider>(
          builder: (_, birthSmo, __) {
            if (birthSmo.requestStatus != RequestStatus.success) {
              return const Center(child: const GosCupertinoLoadingIndicator());
            }
            return Wrap(
              children: <Widget>[
                DropdownButton(
                  hint: Container(
                      width: 243,
                      height: 60,
                      child: const Text(
                          'Фамилия, имя, отчество новорожденного(-ой)')),
                  onChanged: (fullname) {
//                    selectChild(selectedChild);
                  },
                  value: selectedChild.fullName,
                  items: [
                    DropdownMenuItem(
                      child: Text(selectedChild.fullName),
                      value: selectedChild.fullName,
                    )
                  ],
                ),
                ChildInfo(selectedChild),
              ],
            );
          },
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
        content: ChangeNotifierProvider.value(
          value: insurancesProvider,
          child: Consumer<MedInsuranceProvider>(
            builder: (_, organizations, __) {
              switch (organizations.requestStatus) {
                case RequestStatus.success:
                  if (selectedOrganization == null) {
                    final defaultOrganization =
                        organizations.getDefaultOrganization();
                    selectedOrganization = defaultOrganization != null
                        ? defaultOrganization
                        : organizations.data[0];
                    organizations.selectedOrganization = selectedOrganization;
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
                                      // @TODO
                                      'АО «СК СОГАЗ-МЕД»',
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
                                onChanged: (code) {
                                  selectInsuranceOrganization(organizations.data
                                      .firstWhere((c) => c.code == code));
                                  organizations.selectedOrganization =
                                      selectedOrganization;
                                },
                                value: selectedOrganization.code,
                                style: TextStyle(
                                  //fontSize: 12.0,
                                  color: Colors.black,
                                ),
                                underline: Container(),
                                items: organizations.data
                                    .map(
                                      (company) => DropdownMenuItem(
                                        child: Container(
                                          width: 240,
                                          child: Text('${company.code}\n'),
                                        ),
                                        value: company.code,
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
                case RequestStatus.error:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Возникла ошибка',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          insurancesProvider.errorMessage,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        GosFlatButton(
                          textColor: Colors.white,
                          backgroundColor: getGosBlueColor(),
                          onPressed: () => insurancesProvider.fetchData(),
                          text: 'Попробовать снова',
                        ),
                      ],
                    ),
                  );
                default:
                  return const GosCupertinoLoadingIndicator();
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
      body: ChangeNotifierProvider.value(
        value: birthSmo,
        child: SingleChildScrollView(
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
                          create: (_) => SelectSmoDialogProvider(),
                          child: Consumer<SelectSmoDialogProvider>(
                            builder: (_, medOrganizationSelect, __) {
                              return CupertinoAlertDialog(
                                title: medOrganizationSelect.processStatus ==
                                        RequestStatus.processing
                                    ? const CupertinoActivityIndicator(
                                        radius: 25.0)
                                    : medOrganizationSelect.processStatus ==
                                            RequestStatus.error
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
                                                'Вы выбрали страховую медицинскую организацию  ${selectedOrganization.code}. Нажимая на кнопку «Да, согласен» вы подтверждаете свой выбор.',
                                              ),
                                            ],
                                          ),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text('Отменить'),
                                    onPressed:
                                        medOrganizationSelect.processStatus ==
                                                    RequestStatus.ready ||
                                                medOrganizationSelect
                                                        .processStatus ==
                                                    RequestStatus.error
                                            ? () => Navigator.of(context).pop()
                                            : () {},
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text('Да, согласен'),
                                    onPressed: medOrganizationSelect
                                                    .processStatus ==
                                                RequestStatus.ready ||
                                            medOrganizationSelect
                                                    .processStatus ==
                                                RequestStatus.error
                                        ? () => {
                                              medOrganizationSelect
                                                  .applyForInsurance(
                                                      selectedOrganization.id)
                                                  .then((result) {
                                                if (medOrganizationSelect
                                                        .processStatus ==
                                                    RequestStatus.success) {
                                                  Navigator.of(context).pushNamed(
                                                      MedicalOrganizationInfoScreen
                                                          .routeName);
                                                }
                                              }),
                                            }
                                        : () {},
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
      ),
    );
  }
}
