import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_storage/db/dto/person_entity.dart';
import 'package:flutter_storage/state/contact_book_state.dart';
import 'package:flutter_storage/state/number_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditPersonWidget extends StatefulWidget {
  const EditPersonWidget({super.key, required this.id});

  final String id;

  @override
  State<EditPersonWidget> createState() => _EditPersonWidgetState();
}

class _EditPersonWidgetState extends State<EditPersonWidget> {
  final _formKey = GlobalKey<FormState>();
  PersonEntity? personContact;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        ContactBookState state = Provider.of<ContactBookState>(context, listen: false);
        personContact = PersonEntity.copy(personEntity: state.byId(widget.id)!);
      });
    });
  }

  void _save() {
    ContactBookState state = Provider.of<ContactBookState>(context, listen: false);
    state.edit(personContact!);
    context.pop();
  }

  void _delete() {
    ContactBookState state = Provider.of<ContactBookState>(context, listen: false);
    state.edit(personContact!);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add person to contacts')),
      body: personContact != null ? Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: personContact!.firstName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First name',
                ),
                onChanged: (value) {
                  setState(() {
                    personContact!.firstName = value;
                  });
                },
                validator: (value) => personContact!.validateFirstName(),
              ),
              SizedBox(height: 16, width: double.infinity),
              TextFormField(
                initialValue: personContact!.lastName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last name',
                ),
                onChanged: (value) {
                  setState(() {
                    personContact!.lastName = value;
                  });
                },
                validator: (value) => personContact!.validateLastName(),
              ),
              SizedBox(height: 16, width: double.infinity),
              TextFormField(
                initialValue: personContact!.phone,
                autocorrect: false,
                inputFormatters: [NumberFormatter()],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone',
                ),
                onChanged: (value) {
                  setState(() {
                    personContact!.phone = value;
                  });
                },
                validator: (value) => personContact!.validatePhone(),
              ),
              SizedBox(height: 16, width: double.infinity),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: personContact!.validate() ? _save : null,
                      child: Text('Save contact'),
                    ),
                    const SizedBox(height: 8, width: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text('Cancel'),
                    ),
                    const SizedBox(height: 8, width: 8),
                    ElevatedButton(
                      onPressed: _delete,
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ) : null,
    );;
  }

}
