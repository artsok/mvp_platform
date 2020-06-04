import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/extensions/string_extensions.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/screens/hospital/hospital_form_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/wizards/med_wizard.dart';

class HospitalInfoScreen extends StatefulWidget {
  static const routeName = '/med-info-screen';

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Подача заявления о прикреплении к медицинскому учреждению',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WizardHeader(
              'assets/icons/notificationIcon.png',
              'Выбор медицинского учреждения',
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
                      'Выберите предпочтительное для вас медицинское учреждение',
                    ),
                  ),
                  content: Text(MedWizard.points[1]),
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
                  text: 'Заполнить заявление',
                  width: 300,
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