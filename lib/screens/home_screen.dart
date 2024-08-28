// File: /lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'settings_screen.dart';
import 'admin_screen.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      appBarColor: Colors.transparent,
      title: const Text('Home'), // 상단 제목
      headerWidget: _buildHeader(), // 상단 헤더 위젯
      body: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
      ],
      drawer: _buildDrawer(context), // 사이드 메뉴 추가
    );
  }

  // 상단 헤더 위젯
  Widget _buildHeader() {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              '상단 슬라이딩 패널',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              '이곳에 중요 정보를 표시하거나\n추가 기능을 배치할 수 있습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // 사이드 드로어 위젯
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

  // 드로어 아이템 생성기
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  // 보고서 아이템 생성기
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
