import 'dart:convert';
import 'dart:io';

import 'package:cafe/core/shared_preference.dart';
import 'package:cafe/core/utils.dart';
import 'package:cafe/product/product.dart';
import 'package:cafe/product_category/product_category.dart';
import 'package:cafe/venue/venue.dart';
import 'package:cafe/venue_category/venue_category.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () async {
              final result = await FilePicker.platform.pickFiles();

              if (result != null) {
                final file = File(result.files.single.path!);
                final data = await file.readAsString();
                final decoded = jsonDecode(data);
                if (decoded is Map<String, dynamic>) {
                  VenueCategoryCubit.instance
                      .getFromFile(decoded['venueCategories'] as List<dynamic>);
                  VenueCubit.instance
                      .getFromFile(decoded['venues'] as List<dynamic>);
                  await ProductCategoryCubit.instance.getFromFile(
                    decoded['productCategories'] as List<dynamic>,
                  );
                  await ProductCubit.instance.getFromFile(
                    decoded['products'] as List<dynamic>,
                  );
                }
              } else {
                // User canceled the picker
              }
            },
            leading: const Icon(Icons.download),
            title: const Text('Add data JSON form'),
          ),
          ListTile(
            onTap: () async {
              final orders = SingletonSharedPreference.loadOrders();
              if (orders != null) {
                final file = await writeFileToStorage(
                    orders, 'order-list:${DateTime.now()}');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('File was saved to ${file.path}'),
                    ),
                  );
                }
              }
            },
            leading: const Icon(Icons.save),
            title: const Text('Save order list on app data'),
          ),
        ],
      ),
    );
  }
}
