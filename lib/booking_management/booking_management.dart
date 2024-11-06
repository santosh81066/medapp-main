import 'package:flutter/material.dart';
import 'package:gomedserv/widgets/bottomnavigation.dart';
import 'package:gomedserv/booking_management/add_commission.dart';
import 'package:gomedserv/widgets/topbar.dart';
import 'package:gomedserv/models/manage_users_model.dart';

class BookingManagement extends StatefulWidget {
  const BookingManagement({super.key});

  @override
  State<BookingManagement> createState() => _BookingManagementState();
}

class _BookingManagementState extends State<BookingManagement> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Define padding and height based on screen dimensions
    final double paddingHorizontal = screenWidth * 0.04; // 4% of screen width
    final double topBarHeight = screenHeight * 0.07; // 7% of screen height
    final double searchBarHeight = screenHeight * 0.06; // 6% of screen height
    final double listHeight = screenHeight * 0.6; // 60% of screen height

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
                title: 'Booking Management',
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: screenHeight * 0.01), // 1% of screen height
              _buildSearchBar(paddingHorizontal, searchBarHeight),
              SizedBox(height: screenHeight * 0.01), // 1% of screen height
              _buildUserListRow(context, paddingHorizontal),
              if (filteredUsers.isEmpty)
                Padding(
                  padding:
                      EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
                  child: Text(
                    'No users found.',
                    style: TextStyle(
                        fontSize: screenHeight * 0.02, color: Colors.grey),
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

  Widget _buildUserListRow(BuildContext context, double paddingHorizontal) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: Row(
        children: [
          const Text(
            'Booking Overview',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCommission(),
                ),
              );
            },
            child: const Text(
              "Commissions",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(width: paddingHorizontal * 0.1), // Add some spacing
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Reschedule",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(width: paddingHorizontal * 0.1), // Add some spacing
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Cancel",
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
    return SizedBox(
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
            margin: EdgeInsets.symmetric(
              vertical: listHeight * 0.01, // 1% of list height
              horizontal: listHeight * 0.02, // 2% of list height
            ),
            child: ListTile(
              title: Text(
                "${user.username ?? "No Name"}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: listHeight * 0.03, // Adjust based on list height
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
                    style: TextStyle(
                      fontSize:
                          listHeight * 0.02, // Adjust based on list height
                    ),
                  ),
                  Text(
                    "${user.date ?? "No Date"}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize:
                          listHeight * 0.02, // Adjust based on list height
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
                      fontSize:
                          listHeight * 0.02, // Adjust based on list height
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCommission()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
