import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/test.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class DetailProfileStudentScreen extends StatefulWidget {
  const DetailProfileStudentScreen({super.key});

  @override
  State<DetailProfileStudentScreen> createState() =>
      _DetailProfileStudentScreenState();
}

class _DetailProfileStudentScreenState
    extends State<DetailProfileStudentScreen> {
  final TextEditingController _controller =
      TextEditingController(text: 'DevOps');

  String? selectedExpertise = 'Fullstack Engineer';

  List<String> skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'UI/UX Design',
    'Backend Development',
    'Frontend Development',
    'Mobile Development',
    'Web Development',
    'Database Management'
  ];

  List<String> selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    final studentId =
        context.read<AuthenticateProvider>().authenRepository.student?['id'];
    final token = context.read<AuthenticateProvider>().authenRepository.token;
   
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: Future.wait([
            context.read<ProfileProvider>().getProfileStudent(studentId: studentId, token: token!),
            context.read<ProfileProvider>().getAllSkillSet(),
            context.read<ProfileProvider>().getAllTechStack(),

          ]),
          builder: (context, snapshot) {
            final getSkillSet = context.read<ProfileProvider>().studentProfile?['skillSets'];
            String teckStack = context.read<ProfileProvider>().studentProfile?['techStack']['name'];
            List<Map<String,dynamic>> allOfTechStack = context.read<ProfileProvider>().profileRepository.techStackList!;
            List<Map<String,dynamic>> allOfSkillSets = context.read<ProfileProvider>().profileRepository.techStackList!;
            List<MultiSelectItem<String>> skillSetList =
                List<Map<String, dynamic>>.from(getSkillSet).map(
              (e) {
                return MultiSelectItem<String>(e['id'].toString(), e['name']);
              },
            ).toList();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            return Column(
              children: [
                _appDetailProfileBar(), 
                detailProfile(
                  skillSetList: skillSetList,
                  teckStack: teckStack,
                  allOfTechStack: allOfTechStack,
                )],
            );
          }),
    );
  }

  Widget _appDetailProfileBar() {
    final fullname =
        context.read<ProfileProvider>().studentProfile?['fullname'];
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 40,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullname,
                style: AppTextStyles.headerStyle,
              ),
              Text("HCMUS", style: AppTextStyles.bodyStyle),
              Text("Student", style: AppTextStyles.bodyStyle),
            ],
          ),
        ],
      ),
    );
  }

}

class detailProfile extends StatefulWidget{
  
   detailProfile(
    {
      super.key,
      required this.teckStack,
      required this.skillSetList,
      required this.allOfTechStack
    });
  String teckStack;
  List<MultiSelectItem<String>> skillSetList;
  List<Map<String,dynamic>> allOfTechStack;
  @override
  State<detailProfile> createState() => _detailProfileState();
}

class _detailProfileState extends State<detailProfile> {
  List<String> _selectedSkillset = [];
  void _showMultiSelect(BuildContext context,List<MultiSelectItem<String>> selectedSkillSetList) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet<String>(
          listType: MultiSelectListType.CHIP,
          items: context.read<ProfileProvider>().profileRepository.skillSetList?.map(
            (e) => MultiSelectItem(e['id'].toString(), e['name'].toString()),
          ).toList() ?? [],
          initialValue: _selectedSkillset,
          onConfirm: (values) {
            final skillSetList = context.read<ProfileProvider>().profileRepository.skillSetList;
            print(values);
            setState(() {
              widget.skillSetList = [];
              values.forEach((element) {

              });
              values.forEach(( selectedElement) {
                skillSetList?.forEach((skillSet) {
                  if (skillSet['id'] == int.parse(selectedElement)){
                    widget.skillSetList.add(MultiSelectItem(skillSet['id'].toString(), skillSet['name']));
                    print(selectedSkillSetList);
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
    // TODO: implement build
    
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => const DetailProfileCompanyScreen(),
                    builder: (context) => SchoolListScreen(),
                  ),
                );
              },
              child: Text('Update'),
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tech stack",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      widget.teckStack,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                Consumer(
                  builder: (context, value, child) {
                    return PopupMenuButton<String>(
                      initialValue:  widget.teckStack,
                      onSelected: (String value) {
                        print(value);
                        final getTechStack = widget.allOfTechStack.where((element) => element['id'].toString() ==  value,).first;
                        print(getTechStack['name']);
                        setState(() {
                          widget.teckStack = getTechStack['name'];
                        });
                      },
                      itemBuilder: (context) {
                        return widget.allOfTechStack.map((e){
                          return PopupMenuItem<String>(
                            value: e['id'].toString(),
                            child: Text(e['name']));
                        }).toList();
                      },
                      icon: Icon(Icons.edit),
                    );
                  },
                )
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Skillsets",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(onPressed: ()async {
                      _showMultiSelect(context, widget.skillSetList);
                    }, icon: Icon(Icons.edit))
                  ],
                ),
                // Wrap widget to display selected skills
                MultiSelectChipDisplay(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  items: widget.skillSetList,
                  onTap: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}