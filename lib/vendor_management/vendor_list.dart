import 'package:flutter/material.dart';
import 'package:gomedserv/widgets/bottomnavigation.dart';
import 'package:gomedserv/vendor_management/add_vendor.dart';
import 'package:gomedserv/widgets/topbar.dart';
import 'package:gomedserv/models/manage_users_model.dart';

class VendorList extends StatefulWidget {
  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define padding and spacing based on screen height
    double padding = screenHeight * 0.02; // 2% of screen height
    double spacing = screenHeight * 0.015; // 1.5% of screen height

    // Define the max height for the user list based on screen height
    double userListHeight = screenHeight * 0.6; // 50% of screen height

    // Filter users based on search query
    final filteredUsers = usersData
        .where((user) =>
            user.username?.toLowerCase().contains(searchQuery.toLowerCase()) ??
            false ||
                // user.email?.toLowerCase().contains(searchQuery.toLowerCase()) ??
                false)
        .toList();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                title: 'Vendor List',
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              // SizedBox(height: padding),
              _buildSearchBar(),
              // SizedBox(height: spacing), // Space between search bar and row
              _buildUserListRow(context),
              if (filteredUsers.isEmpty)
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Text(
                    'No users found.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              else
                Container(
                  height: userListHeight,
                  child: _buildUserList(filteredUsers),
                ),
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

  Widget _buildUserListRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.02 * MediaQuery.of(context).size.width),
      child: Row(
        children: [
          const Text(
            'Booking Overview',
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
                MaterialPageRoute(builder: (context) => AddVendor()),
              );
            },
            child: const Text(
              "Add Vendor",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(width: 10), // Add some spacing between the buttons
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Edit",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(width: 10), // Add some spacing between the buttons
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Approve",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(width: 10), // Add some spacing between the buttons
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

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(0.02 * MediaQuery.of(context).size.height),
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

  Widget _buildUserList(List<User> users) {
    return ListView.builder(
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
          child: ListTile(
            title: Text(
              "${user.username ?? "No Name"}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
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
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
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
                    color: user.status == 'Active' ? Colors.green : Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              // Handle tap action
            },
          ),
        );
      },
    );
  }
}
