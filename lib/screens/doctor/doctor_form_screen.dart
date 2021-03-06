import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/doctor.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/providers/doctor_provider.dart';
import 'package:mvp_platform/providers/request/birth_smo_insured_infant_provider.dart';
import 'package:mvp_platform/providers/request/medical_organizations_provider.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/screens/doctor/doctor_success_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:mvp_platform/widgets/common/timestamp_picker.dart';
import 'package:mvp_platform/widgets/common/wizard_header.dart';
import 'package:mvp_platform/widgets/smo/child_info.dart';
import 'package:provider/provider.dart';

class DoctorFormScreen extends StatefulWidget {
  static final routeName = '/doctor-form-screen';

  @override
  _DoctorFormScreenState createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends State<DoctorFormScreen> {
  Client selectedChild;
  Doctor selectedDoctor = Doctors.doctors[0];
  Hospital selectedHospital = MedicalOrganizationsProvider.hospitals[0];

  DateTime selectedTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 30);

  void selectTime(DateTime time) {
    setState(() {
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    BirthSmoProvider smoProvider = BirthSmoProvider();
    smoProvider.client ?? smoProvider.fetchData();
    selectedChild = smoProvider.client;
    List<Step> steps = [
      Step(
        title: Container(
          width: 290,
          child: const Text(
            'Пожалуйста, выберите ребенка, которому требуется выбрать страховую медицинскую организацию и оформить полис ОМС',
          ),
        ),
        content: Consumer<BirthSmoProvider>(
          builder: (_, birthSmo, __) {
            if (birthSmo == null) {
              return const GosCupertinoLoadingIndicator();
            }
            return Wrap(
              children: <Widget>[
                DropdownButton(
                  hint: Container(
                    width: 265,
                    child: const Text(
                        'Фамилия, имя, отчество новорожденного(-ой)'),
                  ),
                  onChanged: (fullname) {
                    setState(() {
                      selectedChild = birthSmo.client;
                    });
                  },
                  value:
                      '${selectedChild.lastName} ${selectedChild.firstName} ${selectedChild.lastName}',
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
            );
          },
        ),
        state: StepState.complete,
        isActive: true,
      ),
      Step(
        title: Container(
          width: 290,
          child: const Text(
            'Выберите врача, к которому хотите записаться',
          ),
        ),
        content: DropdownButton(
          hint: Container(
            width: 265,
            child: const Text('Врач'),
          ),
          onChanged: (profession) {
            setState(() {
              selectedDoctor =
                  Doctors.doctors.firstWhere((d) => d.profession == profession);
            });
          },
          value: selectedDoctor.profession,
          items: Doctors.doctors
              .map(
                (doctor) => DropdownMenuItem(
                  child: Container(width: 240, child: Text(doctor.profession)),
                  value: doctor.profession,
                ),
              )
              .toList(),
        ),
        state: StepState.complete,
        isActive: true,
      ),
      Step(
        title: Container(
          width: 290,
          child: const Text(
            'Выберите лечебно-профилактическое учреждение для записи',
          ),
        ),
        content: Wrap(
          children: <Widget>[
            DropdownButton(
              hint: Container(
                width: 265,
                child: const Text('Мед.учреждение'),
              ),
              onChanged: (hospitalName) {
                setState(() {
                  selectedHospital = MedicalOrganizationsProvider.hospitals
                      .firstWhere((c) => c.name == hospitalName);
                });
              },
              value: selectedHospital.name,
              items: MedicalOrganizationsProvider.hospitals
                  .map(
                    (hospital) => DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 240,
                          child: Text(
                            hospital.name,
                            maxLines: 4,
                          ),
                        ),
                      ),
                      value: hospital.name,
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 270,
                  maxHeight: 230,
                ),
                child: Image.asset(
                  selectedHospital.imagePath,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
        state: StepState.complete,
        isActive: true,
      ),
      Step(
        title: Container(
          width: 290,
          child: const Text(
            'Выберите удобное время приема',
          ),
        ),
        content: TimestampPicker(
          from: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 16, 30),
          to: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 19, 45),
          interval: Duration(minutes: 15),
          callback: (time) => selectedTime = time,
        ),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Запись на профилактический осмотр'),
      ),
      body: ChangeNotifierProvider.value(
        value: smoProvider,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              WizardHeader(
                'assets/icons/notificationIcon.png',
                'Запись на профилактический осмотр',
              ),
              Stepper(
                physics: ClampingScrollPhysics(),
                controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) =>
                    Container(),
                steps: steps,
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
                          title: Text(
                            'Вы выбрали дату для записи: 16 июня, 2020 г., вторник, ${selectedTime.hour}:${selectedTime.minute == 0 ? "00" : selectedTime.minute}',
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text('Отменить'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            CupertinoDialogAction(
                              child: const Text('Да, подтверждаю'),
                              onPressed: () => Navigator.of(context).pushNamed(
                                DoctorSuccessScreen.routeName,
                                arguments: DoctorSuccessScreenArguments(
                                  selectedHospital,
                                  selectedDoctor,
                                  selectedTime,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    text: 'Выбрать',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
