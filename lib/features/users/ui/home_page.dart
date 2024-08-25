import 'package:Users/features/users/bloc/users_bloc.dart';
import 'package:Users/features/users/data/models/users_model.dart';
import 'package:Users/features/users/data/repos/user_repo.dart';
import 'package:Users/features/users/ui/more_details_page.dart';
import 'package:Users/features/users/ui/widgets/button.dart';
import 'package:Users/features/users/ui/widgets/user_info_row.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UsersBloc usersBloc = UsersBloc();
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _filteredUsers = [];
  bool _isSearching = false; 

  @override
  void initState() {
    usersBloc.add(UsersInitialfetchEvent());
    _searchController.addListener(_filterUsers);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterUsers() {
    final query = _searchController.text;
    setState(() {
      _filteredUsers = usersBloc.state is UserfetchingSuccessful
          ? filterUsers((usersBloc.state as UserfetchingSuccessful).users, query)
          : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          shadowColor: Colors.black,
          title: const Text('Users'),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                    _filterUsers();
                  }
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            if (_isSearching) 
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintText: 'Search by name',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            Expanded(
              child: BlocConsumer<UsersBloc, UsersState>(
                bloc: usersBloc,
                listenWhen: (previous, current) => current is UserActionState,
                buildWhen: (previous, current) => current is! UserActionState,
                listener: (context, state) {
                  if (state is UserfetchingSuccessful) {
                    _filterUsers(); 
                  }
                },
                builder: (context, state) {
                  if (state is UserfetchingSuccessful) {
                    final users = _filteredUsers.isNotEmpty
                        ? _filteredUsers
                        : state.users;

                    return Scrollbar(
                      thumbVisibility: true,
                      thickness: 7,
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = users[index];
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  borderRadius: const BorderRadius.all(Radius.circular(9))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UserInfoRow(label: 'Name', value: user.name),
                                    UserInfoRow(label: 'Username', value: user.username),
                                    UserInfoRow(label: 'Phone Number', value: user.phone),
                                    UserInfoRow(label: 'Company', value: user.company.name),
                                    UserInfoRow(label: 'Domain', value: user.company.bs),
                                    PurplePrimaryActionButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MoreDetailsPage(
                                                user: user,
                                              ),
                                            ),
                                          );
                                        },
                                        text: 'More Details'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
