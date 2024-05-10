import 'package:final_project_advanced_mobile/feature/chat/constants/chat_type.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/chat_provider.dart';
import '../utils/convert_time.dart';
import '../utils/generate_random_string.dart';

class MeetingScheduleBottomSheet extends StatelessWidget {
  final Interview? interview;
  final int sender;
  final int receiver;
  final int projectid;
  final SocketManager socketManager;

  const MeetingScheduleBottomSheet(
      {this.interview,
      required this.sender,
      required this.receiver,
      required this.projectid,
      required this.socketManager});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    context.read<ChatProvider>().handleLoadScheduleMeeting(interview);

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
              Languages.of(context)!.scheduleMeeting,
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
                        Languages.of(context)!.startTime,
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
                                    : Languages.of(context)!.pickDateAndTime,
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
                        Languages.of(context)!.endTime,
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
                                    : Languages.of(context)!.pickDateAndTime,
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
            interview == null
                ? ElevatedButton(
                    onPressed: provider.titleController.text.isNotEmpty &&
                            provider.startTimeController.text.isNotEmpty &&
                            provider.endTimeController.text.isNotEmpty &&
                            DateTime.parse(provider.endTimeController.text)
                                .isAfter(DateTime.parse(
                                    provider.startTimeController.text))
                        ? () {
                            socketManager.startSchedule(
                                title: context
                                    .read<ChatProvider>()
                                    .titleController
                                    .text,
                                startTime: context
                                    .read<ChatProvider>()
                                    .startTimeController
                                    .text,
                                endTime: context
                                    .read<ChatProvider>()
                                    .endTimeController
                                    .text,
                                projectId: projectid,
                                senderId: sender,
                                receiverId: receiver,
                                meeting_room_code: randomString(),
                                meeting_room_id: randomString());
                            Navigator.pop(context);
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
                      Languages.of(context)!.create,
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
                            socketManager.updateSchedule(
                              title: context
                                  .read<ChatProvider>()
                                  .titleController
                                  .text,
                              startTime: context
                                  .read<ChatProvider>()
                                  .startTimeController
                                  .text,
                              endTime: context
                                  .read<ChatProvider>()
                                  .endTimeController
                                  .text,
                              interviewId: interview!.id,
                            );
                            Navigator.pop(context);
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
                      Languages.of(context)!.update,
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
