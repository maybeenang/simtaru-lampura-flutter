import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const Text("Menu"),
            ListTile(
              title: const Text("Pengajuan"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Verifikasi Lapangan"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Seluruh Pengajuan"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
