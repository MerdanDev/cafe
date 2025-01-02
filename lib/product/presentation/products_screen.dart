import 'dart:io';

import 'package:cafe/order/order.dart';
import 'package:cafe/product/product.dart';
import 'package:cafe/product_category/product_category.dart';
import 'package:cafe/venue/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({required this.table, super.key});

  final Venue table;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCategoryCubit, List<ProductCategory>>(
      bloc: ProductCategoryCubit.instance,
      builder: (context, state) {
        return DefaultTabController(
          length: state.length,
          child: Scaffold(
            endDrawer: Drawer(
              child: DrawerView(
                tableId: widget.table.id,
              ),
            ),
            appBar: AppBar(
              title: Text(widget.table.name),
              bottom: TabBar(
                tabs: state
                    .map(
                      (category) => Tab(
                        text: category.name,
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(category.imagePath),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: state.map(
                (category) {
                  return BlocBuilder<ProductCubit, List<Product>>(
                    bloc: ProductCubit.instance,
                    builder: (context, state) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisExtent: 200,
                        ),
                        children: state
                            .where(
                          (product) => product.categoryId == category.id,
                        )
                            .map(
                          (product) {
                            return ProductWidget(
                              product: product,
                              tableId: widget.table.id,
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

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    required this.product,
    required this.tableId,
    super.key,
  });

  final Product product;
  final int tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        OrderListCubit.instance.add(
          tableId: tableId,
          productId: product.id,
          price: product.price,
          name: product.name,
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(
                      product.image,
                    ),
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.name),
                  Text('${product.price}\$'),
                ],
              ),
              BlocBuilder<OrderListCubit, List<Order>>(
                bloc: OrderListCubit.instance,
                builder: (context, state) {
                  if (state.isNotEmpty &&
                      state.any(
                        (e) => e.tableId == tableId && e.status == 0,
                      ) &&
                      state
                          .firstWhere(
                            (e) => e.tableId == tableId && e.status == 0,
                          )
                          .lines
                          .any(
                            (e) => product.id == e.productId,
                          )) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            OrderListCubit.instance.add(
                              tableId: tableId,
                              productId: product.id,
                              price: product.price,
                              name: product.name,
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                        Text(
                          state
                              .firstWhere(
                                (e) => e.tableId == tableId && e.status == 0,
                              )
                              .lines
                              .firstWhere(
                                (e) => product.id == e.productId,
                              )
                              .amount
                              .toString(),
                        ),
                        IconButton(
                          onPressed: () {
                            OrderListCubit.instance.remove(
                              tableId: tableId,
                              productId: product.id,
                              price: product.price,
                              name: product.name,
                            );
                          },
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerView extends StatelessWidget {
  const DrawerView({required this.tableId, super.key});
  final int tableId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderListCubit, List<Order>>(
      bloc: OrderListCubit.instance,
      builder: (context, state) {
        if (state.isNotEmpty &&
            state.any(
              (e) => e.tableId == tableId && e.status == 0,
            )) {
          final order = state.firstWhere(
            (e) => e.tableId == tableId && e.status == 0,
          );
          return ListView(
            children: [
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Order list'),
                ),
              ),
              ...order.lines.map(
                (e) {
                  return ListTile(
                    leading: IconButton(
                      onPressed: () {
                        OrderListCubit.instance.add(
                          tableId: tableId,
                          productId: e.productId,
                          price: e.price,
                          name: e.name,
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                    title: Text(e.name),
                    subtitle: Text(
                      '${e.price}\$ X ${e.amount} = ${e.amount * e.price}\$',
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        OrderListCubit.instance.remove(
                          tableId: tableId,
                          productId: e.productId,
                          price: e.price,
                          name: e.name,
                        );
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  );
                },
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Summary:'),
                          Text(
                            '${order.lines.map(
                                  (e) => e.price * e.amount,
                                ).reduce(
                                  (value, element) => value + element,
                                )}'
                            r'$',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  OrderListCubit.instance.completeOrder(id: order.id);
                },
                child: const Text('Complete order'),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
