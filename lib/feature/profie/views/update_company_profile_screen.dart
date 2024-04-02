import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpdateCompanyProfileScreen extends StatefulWidget {
  const UpdateCompanyProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateCompanyProfileScreen> createState() =>
      _UpdateCompanyProfileScreenState();
}

class _UpdateCompanyProfileScreenState
    extends State<UpdateCompanyProfileScreen> {
  TextEditingController _employeesController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  int selectedCompanySize = 10;

  @override
  void dispose() {
    _employeesController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> companySizes = [
      {"label": "10", "value": 10},
      {"label": "20", "value": 20},
      {"label": "> 100", "value": 100},
      {"label": "> 1000", "value": 1000},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Company Profile"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: AppColors.backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Update Company Information",
                      style: AppTextStyles.headerStyle,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Please provide updated information about your company in the fields below. Make sure to review the existing information before making changes.",
                      style: AppTextStyles.bodyStyle,
                    ),
                    const SizedBox(height: 16.0),
                    // View size of company
                    Column(
                      children: companySizes.map((item) {
                        return ListTile(
                          title: Text('${item['label']} employees'),
                          leading: Radio<int>(
                            value: item['value'],
                            groupValue: selectedCompanySize,
                            onChanged: (int? value) {
                              setState(() {
                                selectedCompanySize = value ?? 10;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    _buildInputField("Company name", _nameController),
                    _buildInputField("Address", _addressController),
                    _buildInputField("Website", _websiteController),
                    _buildInputField("Description", _descriptionController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle updating company information
                        _updateCompanyInfo();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: const Text(
                        'Update Company Info',
                        style: AppTextStyles.buttonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _updateCompanyInfo() {
    // Update company information
    if (_nameController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _websiteController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      // Show error dialog when any field is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      String companyName = _nameController.text;
      String address = _addressController.text;
      String website = _websiteController.text;
      String description = _descriptionController.text;

      // TODO: Call API to update company information
      print("Company name: $companyName");
      print("Address: $address");
      print("Website: $website");
      print("Description: $description");
      print("Number of employees: $selectedCompanySize");
      print("Update company information");
      Navigator.of(context).pop();
    }
  }
}
