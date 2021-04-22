import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addnewtx;

  NewTransaction(this.addnewtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime selecteddate;

  void submitdata() {
    if (amountcontroller.text.isEmpty) {
      return;
    }
    final enteredtitle = titlecontroller.text;
    final enteredamount = double.parse(amountcontroller.text);
    if (enteredtitle.isEmpty || enteredamount <= 0 || selecteddate == null) {
      return;
    }

    widget.addnewtx(
      enteredtitle,
      enteredamount,
      selecteddate,
    );
    Navigator.of(context).pop();
  }

  void _presentdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        selecteddate = pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          // width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (val)=> titleinput=val,
                controller: titlecontroller,
                onSubmitted: (_) => submitdata(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitdata(),

                // onChanged: (val)=> amountinput=val
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(selecteddate == null
                            ? 'No Date Chosen!'
                            : DateFormat.yMd().format(selecteddate))),
                    FlatButton(
                      onPressed: _presentdatepicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              OutlineButton(
                onPressed: submitdata,
                textColor: Colors.redAccent,
                child: Text(
                  ' Add ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
