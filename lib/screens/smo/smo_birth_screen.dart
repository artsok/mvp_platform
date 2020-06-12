import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/providers/birth_smo/birth_smo_insured_infant_provider.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/smo/child/child_info.dart';
import 'package:provider/provider.dart';

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
    final BirthSmoProvider provider = BirthSmoProvider();
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
      body: FutureProvider(
        create: (context) => provider.fetchData(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<BirthSmoProvider>(
                  builder: (_, birthInfoData, __) {
                    if (birthInfoData == null) {
                      return CupertinoActivityIndicator(radius: 25.0);
                    } else {
                      switch (birthInfoData.data.responseStatus) {
                        case ResponseStatus.success:
                          return ActInfo(birthInfoData.data.client);
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
                          return CupertinoActivityIndicator(radius: 25.0);
                      }
                    }
                  },
                ),
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
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 56.0))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
