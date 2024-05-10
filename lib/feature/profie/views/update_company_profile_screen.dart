import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/feature/intro/views/intro_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/company_profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/profile_screen.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class UpdateCompanyProfileScreen extends StatefulWidget {
  Company? company;
  String titleButton;

  UpdateCompanyProfileScreen(
      {Key? key, required this.company, required this.titleButton});

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

  ProfileProvider profileProvider = ProfileProvider();

  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      _employeesController = TextEditingController(
          text: widget.company!.numberOfEmployees.toString());
      _nameController = TextEditingController(text: widget.company!.name);
      _websiteController = TextEditingController(text: widget.company!.website);
      _descriptionController =
          TextEditingController(text: widget.company!.description);
      selectedCompanySize = widget.company!.numberOfEmployees;
    }
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
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(
                onPressed: () async {
                  await context.read<AuthenticateProvider>().signOut(
                      token: context
                          .read<AuthenticateProvider>()
                          .authenRepository
                          .token!);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) {
                        return IntroPage();
                      },
                    ),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.arrow_forward)),
          )
        ],
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
                    Text(
                      Languages.of(context)!.updateCompany,
                      style: AppTextStyles.headerStyle,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      Languages.of(context)!.updateCompanyDescription,
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
                    _buildInputField(
                        Languages.of(context)!.name, _nameController),
                    _buildInputField(
                        Languages.of(context)!.address, _addressController),
                    _buildInputField(
                        Languages.of(context)!.website, _websiteController),
                    _buildInputField(Languages.of(context)!.description,
                        _descriptionController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (widget.company != null) {
                          print("======1l");
                          _updateCompanyInfo();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false);
                        } else {
                          await context
                              .read<ProfileProvider>()
                              .createProfieForCompany(
                                  companyName: _nameController.text.trim(),
                                  size: selectedCompanySize,
                                  website: _websiteController.text.trim(),
                                  description:
                                      _descriptionController.text.trim(),
                                  token: context
                                      .read<AuthenticateProvider>()
                                      .authenRepository
                                      .token!);

                          if (context.read<ProfileProvider>().status ==
                              AuthResult.success) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                                (route) => false);
                          } else {
                            await QuickAlert.show(
                                context: context, type: QuickAlertType.error);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: Text(
                        widget.titleButton,
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
        _websiteController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      // Show error dialog when any field is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(Languages.of(context)!.errorMissingField),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(Languages.of(context)!.oke),
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

      print("===============");
      if (widget.company != null) {
        print("heehe");
        profileProvider
            .updateProfileCompany(companyId: widget.company!.id!, data: {
          'name': companyName,
          'website': website,
          'description': description,
          'size': selectedCompanySize,
        });
      }
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
