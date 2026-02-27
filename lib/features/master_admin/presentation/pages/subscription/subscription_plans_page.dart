import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/subscription_plan.dart';

class SubscriptionPlansPage extends StatelessWidget {
  const SubscriptionPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded plans for demo
    final plans = [
      SubscriptionPlan(
        id: '1',
        name: 'Starter Plan',
        price: 999,
        durationMonths: 12,
      ),
      SubscriptionPlan(
        id: '2',
        name: 'Premium Plan',
        price: 2499,
        durationMonths: 24,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Subscription Plans')),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                Icons.card_membership,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                plan.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '₹${plan.price} for ${plan.durationMonths} months',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Get.snackbar('Plan selected', 'Details for ${plan.name}');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.snackbar('Action', 'Add plan feature coming soon'),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
