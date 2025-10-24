import 'package:flutter/material.dart';
import 'package:flutter_storage/components/add_person_widget.dart';
import 'package:flutter_storage/components/edit_person_widget.dart';
import 'package:flutter_storage/components/persons_widget.dart';
import 'package:flutter_storage/state/contact_book_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StateAppDemoWidget extends StatelessWidget {
  const StateAppDemoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ContactBookState contactBookState = ContactBookState();
    contactBookState.load();
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => contactBookState)
    ],
    child: MaterialApp.router(
      title: 'SQL Demo',
      routerConfig: router(),
    )
    );
  }

  GoRouter router() {
    return GoRouter(
      initialLocation: '/',
        routes: [
          GoRoute(
              path: '/',
            builder: (context, state) => const PersonsWidget(),
            routes: [
              GoRoute(
                  path: 'add',
                builder: (context, state) => const AddPersonWidget()
              ),
              GoRoute(
                  path: 'edit/:id',
                builder: (context, state) => EditPersonWidget(id: state.pathParameters['id']!)
              )
            ]
          )
        ]);
  }
}
