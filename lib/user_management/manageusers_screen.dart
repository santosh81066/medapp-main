import 'package:flutter/material.dart';
import 'package:gomedserv/widgets/bottomnavigation.dart';
import 'package:gomedserv/user_management/user_profile.dart';
import 'package:gomedserv/widgets/topbar.dart';
import 'package:gomedserv/models/manage_users_model.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double paddingHorizontal = screenWidth * 0.04; // 4% of screen width
    final double topBarHeight = screenHeight * 0.07; // 7% of screen height
    final double searchBarHeight = screenHeight * 0.06; // 6% of screen height
    final double listHeight = screenHeight * 0.6; // 60% of screen height

    final filteredUsers = usersData
        .where((user) =>
            user.username?.toLowerCase().contains(searchQuery.toLowerCase()) ??
            false ||
                user.email!.toLowerCase().contains(searchQuery.toLowerCase()) ??
            false)
        .toList();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                title: 'Manage Users',
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),

              SizedBox(height: screenHeight * 0.01), // 1% of screen height
              _buildSearchBar(paddingHorizontal, searchBarHeight),
              SizedBox(
                  height:
                      screenHeight * 0.01), // Space between search bar and row
              _buildUserListRow(paddingHorizontal),
              if (filteredUsers.isEmpty)
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  child: Text(
                    'No users found.',
                    style: TextStyle(
                        fontSize: screenWidth * 0.04, color: Colors.grey),
                  ),
                )
              else
                _buildUserList(filteredUsers, listHeight),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildUserListRow(double paddingHorizontal) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Users List',
            style: TextStyle(
              fontSize:
                  paddingHorizontal * 1.2, // Adjust font size based on padding
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Deactivate",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(double paddingHorizontal, double searchBarHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: SizedBox(
        height: searchBarHeight,
        child: TextField(
          onChanged: (query) {
            setState(() {
              searchQuery = query;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search by username or email',
            suffixIcon: const Icon(
              Icons.search,
              size: 25,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserList(List<User> users, double listHeight) {
    return Container(
      height: listHeight,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
            child: ListTile(
              title: Text(
                "${user.username ?? "No Name"}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width *
                      0.045, // Adjust font size based on screen width
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.email ?? "No Email"}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "${user.date ?? "No Date"}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width *
                          0.035, // Adjust font size based on screen width
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${user.status ?? "Active"}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color:
                          user.status == 'Active' ? Colors.green : Colors.red,
                      fontSize: MediaQuery.of(context).size.width *
                          0.035, // Adjust font size based on screen width
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfileScreen(
                            user: user,
                          )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
