// ignore_for_file: file_names, camel_case_types

import 'dart:async';
import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/all_imports.dart';

class Chat_Room extends StatefulWidget {
  const Chat_Room({super.key});

  @override
  State<Chat_Room> createState() => _Chat_RoomState();
}

class _Chat_RoomState extends State<Chat_Room> {
  TextEditingController massgController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Add this method in your _Chat_RoomState class
  void updateMessageTimestamps() {
    setState(() {
      for (var message in currentMessages) {
        message.timeUtil.updateTimes(message.time);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            buildText(
                color: AppColorText.black,
                text: "Customer support",
                fontWeight: FontWeight.w500,
                fontSize: 25.w),
            buildText(
                color: AppColorText.grey,
                text: "Ask any questions Online 24/7",
                fontWeight: FontWeight.w400,
                fontSize: 14.w),
          ],
        ),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {},
              child: ImageIcon(
                const AssetImage("assets/image/callImage.png"),
                color: AppColorBody.black,
              )),
          SizedBox(
            width: 30.w,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              // reverse: true,
              itemCount: currentMessages.length,
              itemBuilder: (context, index) {
                var item = currentMessages[index];
                TimeUtil timeUtil = item.timeUtil;
                String formattedTime = timeUtil.formatMessageTime();
                return index % 2 == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildText(
                              color: AppColorText.black,
                              text: formattedTime,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.w),
                          SizedBox(
                            height: 15.h,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Bubble(
                                margin: BubbleEdges.only(bottom: 15.h),
                                padding: BubbleEdges.symmetric(
                                    vertical: 16.w, horizontal: 10.w),
                                alignment: Alignment.topRight,
                                color: AppColorBody.blue,
                                child: item.messageType == 1
                                    ? Image.file(
                                        height: 200.h, File(item.message))
                                    : buildText(
                                        color: AppColorText.black,
                                        text: item.message,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.w)),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildText(
                              color: AppColorText.black,
                              text: formattedTime,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.w),
                          SizedBox(
                            height: 15.h,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Bubble(
                                margin: BubbleEdges.only(bottom: 15.h),
                                padding: BubbleEdges.symmetric(
                                    vertical: 16.w, horizontal: 10.w),
                                alignment: Alignment.topLeft,
                                child: item.messageType == 1
                                    ? SizedBox(
                                        height: 60.h,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: currentMessages.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w),
                                                child: Image.file(
                                                    height: 60.h,
                                                    File(item.message)),
                                              );
                                            }),
                                      )
                                    : buildText(
                                        color: AppColorText.black,
                                        text: item.message,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.w)),
                          ),
                        ],
                      );
              },
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: InkWell(
                        onTap: () {
                          uploadImage();
                        },
                        child: const Icon(Icons.camera_enhance_rounded)),
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      controller: massgController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(12),
                          hintText: "Messages.....",
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 50,
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            massgController.text.trim().isEmpty
                                ? null
                                : currentMessages.add(Message(
                                    messageType: 0,
                                    time: DateTime.now().millisecondsSinceEpoch,
                                    message: massgController.text
                                        .trimLeft()
                                        .trimRight(),
                                    isUser: true,
                                    timeUtil: TimeUtil(
                                        DateTime.now().millisecondsSinceEpoch),
                                  ));

                            massgController.clear();
                          });
                          updateMessageTimestamps();
                        },
                        child: const Icon(
                          Icons.send,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Message> currentMessages = [];
  List filList = [];

  Future uploadImage() async {
    final picker = ImagePicker();
    List<XFile> pickedFiles;

    pickedFiles = await picker.pickMultiImage();
    for (var pickedFile in pickedFiles) {
      File file = File(pickedFile.path);
      filList.add(file);
      setState(() {
        currentMessages.add(Message(
          messageType: 1,
          time: DateTime.now().millisecondsSinceEpoch,
          message: file.path,
          isUser: true,
          timeUtil: TimeUtil(DateTime.now().millisecondsSinceEpoch),
        ));
      });
    }
    updateMessageTimestamps();
  }
}

class Message {
  int messageType;
  int time;
  String message;
  bool isUser;
  TimeUtil timeUtil;

  Message({
    required this.messageType,
    required this.time,
    required this.message,
    required this.isUser,
    required this.timeUtil,
  });
}

class TimeUtil {
  late DateTime now;
  late DateTime messageTime;
  late Timer timer;

  TimeUtil(int timestamp) {
    updateTimes(timestamp);
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      updateTimes(timestamp);
    });
  }

  void updateTimes(int timestamp) {
    now = DateTime.now();
    messageTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  String formatMessageTime() {
    bool isCurrentYear = now.year == messageTime.year;

    return now.difference(messageTime).inDays == 0
        ? now.difference(messageTime).inHours < 1
            ? now.difference(messageTime).inMinutes < 1
                ? now.difference(messageTime).inSeconds < 30
                    ? 'just now'
                    : '${now.difference(messageTime).inSeconds} seconds ago'
                : '${now.difference(messageTime).inMinutes} minutes ago'
            : 'today, ${DateFormat('hh:mm a').format(messageTime)}'
        : now.difference(messageTime).inDays == 1
            ? 'yesterday, ${DateFormat('hh:mm a').format(messageTime)}'
            : isCurrentYear
                ? DateFormat('dd MMM, hh:mm a').format(messageTime)
                : DateFormat('dd MMM, yyyy hh:mm a').format(messageTime);
  }

  void dispose() {
    timer.cancel();
  }
}
