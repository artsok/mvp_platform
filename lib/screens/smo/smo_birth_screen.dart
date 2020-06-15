import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/providers/request/birth_smo_insured_infant_provider.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:mvp_platform/widgets/smo/act_info.dart';
import 'package:provider/provider.dart';

class SmoBirthInfoScreen extends StatefulWidget {
  static const routeName = '/smo-birth-screen';

  @override
  _SmoBirthInfoScreenState createState() => _SmoBirthInfoScreenState();
}

class _SmoBirthInfoScreenState extends State<SmoBirthInfoScreen> {
  bool attachedToHospital = true;
  InsuranceType insuranceType = InsuranceType.digital;

  @override
  Widget build(BuildContext context) {
    final BirthSmoProvider birthSmoProvider = BirthSmoProvider()..fetchData();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Регистрация в системе ОМС',
        ),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: birthSmoProvider,
          child: Consumer<BirthSmoProvider>(
            builder: (_, birthInfo, __) {
              if (birthInfo == null) {
                return const Center(
                    child: const GosCupertinoLoadingIndicator());
              } else {
                switch (birthInfo.requestStatus) {
                  case RequestStatus.success:
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  ActInfo(birthInfo.client),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                          child: GosFlatButton(
                            textColor: Colors.white,
                            backgroundColor: getGosBlueColor(),
                            onPressed: () => Navigator.pushNamed(
                                context, SmoInfoScreen.routeName),
                            text: 'Выберите страховую компанию >',
                            width: 320,
                          ),
                        ),
                      ],
                    );
                  case RequestStatus.error:
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Возникла ошибка',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  birthInfo.errorMessage,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              top: 16.0,
                            ),
                            child: GosFlatButton(
                              textColor: Colors.white,
                              backgroundColor: getGosBlueColor(),
                              onPressed: () => birthInfo.fetchData(),
                              text: 'Попробовать снова',
                              width: 320,
                            ),
                          ),
                        ),
                      ],
                    );
                  default:
                    return const Center(
                        child: const GosCupertinoLoadingIndicator());
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
