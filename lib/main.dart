import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.black,
        errorColor: Colors.red,
        fontFamily: 'Graduate',
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(
                color: Colors.white,
              ),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
//    Transaction(
//      id: 't1',
//      title: 'New Shoes',
//      amount: 69.99,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: 't2',
//      title: 'Weekly Groceries',
//      amount: 16.53,
//      date: DateTime.now(),
//    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosenTime) {
    final newTx = Transaction(
      title: txtitle,
      amount: txamount,
      date: chosenTime,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
