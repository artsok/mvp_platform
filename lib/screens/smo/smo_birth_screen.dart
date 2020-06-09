import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/screens/smo/smo_form_screen.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/widgets/smo/child/child_info.dart';
import 'package:mvp_platform/wizards/smo_wizard.dart';

class SmoBirthInfoScreen extends StatefulWidget {
  static const routeName = '/smo-birth-screen';

  @override
  _SmoBirthInfoScreenState createState() => _SmoBirthInfoScreenState();
}

class _SmoBirthInfoScreenState extends State<SmoBirthInfoScreen> {
  bool attachedToHospital = true;
  InsuranceType insuranceType = InsuranceType.digital;
  Child selectedChild = Children.children[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Запись акта о рождении',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActInfo(selectedChild),
            ),
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 48.0)),
                GosFlatButton(
                  textColor: Colors.white,
                  backgroundColor: getGosBlueColor(),
                  onPressed: () =>
                      Navigator.pushNamed(context, SmoInfoScreen.routeName),
                  text: 'Выберите страховую компанию >',
                  width: 320,
                ),
                Padding(padding: const EdgeInsets.only(top: 8.0, bottom: 56.0))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
