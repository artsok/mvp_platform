import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_form_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/wizards/med_organization_wizard.dart';

class MedicalOrganizationInfoScreen extends StatefulWidget {
  static const routeName = '/medical-organization-info-screen';

  @override
  _MedicalOrganizationInfoScreenState createState() => _MedicalOrganizationInfoScreenState();
}

class _MedicalOrganizationInfoScreenState extends State<MedicalOrganizationInfoScreen> {
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
          'Подача заявления о прикреплении к медицинскому учреждению',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WizardHeader(
              'assets/icons/notificationIcon.png',
              'Прикрепление ребёнка к медицинской организации',
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
                  content: Text(MedOrganizationWizard.steps[1]),
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
                      context, MedicalOrganizationFormScreen.routeName),
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