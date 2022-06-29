import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sosdoctorsystem/screens/schedules/schedules_create_screen.dart';

import '../../constant.dart';
import '../../models/api_response.dart';
import '../../services/auth_service.dart';
import '../../services/historics_service.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';

class CreateHistoricScreen extends StatefulWidget {
  static const String id = 'createhistoric-screen';
  const CreateHistoricScreen({Key? key}) : super(key: key);

  @override
  State<CreateHistoricScreen> createState() => _CreateHistoricScreenState();
}

class _CreateHistoricScreenState extends State<CreateHistoricScreen> {
  final SideBarWidget _sideBar = SideBarWidget();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _localBronController = TextEditingController();
  final TextEditingController _biController = TextEditingController();
  final TextEditingController _spouseController = TextEditingController();
  final TextEditingController _parentsController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();

  bool loading = false;
  String? dateController;
  int _valueGender = 1;
  int _statusCivil = 1;

  void _createHistoric() async {

    ApiResponse response = await createHistoric(
      _nameController.text,
      _valueGender.toString(),
      _numberPhoneController.text,
      _addressController.text,
      _localBronController.text,
      dateController,
      _statusCivil.toString(),
      _biController.text,
      _spouseController.text,
      _parentsController.text,
      _professionController.text,
    );

    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const CreateHistoricScreen()),
          (route) => false);
    } else if (response == unauthorized) {
      logout().then((value) => [
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          ]);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        loading = !loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Historico Clinico'),
        backgroundColor: kColorPrimary,
        elevation: 0,
      ),
      sideBar: _sideBar.sidebarMenus(context, CreateSchedulesScreen.id),
      body: Form(
        key: formkey,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Nova Historico',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Dados Pessoais',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Nome Completo",
                  label: Text("Nome Completo"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(children: [
                Radio(
                  value: 1,
                  groupValue: _valueGender,
                  onChanged: (value) {
                    setState(() {
                      _valueGender = value as int;
                    });
                  },
                ),
                const SizedBox(width: 10),
                const Text("Masculino"),
                const SizedBox(width: 50),
                Radio(
                  value: 2,
                  groupValue: _valueGender,
                  onChanged: (value) {
                    setState(() {
                      _valueGender = value as int;
                    });
                  },
                ),
                const SizedBox(width: 10),
                const Text("Femenino"),
              ]),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _numberPhoneController,
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Nº de Telefone",
                  label: Text("Nº de Telefone"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Endereço do Paciente",
                  label: Text("Digite seu Endereço"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _localBronController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Local de Nascimento",
                  label: Text("Local de Nascimento"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: DateTimePicker(
                  locale: const Locale("pt", "BR"),
                  type: DateTimePickerType.dateTime,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(1930),
                  lastDate: DateTime.now(),
                  dateLabelText: 'Data',
                  timeLabelText: "Hora",
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }
                    return true;
                  },
                  onChanged: (val) {
                    setState(() {
                      dateController = val;
                    });
                  },
                  validator: (val) {
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      dateController = val;
                    });
                  }),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(children: [
                Radio(
                  value: 1,
                  groupValue: _statusCivil,
                  onChanged: (value) {
                    setState(() {
                      _statusCivil = value as int;
                    });
                  },
                ),
                const SizedBox(width: 10),
                const Text("Solteiro"),
                const SizedBox(width: 50),
                Radio(
                  value: 2,
                  groupValue: _statusCivil,
                  onChanged: (value) {
                    setState(() {
                      _statusCivil = value as int;
                    });
                  },
                ),
                const SizedBox(width: 10),
                const Text("Casaso"),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _biController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Número B.I",
                  label: Text("Número B.I"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _spouseController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Nome do Cônjuge",
                  label: Text("Nome do Cônjuge"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _parentsController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Nome dos País",
                  label: Text("Nome dos Pais"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _professionController,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val!.isEmpty ? "Essa dado é obrigatório" : null,
                decoration: const InputDecoration(
                  hintText: "Profissião",
                  label: Text("Profissião"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: kColorPrimary,
                      minimumSize: const Size(
                        150,
                        50,
                      ),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _createHistoric();
                      }
                    },
                    child: const Text("REGISTAR"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
