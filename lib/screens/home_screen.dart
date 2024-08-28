import 'package:flutter/material.dart';
import 'settings_screen.dart'; // 설정 페이지
import 'admin_screen.dart'; // 어드민 페이지
import 'dashboard_screen.dart'; // 대시보드 페이지

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('보고서'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: _buildDrawer(context), // 사이드 메뉴 추가
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildReportItem(
              context,
              icon: Icons.science,
              title: '화학물질 관리대장',
            ),
            _buildReportItem(
              context,
              icon: Icons.ac_unit,
              title: '특별관리물질 관리대장',
            ),
            _buildReportItem(
              context,
              icon: Icons.calendar_today,
              title: '월간시약 관리대장',
            ),
            _buildReportItem(
              context,
              icon: Icons.warning,
              title: '유해인자 취급 및 관리대장',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '메뉴',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: '대시보드',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.report,
            text: '보고서',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: '설정',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.admin_panel_settings,
            text: '어드민',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildReportItem(BuildContext context,
      {required IconData icon, required String title}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // 각 보고서로 이동하는 코드를 추가할 수 있습니다.
        },
      ),
    );
  }
}
