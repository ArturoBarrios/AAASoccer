import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../commands/payment_commands.dart';
import 'pop_menu_button.dart';

class PaymentListWidget extends StatelessWidget {
  const PaymentListWidget({
    Key? key,
    this.payments,
    this.categorizedPaidUsers,    
    this.onTapPayment,
    this.onTapPaymentOption,
  }) : super(key: key);

  final List<dynamic>? payments;  
  final Map<String, List<dynamic>>? categorizedPaidUsers;
  final Function(int?)? onTapPayment;
  final Function(Map<int, String>?)? onTapPaymentOption;

  Future<void> refund(dynamic payment) async{
    print("refund");
    if(payment['charge'] != null){
      print("stripe refund");
      await PaymentCommand().createRefund(payment['charge']);

    }
  }

  @override
  Widget build(BuildContext context) {
    print("payments: "+ payments.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (categorizedPaidUsers != null)
          ListView.builder(
            itemCount: categorizedPaidUsers?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String role = categorizedPaidUsers?.keys.elementAt(index) ?? '';
              final users = categorizedPaidUsers?[role];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(role),
                  Column(
                    children: users
                            ?.mapIndexed((final index, final user) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  minLeadingWidth: 0,
                                  title: Text(user['user']['username']),
                                  leading: const Icon(Icons.credit_card),
                                  trailing: PopMenuButton(
                                    optionList: const [
                                      'Refund',
                                      'View payer',
                                      'Remind for payment'
                                    ],
                                    onTapOption: (final String? option) =>
                                        onTapPaymentOption?.call(
                                      {index: option ?? ''},
                                    ),
                                  ),
                                  onTap: () => onTapPayment?.call(index),
                                ))
                            .toList() ??
                        [],
                  ),
                ],
              );
            },
          ),
        if (payments != null)
          Column(
            children: payments
                    ?.mapIndexed((final index, final payment) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          minLeadingWidth: 0,
                          title: Text(payment['user']['username']),
                          leading: const Icon(Icons.credit_card),
                          trailing: PopMenuButton(
                            optionList: const [
                              'Refund',
                              'View payer',
                              'Remind for payment'
                            ],
                            onTapOption: (final String? option) {
                              
                              if(option=="Refund"){
                                refund(payment);
                              }

                            }
                            //     onTapPaymentOption?.call(
                            //   {index: option ?? ''},
                            // ),
                          ),
                          onTap: () => onTapPayment?.call(index),
                        ))
                    .toList() ??
                [],
          ),
      ],
    );
  }
}
