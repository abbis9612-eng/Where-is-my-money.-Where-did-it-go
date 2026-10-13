library;

import 'package:flutter/material.dart';

import 'sync_service.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('المزامنة')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(SyncService.configured ? 'المزامنة مفعّلة.' : 'هالنسخة تشتغل على الموبايل بس. المزامنة بين الموبايلات تتفعل لما يتربط السيرفر.'),
        ),
      );
}
