import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:intl/intl.dart';


import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData(){

    final enteredTitle=titleController.text;
    final enteredAmount=double.parse(amountController.text);
    
    if(enteredTitle.isEmpty || enteredAmount <=0 || selectedDate==null){
      print('yes');
      return;
    
      //to exit from here
    }
    widget.addTx(enteredTitle,enteredAmount,selectedDate);
  }


  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate==null){
        return null;
      }
      else{
        setState(() {
           selectedDate=pickedDate;
        });
       
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10+MediaQuery.of(context).viewInsets.bottom,
            //this line add padding according to modal according to virtual keyboard
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
                onSubmitted: (_)=>submitData(),
              ),
              TextField(
                controller: amountController,
                onSubmitted: (_)=>submitData(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Container(
                height: 70,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(selectedDate==null?
                        'No date chosen!':
                        'Picked Date: ${DateFormat.yMEd().format(selectedDate)}'
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),

                      ),
                      onPressed: _presentDatePicker,
                    ),
                    AdaptiveButton(
                      'Add Transaction', 
                      submitData,
                    ),
                  ],

                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
