import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class CreateProfilePage2 extends StatefulWidget {
   CreateProfilePage2(
  {
    super.key,
    required this.skillSets,
    required this.techStackId
  });

  String techStackId;
  List<String>skillSets;

  @override
  State<CreateProfilePage2> createState() => _CreateProfilePage2State();
}

class _CreateProfilePage2State extends State<CreateProfilePage2> {
  List<int> _selectedSkillset = [];
  List<MultiSelectItem<int>> skillSetList = [
    MultiSelectItem(1, "A"),
    MultiSelectItem(2, "B"),
    MultiSelectItem(3, "C"),
    MultiSelectItem(4, "D"),
    MultiSelectItem(5, "E"),
    MultiSelectItem(6, "F"),
  ];

  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          listType: MultiSelectListType.CHIP,
          items: skillSetList,
          initialValue: _selectedSkillset,
          onConfirm: (values) {
            setState(() {
              print(values);
              _selectedSkillset = values;
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   
   
    return  BasicPage(
      floatingActionButton: IconButton(
        icon:Icon(Icons.arrow_forward) ,
        onPressed: () async{
          await context.read<ProfileProvider>().createProfieForStudent(
            token: context.read<AuthenticateProvider>().authenRepository.token!, 
            skillSets: widget.skillSets, 
            techStackId: widget.techStackId);


          if (context.read<ProfileProvider>().status == AuthResult.success){
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()
            ,), (route) => false);
          }else{
            await QuickAlert.show(
              context: context, 
              type: QuickAlertType.error);  
          }

          
        },
      ),
      child: Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Experiences",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tell us about your self and you will be on your way connect with real-world project",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                height: 500,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Projects',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.add))
                      ],
                    ),
                    //data of projects
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Intelligent Taxi Dispatching system"),
                                            Text("9/2020 - 12/2020, 4 months")
                                          ],
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.delete)),
                                          ],
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, .."),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _showMultiSelect(context);
                                    },
                                    child: Text("Choose skillset")),
                                MultiSelectChipDisplay(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  items: _selectedSkillset
                                      .map((e) => skillSetList[e - 1])
                                      .toList(),
                                  onTap: (value) {
                                    setState(() {
                                      _selectedSkillset.remove(value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    ));
  }
}
