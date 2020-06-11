import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/models/enums/insurance_type.dart';
import 'package:mvp_platform/models/insurance_company.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/providers/insurance_companies_provider.dart';
import 'package:mvp_platform/screens/hospital/hospital_info_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/unfolded_stepper.dart';
import 'package:mvp_platform/widgets/smo/child/child_info.dart';

class SmoFormScreen extends StatefulWidget {
  static const routeName = '/smo-form-screen';

  @override
  _SmoFormScreenState createState() => _SmoFormScreenState();
}

class _SmoFormScreenState extends State<SmoFormScreen> {
  Child selectedChild = Children.children[0];
  InsuranceCompany selectedInsuranceCompany =
      InsuranceCompanies.insuranceCompanies[0];
  InsuranceType insuranceType = InsuranceType.digital;

  int currentStep = 0;
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    List<UnfoldedStep> steps = [
      UnfoldedStep(
        title: Container(
          width: 290,
          child: const Text(
            'Пожалуйста, выберите ребенка, которому требуется выбрать страховую медицинскую организацию и оформить полис ОМС',
          ),
        ),
        content: Wrap(
          children: <Widget>[
            DropdownButton(
              hint: Container(
                  width: 265,
                  child:
                      const Text('Фамилия, имя, отчество новорожденного(-ой)')),
              onChanged: (fullname) {
                setState(() {
                  selectedChild = Children.children
                      .firstWhere((c) => c.fullname == fullname);
                });
              },
              value: selectedChild.fullname,
              items: Children.children
                  .map(
                    (child) => DropdownMenuItem(
                      child: Text(child.fullname),
                      value: child.fullname,
                    ),
                  )
                  .toList(),
            ),
            ChildInfo(selectedChild),
          ],
        ),
        state: UnfoldedStepState.complete,
        isActive: true,
      ),
      UnfoldedStep(
        title: Container(
          width: 290,
          child: const Text(
            'Пожалуйста, выберите страховую медицинскую организацию',
          ),
        ),
        content: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 290,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
//По ТЗ убрал, но не удаляю
//                  child: Container(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        const Text(
//                          'Регион прикрепления: ',
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        Text(selectedInsuranceCompany.address),
//                      ],
//                    ),
//                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Страховая компания: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Builder(
                      builder: (context) =>  DropdownButton(
                        hint: const Text('Страховая компания'),
                        //hint почему-то не отрабатывает
                        onChanged: (name) {
                          setState(() {
                            selectedInsuranceCompany = InsuranceCompanies
                                .insuranceCompanies
                                .firstWhere((c) => c.name == name);

                            //Т.к у мамы ребенка согаз, даем подсказу.
                            if (selectedInsuranceCompany.name
                                .toLowerCase()
                                .contains("согаз")) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Вы также обслуживаетесь в компании ${selectedInsuranceCompany.name}"),
                              ));
                            }
                          });
                        },
                        value: selectedInsuranceCompany.name,
                        items: InsuranceCompanies.insuranceCompanies
                            .map(
                              (company) => DropdownMenuItem(
                                child: Container(
                                    width: 240, child: Text(company.name)),
                                value: company.name,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        state: UnfoldedStepState.complete,
        isActive: true,
      ),
      UnfoldedStep(
        title: Container(
          width: 280,
          child: const Text(
            'Пожалуйста, выберите желаемую форму полиса ОМС',
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
                  onChanged: (type) => setState(() => insuranceType = type),
                ),
                const Text('Электронный'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: InsuranceType.material,
                  groupValue: insuranceType,
                  onChanged: (type) => setState(() => insuranceType = type),
                ),
                Container(width: 240, child: const Text('Пластиковый')),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: InsuranceType.paper,
                  groupValue: insuranceType,
                  onChanged: (type) => setState(() => insuranceType = type),
                ),
                Container(width: 240, child: const Text('Бумажный')),
              ],
            ),
          ],
        ),
        isActive: true,
        state: UnfoldedStepState.complete,
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
            'Подача заявления о выборе Страхового медицинского осмотра'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UnfoldedStepper(
              firstStep: 2,
              physics: ClampingScrollPhysics(),
              controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
                  Container(),
              steps: steps,
//              onStepContinue: nextStep,
//              onStepCancel: cancelStep,
//              onStepTapped: (step) => goTo(step),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 56),
                child: GosFlatButton(
                  width: 320,
                  textColor: Colors.white,
                  backgroundColor: '#2763AA'.colorFromHex(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Column(
                          children: [
                            Text(
                              'Вы выбрали страховую медицинскую организацию  ${selectedInsuranceCompany.name} Нажимая на кнопку «Да, согласен» Вы подтверждаете согласие с условиями договора ${selectedInsuranceCompany.name}.',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                "Ознакомиться с договором",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text('Отменить'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                              child: const Text('Да, согласен'),
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(HospitalInfoScreen.routeName)
//                            onPressed: () => Navigator.of(context).pushNamed(
//                              SmoSuccessScreen.routeName,
//                              arguments: SmoSuccessScreenArguments(
//                                selectedChild,
//                                selectedInsuranceCompany,
//                              ),
//                            ),

                              ),
                        ],
                      ),
                    );
                  },
                  text: 'Оформить',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


