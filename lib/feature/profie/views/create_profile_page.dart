import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/create_profile_page_2.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/detail_profile_company_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/update_company_profile_screen.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class CreateProfilePage extends StatefulWidget {
  CreateProfilePage(
    {
      super.key,
      required this.role
    });

  String role;
  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  String? selectedTeckStackId = null;
  List<String> _selectedSkillset = [];
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"), value: "USA"),
    DropdownMenuItem(child: Text("Canada"), value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
    DropdownMenuItem(child: Text("England"), value: "England"),
  ];

  List<MultiSelectItem<String>>? selectedSkillSetList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.wait([context.read<ProfileProvider>().getAllSkillSet(), context.read<ProfileProvider>().getAllTechStack()]);
  }

  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet<String>(
          listType: MultiSelectListType.CHIP,
          items: context.watch<ProfileProvider>().profileRepository.skillSetList?.map(
            (e) => MultiSelectItem(e['id'].toString(), e['name'].toString()),
          ).toList() ?? [],
          initialValue: _selectedSkillset,
          onConfirm: (values) {
            final skillSetList = context.read<ProfileProvider>().profileRepository.skillSetList;
            setState(() {
              _selectedSkillset = values;
              selectedSkillSetList = [];
              values.forEach(( selectedElement) {
                skillSetList?.forEach((skillSet) {
                  if (skillSet['id'] ==int.parse(selectedElement)){
                    selectedSkillSetList?.add(MultiSelectItem(skillSet['id'].toString(), skillSet['name']));
                  }
                });
               });
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
  
    return widget.role == "student" ? BasicPage(
        child: Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Welcome to Student Hub",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Align(
                child: Text(
                  "Tell us about your self and you will be on your way connect with real-world project",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Techstack",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField(
                        isExpanded: true,
                        menuMaxHeight: 300,
                        alignment: Alignment.center,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) =>
                            value == null ? "Select a country" : null,
                        dropdownColor: Colors.white,
                        value: selectedTeckStackId,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTeckStackId = newValue!;
                          });
                        },
                        items: context
                            .watch<ProfileProvider>()
                            .profileRepository
                            .techStackList
                            ?.map(
                          (e) {
                            return DropdownMenuItem(
                                child: Text(e['name'].toString()),
                                value: e['id'].toString());
                          },
                        ).toList())
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Skillset",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _showMultiSelect(context);
                        },
                        child: Text("Choose skillset")),
                    MultiSelectChipDisplay(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      items: selectedSkillSetList,
                      onTap: (value) {
                        setState(() {
                          _selectedSkillset.remove(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
              //Languages
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Languages"),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.add)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit))
                            ],
                          ),
                        )
                      ],
                    ),
                    //data of language
                    Column(
                      children: [],
                    )
                  ],
                ),
              ),
              //Education
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Education"),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.add)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit))
                            ],
                          ),
                        )
                      ],
                    ),
                    //data of education
                    Column(
                      children: [],
                    )
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                child: (selectedTeckStackId != null && _selectedSkillset.isNotEmpty)
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateProfilePage2(
                              skillSets: _selectedSkillset,
                              techStackId: selectedTeckStackId!,
                            ),
                          ));
                        },
                        child: Text("Next"))
                    : null,
              ),
            ],
          ),
        ),
      ),
    )): UpdateCompanyProfileScreen(
      titleButton: "Create company profile",
      
    );
  }
}
