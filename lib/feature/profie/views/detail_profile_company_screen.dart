import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/company_profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/update_company_profile_screen.dart';
import 'package:flutter/material.dart';

class DetailProfileCompanyScreen extends StatefulWidget {
  Profile? profile;

  DetailProfileCompanyScreen({super.key, required this.profile});

  @override
  State<DetailProfileCompanyScreen> createState() =>
      _DetailProfileCompanyScreenState();
}

class _DetailProfileCompanyScreenState
    extends State<DetailProfileCompanyScreen> {
  Company? company;

  TextEditingController _employeesController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    company = widget.profile!.company;
    _employeesController =
        TextEditingController(text: company!.numberOfEmployees.toString());
    _nameController = TextEditingController(text: company!.name);
    _websiteController = TextEditingController(text: company!.website);
    _descriptionController = TextEditingController(text: company!.description);
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
      ),
      body: Column(
        children: [_appDetailProfileBar(), _appDetailProfile()],
      ),
    );
  }

  Widget _appDetailProfileBar() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 40,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.profile!.name ?? "",
                style: AppTextStyles.headerStyle,
              ),
              const Text("Multinational company",
                  style: AppTextStyles.bodyStyle),
              const Text("Company", style: AppTextStyles.bodyStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appDetailProfile() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: AppColors.backgroundColor,
        ),
        child: ListView(
          children: [
            TextFormField(
              controller: _employeesController,
              enabled: false,
              decoration:
                  const InputDecoration(labelText: 'Number of Employees'),
            ),
            TextFormField(
              controller: _nameController,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Company Name'),
            ),
            TextFormField(
              controller: _addressController,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Company Address'),
            ),
            TextFormField(
              controller: _websiteController,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Website'),
            ),
            TextFormField(
              controller: _descriptionController,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                // TODO: Update company info
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateCompanyProfileScreen(
                      titleButton: "Update company profile",
                      company: company,
                    ),
                  ),
                );
              },
              child: const Text('Update Company Info',
                  style: AppTextStyles.buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
