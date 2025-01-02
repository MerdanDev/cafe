import 'package:cafe/order/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed order list'),
      ),
      body: BlocBuilder<OrderListCubit, List<Order>>(
        bloc: OrderListCubit.instance,
        builder: (context, state) {
          return ListView(
            children: state
                .map(
                  (e) => ListTile(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetView(order: e);
                        },
                        showDragHandle: true,
                        isScrollControlled: true,
                      );
                    },
                    title: Text('Order number:${e.id}'),
                    subtitle: Text(
                      'Summary: '
                      '${e.lines.map(
                            (e) => e.price * e.amount,
                          ).reduce(
                            (value, element) => value + element,
                          )}'
                      r'$'
                      '\nDate:${e.dateTime}',
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      expand: false,
      snap: true,
      snapSizes: const [0.8, 1],
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Order number:${order.id}'),
              ),
            ),
            ...order.lines.map(
              (e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(
                    '${e.price}\$ X ${e.amount} = ${e.amount * e.price}\$',
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
          ],
        );
      },
    );
  }
}
