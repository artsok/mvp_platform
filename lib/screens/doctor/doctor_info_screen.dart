import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/models/enums/service_type.dart';
import 'package:mvp_platform/screens/doctor/doctor_form_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/wizards/doctor_wizard.dart';

class DoctorInfoScreen extends StatefulWidget {
  static const routeName = '/doctor-info-screen';

  @override
  _DoctorInfoScreenState createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  bool attachedToHospital = true;
  ServiceType serviceType = ServiceType.digital;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context)
              .popUntil(ModalRoute.withName(HomeScreen.routeName)),
        ),
        title: const Text(
          'Запись на профилактический осмотр',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WizardHeader(
              'assets/icons/notificationIcon.png',
              'Запись на профилактический осмотр',
            ),
            UnfoldedStepper(
              physics: ClampingScrollPhysics(),
              controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
                  Container(),
              steps: [
                UnfoldedStep(
                  title: Container(
                    width: 290,
                    child: const Text(
                      'Прикрепитесь к медицинской организации или попросите прикрепиться того, кого хотите записать на прием к врачу',
                    ),
                  ),
                  content: GestureDetector(
                    onTap: () => setState(
                        () => attachedToHospital = !attachedToHospital),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Checkbox(
                            value: attachedToHospital,
                            onChanged: (value) {
                              setState(() {
                                attachedToHospital = value;
                              });
                            },
                          ),
                          Text("Прикрепление уже есть")
                        ],
                      ),
                    ),
                  ),
                  isActive: true,
                ),
                UnfoldedStep(
                  title: Container(
                    width: 290,
                    child: const Text(
                      'Выберите тип получения услуги',
                    ),
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Radio(
                            value: ServiceType.digital,
                            groupValue: serviceType,
                            onChanged: (type) =>
                                setState(() => serviceType = type),
                          ),
                          const Text('Электронная запись'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: ServiceType.personal,
                            groupValue: serviceType,
                            onChanged: (type) =>
                                setState(() => serviceType = type),
                          ),
                          Container(
                            width: 240,
                            child: const Text('Личное посещение регистратуры'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  isActive: true,
                ),
                UnfoldedStep(
                  title: Container(
                    width: 290,
                    child: const Text(
                      'Запишитесь к специалисту в электронном виде',
                    ),
                  ),
                  content: Text(DoctorWizard.steps[3]),
                  isActive: true,
                ),
                UnfoldedStep(
                  title: Container(
                    width: 290,
                    child: const Text(
                      'Получите медицинскую услугу',
                    ),
                  ),
                  content: Text(DoctorWizard.steps[4]),
                  isActive: true,
                ),
                UnfoldedStep(
                  title: Container(
                    width: 290,
                    child: const Text(
                      'Экстренная помощь',
                    ),
                  ),
                  content: Text(
                    DoctorWizard.steps[5],
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  isActive: true,
                ),
                UnfoldedStep(
                  title: const Text('Будьте здоровы!'),
                  state: UnfoldedStepState.complete,
                  isActive: true,
                ),
              ],
            ),
            Column(
              children: [
                GosFlatButton(
                  textColor: Colors.white,
                  backgroundColor: '#2763AA'.colorFromHex(),
                  onPressed: () =>
                      Navigator.pushNamed(context, DoctorFormScreen.routeName),
                  text: 'Записаться',
                  width: 320,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Это займет у вас не более 5 минут"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
