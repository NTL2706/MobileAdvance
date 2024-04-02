import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:flutter/cupertino.dart';

class JobNotifier extends ChangeNotifier {
  List<JobModel> jobList = [
    JobModel(
      id: 1,
      HiredNumber: 0,
      createAt: "Create 3 days ago",
      discription: "Clear expectation about your project or deliverables",
      messagesNumber: 8,
      numberStudent: 0,
      proposalNumber: 2,
      title: "Senior frontend developer (Fintech)",
    ),
    JobModel(
      id: 2,
      HiredNumber: 0,
      createAt: "Create 3 days ago",
      discription: "Clear expectation about your project or deliverables",
      messagesNumber: 8,
      numberStudent: 0,
      proposalNumber: 2,
      title: "Senior frontend developer (Fintech)",
    ),
    JobModel(
      id: 3,
      HiredNumber: 0,
      createAt: "Create 3 days ago",
      discription: "Clear expectation about your project or deliverables",
      messagesNumber: 8,
      numberStudent: 0,
      proposalNumber: 2,
      title: "Senior frontend developer (Fintech)",
    ),
    JobModel(
      id: 4,
      HiredNumber: 0,
      createAt: "Create 3 days ago",
      discription: "Clear expectation about your project or deliverables",
      messagesNumber: 8,
      numberStudent: 0,
      proposalNumber: 2,
      title: "Senior frontend developer (Fintech)",
    ),
    JobModel(
      id: 5,
      HiredNumber: 0,
      createAt: "Create 3 days ago",
      discription: "Clear expectation about your project or deliverables",
      messagesNumber: 8,
      numberStudent: 0,
      proposalNumber: 2,
      title: "Senior frontend developer (Fintech)",
    ),
    JobModel(
      id: 6,
      HiredNumber: 0,
      createAt: "Create 3 days ago",
      discription: "Clear expectation about your project or deliverables",
      messagesNumber: 8,
      numberStudent: 0,
      proposalNumber: 2,
      title: "Senior frontend developer (Fintech)",
    ),
    JobModel(
      id: 7,
      HiredNumber: 0,
      createAt: "Create 3 days ago",
      discription: "Clear expectation about your project or deliverables",
      messagesNumber: 8,
      numberStudent: 0,
      proposalNumber: 2,
      title: "Senior frontend developer (Fintech)",
    ),
    JobModel(
      id: 8,
      HiredNumber: 0,
      createAt: "Create 3 days ago",
      discription: "Clear expectation about your project or deliverables",
      messagesNumber: 8,
      numberStudent: 0,
      proposalNumber: 2,
      title: "Senior frontend developer (Fintech)",
    ),
  ];

  void addJob({required String title,required String discription, required int numberStudent, int hiredNumber = 0, int messagesNumber = 0, int proposalNumber = 0 }){
    jobList.add(JobModel(
      id: jobList.length + 1,
      HiredNumber: hiredNumber,
      createAt: "Create 3 days ago",
      discription: discription,
      messagesNumber: messagesNumber,
      numberStudent: numberStudent,
      proposalNumber: proposalNumber,
      title: title
    ));
    notifyListeners();
  }

  void deleteJob({required int id}){
    jobList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateJob(
    {
      required int id,
      String? title,
      String? createAt,
      int? numberStudent,
      String? discription,
      int? proposalNumber,
      int? messagesNumber,
      int? HiredNumber,
      String? state,
    }){
    JobModel job = jobList.firstWhere((element) => element.id == id);
    job.updateJob(state: state);
    notifyListeners();
  }
}
