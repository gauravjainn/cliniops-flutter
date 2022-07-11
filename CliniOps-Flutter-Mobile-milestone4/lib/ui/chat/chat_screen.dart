import 'package:clini_app/controllers/study/study_notifier.dart';
import 'package:clini_app/data/constants/constants.dart';
import 'package:clini_app/data/models/chat/message.dart';
import 'package:clini_app/data/models/open_video.dart';
import 'package:clini_app/repositories/study_repo.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/chat/call_widget.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  ScrollController scrollController = ScrollController();
  String messagePath = '';
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
     await _initChat();
      ref.child(messagePath).onChildChanged.listen((event) {
      print(event.type);

      if (mounted) setState(() {});
    });
    });

   
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          orientation == Orientation.landscape
              ? Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your site administrator: ${AppEnvironment.user?.profileDetails?.registeredBy ?? 'NA'}',
                        textAlign: TextAlign.center,
                        style:
                            AppText.text18w400Black.copyWith(fontSize: 16.sp),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconTextItem(Images.emailIcon, 'support@cliniops.com',
                              () {
                            CommonUtils.launchURL(
                                'mailto:support@cliniops.com?subject=&body=');
                          }),
                          sizedBoxWithWidth(12),
                          iconTextItem(Images.callIcon, '+91 65059 89657', () {
                            CommonUtils.launchURL('tel:+916505989657');
                          }),
                          sizedBoxWithWidth(12),
                          iconTextItem(Images.videoIcon, 'slee@abc.com',
                              () async {
                            try {
                              if (AppEnvironment.user?.profileDetails
                                          ?.subjectUserId !=
                                      null &&
                                  AppEnvironment
                                          .user?.profileDetails?.subjectID !=
                                      null) {
                                final notifier = context.read<StudyNotifier>();
                                context.showLoadingIndicator();
                                final value = await notifier.getOpenTekConfig(
                                    userId: AppEnvironment.user?.profileDetails
                                            ?.subjectUserId ??
                                        'NA',
                                    entityId:
                                        AppEnvironment.user?.subjectId ?? 'NA');
                                context.removeLoadingIndicator();

                                if (value.isSuccess) {
                                  if (value.data != null) {
                                    AppEnvironment.navigator
                                        .push(MaterialPageRoute(
                                            builder: (_) => CallWidget(
                                                  config: value.data,
                                                  title: '',
                                                )));
                                  }
                                } else {
                                  context.showErrorSnackBar(
                                      'Unable to connect from server.Please contact to customer support',
                                      actionTitle: 'Error');
                                }
                              } else {
                                context.showErrorSnackBar(
                                    'Unable to perform action.Please re-login and truy again',
                                    actionTitle: 'Error');
                              }
                            } catch (e) {
                              context.showErrorSnackBar(e.toString(),
                                  actionTitle: 'Error');
                            } finally {
                              // context.removeLoadingIndicator();
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                )
              : Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(5.w),
                    child: ListView(
                      children: [
                        Text(
                          'Your site administrator: ${AppEnvironment.user?.profileDetails?.registeredBy ?? 'NA'}',
                          textAlign: TextAlign.center,
                          style:
                              AppText.text18w400Black.copyWith(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iconTextItem(
                                Images.emailIcon, 'support@cliniops.com', () {
                              CommonUtils.launchURL(
                                  'mailto:support@cliniops.com?subject=&body=');
                            }),
                            sizedBoxWithWidth(36),
                            iconTextItem(Images.callIcon, '+91 65059 89657',
                                () {
                              CommonUtils.launchURL('tel:+916505989657');
                            }),
                            sizedBoxWithWidth(36),
                            iconTextItem(Images.videoIcon, 'slee@abc.com',
                                () async {
                              try {
                                if (AppEnvironment.user?.profileDetails
                                            ?.subjectUserId !=
                                        null &&
                                    AppEnvironment
                                            .user?.profileDetails?.subjectID !=
                                        null) {
                                  final notifier =
                                      context.read<StudyNotifier>();
                                  context.showLoadingIndicator();
                                  final value = await notifier.getOpenTekConfig(
                                      userId: AppEnvironment.user
                                              ?.profileDetails?.subjectUserId ??
                                          'NA',
                                      entityId:
                                          AppEnvironment.user?.subjectId ??
                                              'NA');
                                  context.removeLoadingIndicator();

                                  if (value.isSuccess) {
                                    if (value.data != null) {
                                      AppEnvironment.navigator
                                          .push(MaterialPageRoute(
                                              builder: (_) => CallWidget(
                                                    config: value.data,
                                                    title: '',
                                                  )));
                                    }
                                  } else {
                                    context.showErrorSnackBar(
                                        'Unable to connect from server.Please contact to customer support',
                                        actionTitle: 'Error');
                                  }
                                } else {
                                  context.showErrorSnackBar(
                                      'Unable to perform action.Please re-login and truy again',
                                      actionTitle: 'Error');
                                }
                              } catch (e) {
                                context.showErrorSnackBar(e.toString(),
                                    actionTitle: 'Error');
                              } finally {
                                // context.removeLoadingIndicator();
                              }
                            }),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  )),
          Expanded(
              flex: 8,
              child: StreamBuilder<DatabaseEvent>(
                  stream: FirebaseDatabase.instance
                      .ref(
                          'chat/${AppEnvironment.user?.profileDetails?.username ?? "NA"}/Messages')
                      .onValue,
                  builder: (context, _) {
                    // ignore: unnecessary_null_comparison
                    if (_ == null ||!_.hasData) {
                      return Text(
                              'No Chat Found',
                              style: AppText.text14w400Black,
                            );
                    }
                    return StreamBuilder<DataSnapshot>(
                        stream: FirebaseDatabase.instance
                            .ref(
                                'chat/${AppEnvironment.user?.profileDetails?.username ?? "NA"}/Messages')
                            .get()
                            .asStream(),
                        builder: (context, snapshot) {
                          if (snapshot.data?.value == null) {
                            return Text(
                              'No Chat Found',
                              style: AppText.text14w400Black,
                            );
                          }

                          var messages = snapshot.data?.children.toList() ?? [];
                          if (messages.length != 0) {
                            _scrollDown();
                          }
                          return ListView.builder(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              Message? data = Message.fromJson(
                                  messages[index].value as Map);
                              return MessageTile(
                                message: data.message,
                                sendByMe: data.sendByUser ?? false,
                                time: DateFormat('MMM dd, hh:mm a').format(
                                    parseDateTime(data.date) ?? DateTime.now()),
                              );
                            },
                            itemCount: messages.length,
                          );
                        });
                  })),
          Container(
            height: orientation == Orientation.landscape ? 38.h : 48.h,
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.r),
              border: Border.all(color: Colors.grey, width: 2.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    height: 45.h,
                    child: Center(
                      child: TextField(
                        onSubmitted: (value) {
                          onSendMessage(controller.text);
                        },
                        controller: controller,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Send your message...',
                          hintStyle: AppText.text16w400Grey,
                        ),
                      ),
                    ),
                  ),
                ),

                // Button send message
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => onSendMessage(controller.text),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Future<void> _initChat() async {
    messagePath =
        'chat/${AppEnvironment.user?.profileDetails?.username ?? "NA"}/Messages';

    ref
        .child(
            'chat/${AppEnvironment.user?.profileDetails?.username ?? "NA"}/userData')
        .set(AppEnvironment.user?.profileDetails?.toJson() ?? {});
    await ref.child(messagePath).get().then((value) => {
          if (value.children.isNotEmpty) {setState(() {})}
        });
    // await Future.delayed(Duration(seconds: 2));
    _scrollDown();
  }

  void _scrollDown() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  Widget iconTextItem(String? icon, String? title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.all(8.w),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.appPrimary),
            borderRadius: BorderRadius.circular(26.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon ?? Images.callIcon,
              height: 21.h,
              width: 21.h,
              color: AppColors.appPrimary,
            ),
            // sizedBoxWithWidth(12),
            // Text(
            //   title ?? 'NA',
            //   style: AppText.text14w400Black
            //       .copyWith(fontSize: 14.sp, color: AppColors.appPrimary),
            // )
          ],
        ),
      ),
    );
  }

  onSendMessage(String text) {
    FocusScope.of(context).requestFocus(FocusNode());

    controller.clear();
    if (text.trim().isEmpty) {
      return;
    }
    if (AppEnvironment.user == null) {
      context
          .showErrorSnackBar('Unable to send the message please kogin again');
      return;
    }
    ref
        .child(
            'chat/${AppEnvironment.user?.profileDetails?.username ?? "NA"}/Messages')
        .push()
        .set({
      'message': text,
      'date': DateTime.now().toString(),
      'sendByUser': true
    }).whenComplete(() => setState(() {}));

    _scrollDown();
  }
}

class MessageTile extends StatelessWidget {
  final String? message;
  final bool sendByMe;
  final String? time;

  const MessageTile(
      {required this.message, required this.sendByMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 8.h,
              bottom: 0,
              left: sendByMe ? 0 : 12.w,
              right: sendByMe ? 12.w : 0),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: sendByMe
                ? EdgeInsets.only(left: 60.w)
                : EdgeInsets.only(right: 60.w),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            decoration: BoxDecoration(
                borderRadius: sendByMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomLeft: Radius.circular(23))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomRight: Radius.circular(23)),
                gradient: LinearGradient(
                  colors: sendByMe
                      ? [const Color(0xff39BDF8), const Color(0xff03A9F4)]
                      : [
                          const Color(0x0ffDEDDE2),
                          const Color(0xC3C3C3C3),
                        ],
                )),
            child: Column(
              children: [
                Text(message ?? "",
                    textAlign: TextAlign.start,
                    style: AppText.text18w400White.copyWith(
                        color: sendByMe ? Colors.white : Colors.black,
                        fontSize: 14.sp)),
              ],
            ),
          ),
        ),
        Align(
            alignment: sendByMe ? Alignment.topRight : Alignment.topLeft,
            child: Padding(
              padding: sendByMe
                  ? EdgeInsets.only(right: 12.w)
                  : EdgeInsets.only(left: 12.w),
              child: Text(
                '$time',
                style: AppText.text12w400Grey,
              ),
            ))
      ],
    );
  }
}
