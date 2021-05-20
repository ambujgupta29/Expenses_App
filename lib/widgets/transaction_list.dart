import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;
  TransactionList(this.transactions, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions Added Yet!',
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    height: 200.0,
                    child: Image.asset(
                      'lib/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 5.0,
                  ),
                  elevation: 7.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '₹${transactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deletetx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
