import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Keuangan',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FinancialNotePage(),
    );
  }
}

class FinancialNotePage extends StatefulWidget {
  @override
  _FinancialNotePageState createState() => _FinancialNotePageState();
}

class _FinancialNotePageState extends State<FinancialNotePage> {
  final _transactionController = TextEditingController();
  final _amountController = TextEditingController();
  List<Map<String, dynamic>> _transactions = [];
  double _balance = 0.0;
  String _transactionType = 'Income'; // Default transaction type

  void _addTransaction() {
    final String transaction = _transactionController.text;
    final double? amount = double.tryParse(_amountController.text);
    if (transaction.isEmpty || amount == null) {
      return; // Do nothing if the input is invalid
    }

    // Add transaction to the list
    setState(() {
      _transactions.add({
        'name': transaction,
        'amount': amount,
        'type': _transactionType,
      });

      // Update balance
      if (_transactionType == 'Income') {
        _balance += amount;
      } else {
        _balance -= amount;
      }

      // Clear inputs
      _transactionController.clear();
      _amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan Keuangan'),
      ),
      body: Container(
        color: Colors.blueGrey[50], // Background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _transactionController,
              decoration: InputDecoration(labelText: 'Transaksi'),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text('Pemasukan'),
                  value: 'Income',
                  groupValue: _transactionType,
                  onChanged: (value) {
                    setState(() {
                      _transactionType = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Pengeluaran'),
                  value: 'Expense',
                  groupValue: _transactionType,
                  onChanged: (value) {
                    setState(() {
                      _transactionType = value!;
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nominal'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addTransaction,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
              ),
              child: Text('Simpan Transaksi'),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.green[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Saldo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(_balance.toStringAsFixed(0), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  final isIncome = transaction['type'] == 'Income';
                  return ListTile(
                    leading: Icon(
                      isIncome ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                      color: isIncome ? Colors.green : Colors.red,
                    ),
                    title: Text(transaction['amount'].toString()),
                    subtitle: Text(transaction['name']),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                '©Arimbi Winarjati', // Copyright text
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
