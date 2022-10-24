import 'package:flutter/material.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/Crud/TabNavigationItem.dart';

class TabsPage extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_HOMEUSUARIO;

  int selectedIndex = 0;

  TabsPage({required this.selectedIndex});

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with SingleTickerProviderStateMixin{
  late TabController tabController;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;
    });
  }

  @override
  void initState() {
    _onItemTapped(widget.selectedIndex);
    _selectedIndex = 0;
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: IndexedStack(
          index: widget.selectedIndex,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Color(0xFF4760FF)))),
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF4760FF),
          onTap: _onItemTapped,
          unselectedItemColor: const Color(0XFFBCBABE),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.apps_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.api_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined), label: ''),
          ],
        ),
      ),
    );
  }
}
