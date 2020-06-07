import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:flutter/rendering.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/screens/smo/smo_form_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/wizards/smo_wizard.dart';

class SmoInfoScreen extends StatefulWidget {
  static const routeName = '/smo-info-screen';

  @override
  _SmoInfoScreenState createState() => _SmoInfoScreenState();
}

class _SmoInfoScreenState extends State<SmoInfoScreen> {
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
          'Подача заявления о выборе Страхового медицинского осмотра',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WizardHeader(
              'assets/icons/notificationIcon.png',
              'Получение полиса ОМС для ребенка',
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
              physics: ClampingScrollPhysics(),
              controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
                  Container(),
              steps: [
//                UnfoldedStep(
//                  title: Container(
//                    width: 290,
//                    child: const Text('Прикрепитесь к медицинской организации'),
//                  ),
//                  content: GestureDetector(
//                    onTap: () => setState(
//                        () => attachedToHospital = !attachedToHospital),
//                    child: Container(
//                      alignment: Alignment.centerLeft,
//                      child: Row(
//                        children: [
//                          Checkbox(
//                            value: attachedToHospital,
//                            onChanged: (value) {
//                              setState(() {
//                                attachedToHospital = value;
//                              });
//                            },
//                          ),
//                          Text("Прикрепление уже есть")
//                        ],
//                      ),
//                    ),
//                  ),
//                  isActive: true,
//                ),
                UnfoldedStep(
                  title: Container(
                    width: 290,
                    child: const Text(
                      'Выберите страховую медицинскую организацию для вашего ребенка',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  content: Text(SmoWizard.points[3]),
                  isActive: true,
                ),
                UnfoldedStep(
                  title: Container(
                    width: 290,
                    child: const Text(
                      'Выберите форму получаемого полиса ОМС',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Radio(
                            value: InsuranceType.digital,
                            groupValue: insuranceType,
                            onChanged: (type) =>
                                setState(() => insuranceType = type),
                          ),
                          const Text('Цифровой'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: InsuranceType.material,
                            groupValue: insuranceType,
                            onChanged: (type) =>
                                setState(() => insuranceType = type),
                          ),
                          Container(
                              width: 240, child: const Text('Электронный')),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: InsuranceType.paper,
                            groupValue: insuranceType,
                            onChanged: (type) =>
                                setState(() => insuranceType = type),
                          ),
                          Container(width: 240, child: const Text('Бумажный')),
                        ],
                      )
                    ],
                  ),
                  isActive: true,
                ),
//                UnfoldedStep(
//                  title: Container(
//                    width: 290,
//                    child: const Text('Выберите пункт выдачи полиса ОМС'),
//                  ),
//                  content: Text(SmoWizard.points[4]),
//                  isActive: true,
//                ),
                UnfoldedStep(
                  title: Container(
                    width: 290,
                    child: const Text(
                        'Выберите удобное для вас медицинское учреждение'),
                  ),
                  content: Text(SmoWizard.points[5]),
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
                      Navigator.pushNamed(context, SmoFormScreen.routeName),
                  text: 'Подать заявление >',
                  width: 320,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 56.0),
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
