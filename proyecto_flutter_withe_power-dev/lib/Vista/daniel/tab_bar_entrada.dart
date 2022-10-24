import 'package:flutter/material.dart';

class TabBarEntrada extends StatefulWidget {
  const TabBarEntrada({Key? key}) : super(key: key);

  @override
  _TabBarEntradaState createState() => _TabBarEntradaState();
}

class _TabBarEntradaState extends State<TabBarEntrada> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text('Tabs Demo'),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(child: Text('Todos')),
                      Tab(child: Text('Disponibles')),
                      Tab(child: Text('Expirados')),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                Icon(Icons.flight, size: 350),
                Icon(Icons.directions_transit, size: 350),
                Icon(Icons.directions_car, size: 350),
              ],
            ),
          )),
    );
  }
}
