import 'package:flutter/material.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffe_bills_view_body.dart';

class AllActiveBillsCoffeeBody extends StatelessWidget {
  const AllActiveBillsCoffeeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoffeeBillsBuilder(),
    );
  }
}
