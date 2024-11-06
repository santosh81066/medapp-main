import 'package:flutter/material.dart';
import 'package:gomedserv/analytics/analytics.dart';
import 'package:gomedserv/booking_management/booking_management.dart';
import 'package:gomedserv/financial_management/manage_screen.dart';
import 'package:gomedserv/notification_screen.dart';
import 'package:gomedserv/service_management/manage_services.dart';
import 'package:gomedserv/settings_screen.dart';
import 'package:gomedserv/user_management/manageusers_screen.dart';
import 'package:gomedserv/vendor_management/vendor_list.dart';
import 'package:gomedserv/widgets/bottomnavigation.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(context, screenHeight),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        Text(
                          'Active',
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildButtonRow(context, screenWidth),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSearchBar(screenWidth),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSectionTitle('Key Metrics'),
                    _buildCard(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMetricRow('Total Number Of Users'),
                          _buildMetricRow('Active Vendors'),
                          _buildMetricRow('Available Services'),
                          _buildMetricRow('Bookings Today'),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildAlertsAndNotifications(screenWidth),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalyticsReportsScreen(),
                ),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageScreen(),
                ),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, double screenWidth) {
    final double buttonWidth = screenWidth * 0.2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSquareButton('Manage Users', context, buttonWidth),
        _buildSquareButton('Manage Services', context, buttonWidth),
        _buildSquareButton('Manage Bookings', context, buttonWidth),
        _buildSquareButton('Manage Vendors', context, buttonWidth),
      ],
    );
  }

  Widget _buildSquareButton(String title, BuildContext context, double width) {
    return GestureDetector(
      onTap: () {
        if (title == 'Manage Users') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageUsersScreen()),
          );
        } else if (title == 'Manage Services') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageServices()),
          );
        } else if (title == 'Manage Bookings') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingManagement()),
          );
        } else if (title == 'Manage Vendors') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VendorList()),
          );
        }
      },
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          color: const Color(0xFFD2F1E4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          suffixIcon: const Icon(
            Icons.search,
            size: 25,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget content}) {
    return Card(
      color: const Color(0xFFD2F1E4),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }

  Widget _buildMetricRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsAndNotifications(double screenWidth) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alerts and Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildCard(
          content: const Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Alerts and notifications content goes here...',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context, double screenHeight) {
    return Container(
      height: screenHeight * 0.1,
      decoration: const BoxDecoration(
        color: Color(0xFFD2F1E4),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenHeight * 0.070,
              height: screenHeight * 0.070,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/medapplogo.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
