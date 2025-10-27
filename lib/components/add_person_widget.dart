import 'package:flutter/material.dart';
import 'package:flutter_storage/db/dto/person_entity.dart';
import 'package:flutter_storage/state/number_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/contact_book_state.dart';

class AddPersonWidget extends StatefulWidget {
  const AddPersonWidget({super.key});

  @override
  State<AddPersonWidget> createState() => _AddPersonWidgetState();
}

class _AddPersonWidgetState extends State<AddPersonWidget> {

  final _formKey = GlobalKey<FormState>();
  PersonEntity personContact = PersonEntity();

  @override
  void initState() {
    super.initState();
  }

  void _create() {
    ContactBookState state = Provider.of<ContactBookState>(
      context,
      listen: false,
    );
    state.create(personContact);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add person to contacts')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First name',
                ),
                onChanged: (value) {
                  setState(() {
                    personContact.firstName = value;
                  });
                },
                validator: (value) => personContact.validateFirstName(),
              ),
              SizedBox(height: 16, width: double.infinity),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last name',
                ),
                onChanged: (value) {
                  setState(() {
                    personContact.lastName = value;
                  });
                },
                validator: (value) => personContact.validateLastName(),
              ),
              SizedBox(height: 16, width: double.infinity),
              TextFormField(
                autocorrect: false,
                inputFormatters: [NumberFormatter()],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone',
                ),
                onChanged: (value) {
                  setState(() {
                    personContact.phone = value;
                  });
                },
                validator: (value) => personContact.validatePhone(),
              ),
              SizedBox(height: 16, width: double.infinity),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: personContact.validate() ? _create : null,
                      child: Text('Add contact'),
                    ),
                    const SizedBox(height: 8, width: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text('Cancel'),
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
