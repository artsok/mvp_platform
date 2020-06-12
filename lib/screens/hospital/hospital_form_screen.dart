import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/hospital_provider.dart';
import 'package:mvp_platform/screens/hospital/hospital_success_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

class HospitalFormScreen extends StatefulWidget {
  static const routeName = '/hospital-form-screen';

  @override
  _HospitalFormScreenState createState() => _HospitalFormScreenState();
}

class _HospitalFormScreenState extends State<HospitalFormScreen> {
  Hospital selectedHospital = Hospitals.hospitals[0];
  InsuranceType insuranceType = InsuranceType.digital;

  int currentStep = 0;
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: Container(
          width: 290,
          child: const Text(
            'Выбор страховой и медицнской организации для ребёнка',
          ),
        ),
        content: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: DropdownButton(
                hint: Container(
                  width: 250,
                  child: const Text('Мед.учреждение'),
                ),
                onChanged: (hospitalName) {
                  setState(() {
                    selectedHospital = Hospitals.hospitals
                        .firstWhere((c) => c.name == hospitalName);
                  });
                },
                value: selectedHospital.name,
                items: Hospitals.hospitals
                    .map(
                      (hospital) => DropdownMenuItem(
                        child:
                            Container(width: 240, child: Text(hospital.name)),
                        value: hospital.name,
                      ),
                    )
                    .toList(),
              ),
            ),
            Text(selectedHospital.messageInfo ?? "", style: TextStyle(fontSize: 10),),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    maxHeight: 400,
                  ),
                  child: Image.asset(
                    selectedHospital.imagePath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ],
        ),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    void goTo(int step) {
      setState(() => currentStep = step);
    }

    void nextStep() {
      currentStep + 1 != steps.length
          ? goTo(currentStep + 1)
          : setState(() => complete = true);
    }

    void cancelStep() {
      if (currentStep > 0) {
        goTo(currentStep - 1);
      }
    }

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
            Stepper(
              physics: ClampingScrollPhysics(),
              controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
                  Container(),
              steps: steps,
              currentStep: currentStep,
              onStepContinue: nextStep,
              onStepCancel: cancelStep,
              onStepTapped: (step) => goTo(step),
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
                          'Вы желаете обслуживаться в ${selectedHospital.name}',
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text('Отменить'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            child: const Text('Да, подтверждаю'),
                            onPressed: () => Navigator.of(context).pushNamed(
                              HospitalSuccessScreen.routeName,
                              arguments: HospitalSuccessScreenArguments(
                                selectedHospital,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    Navigator.of(context).pushNamed(
                        HospitalSuccessScreen.routeName,
                        arguments:
                            HospitalSuccessScreenArguments(selectedHospital)
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