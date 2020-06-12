import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/screens/hospital/hospital_form_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/wizards/hospital_wizard.dart';

class HospitalInfoScreen extends StatefulWidget {
  static const routeName = '/hospital-info-screen';

  @override
  _HospitalInfoScreenState createState() => _HospitalInfoScreenState();
}

class _HospitalInfoScreenState extends State<HospitalInfoScreen> {
  bool attachedToHospital = true;
  InsuranceType insuranceType = InsuranceType.digital;

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
          'Подача заявления о выборе страховой и медицнской организации для ребёнка',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WizardHeader(
              'assets/icons/notificationIcon.png',
              'Выбор страховой и медицнской организации для ребёнка',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Сроки оказания услуги:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text("В соответствии с регламентом оказания услуги."),
                ),
              ],
            ),
            UnfoldedStepper(
              firstStep: 4,
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
                      'Выберите предпочтительное для вас медицинское учреждение',
                    ),
                  ),
                  content: Text(HospitalWizard.points[1]),
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
                  onPressed: () => Navigator.pushNamed(
                      context, HospitalFormScreen.routeName),
                  text: 'Прикрепить >',
                  width: 320,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Это займет у вас не более 3 минут"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}