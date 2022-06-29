import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosdoctorsystem/models/historic_model.dart';
import 'package:sosdoctorsystem/screens/clinical/create_historic_screen.dart';
import 'package:sosdoctorsystem/screens/clinical/view_historic_pdf.dart';
import 'package:sosdoctorsystem/services/historics_service.dart';

import '../../constant.dart';
import '../../models/api_response.dart';
import '../../services/auth_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';

class ListHistoricScreen extends StatefulWidget {
  static const String id = 'historics-screen';
  const ListHistoricScreen({Key? key}) : super(key: key);

  @override
  State<ListHistoricScreen> createState() => _ListHistoricScreenState();
}

class _ListHistoricScreenState extends State<ListHistoricScreen> {
  List<dynamic> _historicList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getHistorics();

    if (response.error == null) {
      setState(() {
        _historicList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }


  void _getDochistoric(HistoricModel historic) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setInt('id', historic.id ?? 0);
      await pref.setString('name', historic.namePatients ?? '');
      await pref.setString('gender', historic.genderPatients ?? '');
      await pref.setString('numberphone', historic.numberPatients ?? '');
      await pref.setString('address', historic .addressPatients?? '');
      await pref.setString('local', historic.localPatients ?? '');
      await pref.setString('date', historic.birthdatePatients ?? '');
      await pref.setString('staus', historic.civilstatusPatients ?? 'historic');
      await pref.setString('bi', historic.biPatients ?? '');
      await pref.setString('spouse', historic.spousePatients ?? '');
      await pref.setString('parents', historic.parentsPatients ?? '');
      await pref.setString('profission', historic.profissionPatients ?? '');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoricPdfScreen()),
    );

  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Justificativos'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListHistoricScreen.id),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Justificativos',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
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
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateHistoricScreen(),
                              ),
                              (route) => false);
                        },
                        child: const Text("CRIAR NOVO"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _historicList.length,
                    itemBuilder: (BuildContext context, int index) {
                      HistoricModel historic = _historicList[index];
                      return ListTile(
                        onTap: () {
       
                          _getDochistoric(historic);
                        },
                        leading: SvgPicture.asset(
                          'assets/images/svg/atestado.svg',
                          width: 45,
                          height: 45,
                          color: Colors.grey[400],
                        ),
                        title: Text('${historic.namePatients}'),
                        subtitle: Row(
                          children: [
                            Text('${historic.biPatients}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditOccourenceScreen(
                                  historic: historic,
                                  ref: historic.id,
                                ),
                              ),
                            );
                            */
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
