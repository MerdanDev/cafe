import 'package:cafe/order/order.dart';
import 'package:cafe/product/presentation/presentation.dart';
import 'package:cafe/settings/presentation/settings_screen.dart';
import 'package:cafe/venue/venue.dart';
import 'package:cafe/venue_category/venue_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({super.key});

  @override
  State<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenueCategoryCubit, List<VenueCategory>>(
      bloc: VenueCategoryCubit.instance,
      builder: (context, state) {
        return DefaultTabController(
          length: state.length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Select table'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<OrderListScreen>(
                        builder: (context) => const OrderListScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.list_alt),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<SettingsScreen>(
                        builder: (context) {
                          return const SettingsScreen();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
              bottom: TabBar(
                tabs: state.map(
                  (e) {
                    return Tab(
                      text: e.name,
                    );
                  },
                ).toList(),
              ),
            ),
            body: TabBarView(
              children: state.map(
                (category) {
                  return BlocBuilder<VenueCubit, List<Venue>>(
                    bloc: VenueCubit.instance,
                    builder: (context, state) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          mainAxisExtent: 90,
                        ),
                        children: state
                            .where(
                          (venue) => venue.categoryId == category.id,
                        )
                            .map(
                          (e) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<ProductScreen>(
                                    builder: (context) {
                                      return ProductScreen(
                                        table: e,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Text(e.name),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      );
                    },
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
