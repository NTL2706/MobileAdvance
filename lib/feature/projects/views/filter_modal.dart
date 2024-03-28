import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/project_provider.dart';

class FilterModal extends StatelessWidget {
// Giá trị mặc định là chuỗi rỗng
  FilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    late ScrollController _scrollController;
    _scrollController = ScrollController();

    return SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Filter by Project Length:'),
              Column(
                children: [
                  RadioListTile<int>(
                    title: Text('All'),
                    value: 0,
                    groupValue: projectProvider.selectedProjectLength,
                    onChanged: (value) {
                      projectProvider.setSelectedProjectLength(value!);
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('1 to 3 months'),
                    value: 1,
                    groupValue: projectProvider.selectedProjectLength,
                    onChanged: (value) {
                      projectProvider.setSelectedProjectLength(value!);
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('4 to 6 months'),
                    value: 2,
                    groupValue: projectProvider.selectedProjectLength,
                    onChanged: (value) {
                      projectProvider.setSelectedProjectLength(value!);
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('More than 6 months'),
                    value: 3,
                    groupValue: projectProvider.selectedProjectLength,
                    onChanged: (value) {
                      projectProvider.setSelectedProjectLength(value!);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Enter Number of Students:'),
              TextField(
                onTap: () => {
                  SystemChannels.textInput
                      .invokeMethod('TextInput.show')
                      .then((_) {
                    // Khi bàn phím xuất hiện, cuộn xuống cuối của SingleChildScrollView
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  })
                },
                keyboardType: TextInputType.number,
                controller: projectProvider.numberOfStudentsController,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      projectProvider.filterSearch();
                    },
                    child: Text('Apply Filter'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      projectProvider.resetFilter();
                    },
                    child: Text('Clear Filter'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
