import 'package:flutter/material.dart';

import 'main.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text('Complex sample'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.complex,
              ),
            ),
            ListTile(
              title: Text('Simple sample'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.simple,
              ),
            ),
            ListTile(
              title: Text('Array sample'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.arraySample,
              ),
            ),
            // ListTile(
            //   title: Text('Disable form sample'),
            //   onTap: () => Navigator.of(context).pushReplacementNamed(
            //     Routes.disableFormSample,
            //   ),
            // ),
            // ListTile(
            //   title: Text('Add dynamic controls'),
            //   onTap: () => Navigator.of(context).pushReplacementNamed(
            //     Routes.addDynamicControls,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
