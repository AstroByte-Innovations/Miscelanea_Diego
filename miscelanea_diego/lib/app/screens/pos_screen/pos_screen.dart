import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_controller.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class POSScreen extends StatefulWidget {
  const POSScreen({super.key});

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  final PosController _controller = PosController();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        background: Theme.of(context).colorScheme.primary,
        key: _sideMenuKey,
        menu: Menu.buildMenu(context),
        type: SideMenuType.slideNRotate,
        child: Scaffold(
          appBar: GlobalWidgets.appBar(_sideMenuKey, 'Punto de Venta'),
          body: ElevatedButton(
            child: const Text('Inicializar'),
            onPressed: () {},
          ),
        ));
  }
}
