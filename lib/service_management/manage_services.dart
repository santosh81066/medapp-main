import 'package:flutter/material.dart';
import 'package:gomedserv/widgets/bottomnavigation.dart';
import 'package:gomedserv/service_management/add_service.dart';
import 'package:gomedserv/widgets/topbar.dart';
import 'package:gomedserv/models/manage_users_model.dart';

class ManageServices extends StatefulWidget {
  @override
  _ManageServicesState createState() => _ManageServicesState();
}

class _ManageServicesState extends State<ManageServices> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingScale = screenWidth * 0.04; // Example: 4% of screen width
    final spacingScale = screenHeight * 0.01; // Example: 2% of screen height
    final buttonHeight = screenHeight * 0.06; // Example: 6% of screen height

    final filteredUsers = usersData
        .where((user) =>
            user.username?.toLowerCase().contains(searchQuery.toLowerCase()) ??
            false)
        .toList();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                title: 'Manage Services',
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: spacingScale),
              _buildSearchBar(paddingScale),
              SizedBox(height: spacingScale),
              _buildUserListRow(context, paddingScale),
              if (filteredUsers.isEmpty)
                Padding(
                  padding: EdgeInsets.all(paddingScale),
                  child: Text(
                    'No users found.',
                    style: TextStyle(
                        fontSize: screenWidth * 0.04, color: Colors.grey),
                  ),
                )
              else
                _buildUserList(filteredUsers, screenHeight),
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

  Widget _buildUserListRow(BuildContext context, double paddingScale) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingScale),
      child: Row(
        children: [
          const Text(
            'Service Catalog',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddServiceScreen(),
                ),
              );
            },
            child: const Text(
              "Add Service",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
              width: paddingScale * 0.4), // Responsive spacing between buttons
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Edit",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
              width: paddingScale * 0.4), // Responsive spacing between buttons
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Delete",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(double paddingScale) {
    return Padding(
      padding: EdgeInsets.all(paddingScale),
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
    );
  }

  Widget _buildUserList(List<User> users, double screenHeight) {
    return Container(
      height: screenHeight *
          0.6, // Adjust the height as per your need (e.g., 70% of screen height)
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
                  fontSize: screenHeight *
                      0.025, // Font size relative to screen height
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
                      fontSize: screenHeight *
                          0.02, // Font size relative to screen height
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
                      fontSize: screenHeight *
                          0.02, // Font size relative to screen height
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddServiceScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
