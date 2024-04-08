import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/chat_provider.dart';
import '../utils/convert_time.dart';

class MeetingScheduleBottomSheet extends StatelessWidget {
  final String? id;

  const MeetingScheduleBottomSheet({this.id});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    provider.handleLoadScheduleMeeting(id);

    return SingleChildScrollView(
        child: Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Schedule a meeting',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: provider.titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => provider.handleChangeStartTime(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                provider.startTimeController.text.isNotEmpty
                                    ? getDateTime(DateTime.parse(
                                        provider.startTimeController.text))
                                    : 'Pick date and time',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => provider.handleChangeEndTime(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                provider.endTimeController.text.isNotEmpty
                                    ? getDateTime(DateTime.parse(
                                        provider.endTimeController.text))
                                    : 'Pick date and time',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            id == null
                ? ElevatedButton(
                    onPressed: provider.titleController.text.isNotEmpty &&
                            provider.startTimeController.text.isNotEmpty &&
                            provider.endTimeController.text.isNotEmpty &&
                            DateTime.parse(provider.endTimeController.text)
                                .isAfter(DateTime.parse(
                                    provider.startTimeController.text))
                        ? () {
                            Navigator.pop(context);
                            provider.handleScheduleMeeting();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: provider
                                  .titleController.text.isNotEmpty &&
                              provider.startTimeController.text.isNotEmpty &&
                              provider.endTimeController.text.isNotEmpty &&
                              DateTime.parse(provider.endTimeController.text)
                                  .isAfter(DateTime.parse(
                                      provider.startTimeController.text))
                          ? Colors.blue
                          : const Color.fromARGB(69, 33, 149,
                              243), // Đặt màu nền là màu xanh dương
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Đặt borderRadius thành zero
                      ),
                    ),
                    child: Text(
                      'Schedule',
                      style: TextStyle(
                          color: Colors.white), // Đặt màu chữ là màu trắng
                    ),
                  )
                : ElevatedButton(
                    onPressed: provider.titleController.text.isNotEmpty &&
                            provider.startTimeController.text.isNotEmpty &&
                            provider.endTimeController.text.isNotEmpty &&
                            DateTime.parse(provider.endTimeController.text)
                                .isAfter(DateTime.parse(
                                    provider.startTimeController.text))
                        ? () {
                            Navigator.pop(context);
                            provider.updateScheduleMeeting(id!);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: provider
                                  .titleController.text.isNotEmpty &&
                              provider.startTimeController.text.isNotEmpty &&
                              provider.endTimeController.text.isNotEmpty &&
                              DateTime.parse(provider.endTimeController.text)
                                  .isAfter(DateTime.parse(
                                      provider.startTimeController.text))
                          ? Colors.blue
                          : const Color.fromARGB(69, 33, 149,
                              243), // Đặt màu nền là màu xanh dương
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Đặt borderRadius thành zero
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white), // Đặt màu chữ là màu trắng
                    ),
                  ),
          ],
        ),
      ),
    ));
  }
}
