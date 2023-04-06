import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileFarmer extends StatelessWidget {
  const ProfileFarmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("FarnMitra"),
        actions: [
          IconButton(
              onPressed: () {
                ap.userSignOut().then(
                      (value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Wrapper(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange,
              backgroundImage: NetworkImage(ap.userModel.profilePic),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(ap.userModel.name),
            Text(ap.userModel.age),
            Text(ap.userModel.gender),
            Text(ap.userModel.userType),
            Text(ap.userModel.phoneNumber),
          ],
        ),
      ),
    );

  }
}
