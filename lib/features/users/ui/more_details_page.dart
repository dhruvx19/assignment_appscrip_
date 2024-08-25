import 'package:Users/features/users/data/models/users_model.dart';
import 'package:Users/features/users/ui/widgets/user_info_row.dart';

import 'package:flutter/material.dart';

class MoreDetailsPage extends StatefulWidget {
  final UserModel user;

  const MoreDetailsPage({super.key, required this.user});

  @override
  State<MoreDetailsPage> createState() => _MoreDetailsPageState();
}

class _MoreDetailsPageState extends State<MoreDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = widget.user.name.split(' ').first;

    return Scaffold(
      appBar: AppBar(
        title: Text('$firstName\'s Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(9)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoRow(label: 'City', value: widget.user.address.city),
                UserInfoRow(label: 'Street', value: widget.user.address.street),
                UserInfoRow(label: 'Suite', value: widget.user.address.suite),
                UserInfoRow(label: 'Zipcode', value: widget.user.address.zipcode),
                UserInfoRow(label: 'Latitude', value: widget.user.address.geo.lat),
                UserInfoRow(label: 'Longitude', value: widget.user.address.geo.lng),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
