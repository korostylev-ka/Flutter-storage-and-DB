import 'package:flutter/material.dart';
import 'package:flutter_storage/db/dto/person_entity.dart';
import 'package:flutter_storage/state/contact_book_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PersonsWidget extends StatelessWidget {
  const PersonsWidget({super.key});

  Future<void> _onAddContact(BuildContext context) async {
    context.go('/add');
  }

  Future<void> _onEditContact(BuildContext context, String id) async {
    context.go('/edit/$id');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactBookState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Persons list')),
          body: state.status == Status.done
              ? ListView.builder(
                  itemCount: state.contacts.length,
                  itemBuilder: (context, index) {
                    PersonEntity personContact = state.contacts[index];
                    return ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(
                        '${personContact.firstName} ${personContact.lastName}',
                      ),
                      subtitle: Text(personContact.phone),
                      trailing: const Icon(Icons.edit),
                      onTap: () async {
                        _onEditContact(context, personContact.id);
                      },
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator()),
          floatingActionButton: state.status == Status.done
              ? FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    _onAddContact(context);
                  },
                )
              : null,
        );
      },
    );
  }
}
