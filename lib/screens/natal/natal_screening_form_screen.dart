import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/screens/natal/natal_screening_success_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/extensions/string_extensions.dart';


class NatalScreeningFormScreen extends StatefulWidget {
  static const routeName = '/med-form-screen';

  @override
  _NatalScreeningFormScreenState createState() => _NatalScreeningFormScreenState();
}

class _NatalScreeningFormScreenState extends State<NatalScreeningFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<_NatalScreeningFormScreenState>();

  bool _validatingInput = false;

  void _startInputValidation() => setState(() => _validatingInput = true);

  void _finishInputValidation() => setState(() => _validatingInput = false);

  int currentStep = 0;
  bool complete = false;
  InsuranceType insuranceType = InsuranceType.digital;

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [ ];

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
          'Подача заявления о прикреплении к медицинскому учреждению',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WizardHeader(
              'assets/icons/notificationIcon.png',
              'Подача заявления о прикреплении к медицинскому учреждению',
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
          ],
        ),
      ),
    );
  }
}
