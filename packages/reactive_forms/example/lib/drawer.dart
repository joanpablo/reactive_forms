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
              title: const Text('Login sample'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.loginSample,
              ),
            ),
            ListTile(
              title: const Text('Complex sample'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.complex,
              ),
            ),
            ListTile(
              title: const Text('Simple sample'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.simple,
              ),
            ),
            ListTile(
              title: const Text('Array sample'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.arraySample,
              ),
            ),
            ListTile(
              title: const Text('Datepicker sample'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.datePickerSample,
              ),
            ),
            ListTile(
              title: const Text('Reactive forms widgets'),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                Routes.reactiveFormWidgets,
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
