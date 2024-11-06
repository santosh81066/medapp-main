import 'package:flutter/material.dart';
import 'package:gomedserv/widgets/topbar.dart';
import 'package:gomedserv/widgets/custom_button.dart';
import 'package:gomedserv/widgets/bottomnavigation.dart';
import 'package:intl/intl.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _selectedCategory;
  String? _selectedAvailability;
  DateTime? _selectedDate;

  final List<String> _categories = [
    'Orthopedic Surgery',
    'Pediatric Care',
    'Dermatology',
    'Orthopedic Surgery',
    'Gardening'
  ];

  @override
  Widget build(BuildContext context) {
    // Fetch the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Example scale factors for responsiveness
    double paddingScale = screenWidth * 0.04;
    double spacingScale = screenHeight * 0.02;
    double buttonHeight = screenHeight * 0.06;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                title: 'Add Service',
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: spacingScale), // Responsive spacing
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingScale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _serviceNameController,
                        decoration: InputDecoration(
                          labelText: 'Service Name',
                          hintText: 'Enter service name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF2A9D8F), width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF2A9D8F), width: 1.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a service name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: spacingScale),

                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Category',
                          hintText: 'Select a category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF2A9D8F), width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF2A9D8F), width: 1.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        value: _selectedCategory,
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: spacingScale),

                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter a description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF2A9D8F), width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF2A9D8F), width: 1.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: spacingScale),

                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          hintText: 'Enter service price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF2A9D8F), width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF2A9D8F), width: 1.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid price';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: spacingScale),
                      Text(
                        'Availability',
                        style: TextStyle(color: Color(0xFF2A9D8F)),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Everyday',
                            groupValue: _selectedAvailability,
                            onChanged: (value) {
                              setState(() {
                                _selectedAvailability = value;
                              });
                            },
                          ),
                          Text('Everyday'),
                          Radio<String>(
                            value: 'EveryWeek',
                            groupValue: _selectedAvailability,
                            onChanged: (value) {
                              setState(() {
                                _selectedAvailability = value;
                              });
                            },
                          ),
                          Text('EveryWeek'),
                          Radio<String>(
                            value: 'Weekends',
                            groupValue: _selectedAvailability,
                            onChanged: (value) {
                              setState(() {
                                _selectedAvailability = value;
                              });
                            },
                          ),
                          Text('Weekends'),
                          // Radio<String>(
                          //   value: 'Custom',
                          //   groupValue: _selectedAvailability,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _selectedAvailability = value;
                          //       _showDatePicker();
                          //     });
                          //   },
                          // ),
                          // Text('Custom'),
                        ],
                      ),
                      if (_selectedDate != null)
                        Text(
                          'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                        ),
                      SizedBox(height: spacingScale),
                      ElevatedButton(
                        onPressed: _showDatePicker,
                        child: Text('Select Date'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, buttonHeight),
                        ),
                      ),
                      SizedBox(
                          height: spacingScale *
                              1.5), // Larger spacing before the button
                      CustomButton(
                        text: 'Add Service',
                        color: const Color(0xFF2A9D8F),
                        screenWidth: screenWidth,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color(0xFF2A9D8F),
                                  title: Text(
                                    'Success',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: Text(
                                    'Service successfully added.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            // Add navigation logic if needed
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }
}
