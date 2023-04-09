import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/resource/resources.dart';
import 'package:birsu/feature/conversations/logic/conversations.dart';
import 'package:birsu/feature/conversations/view/conversation_item.dart';
import 'package:birsu/feature/drawer/view/drawer_page.dart';
import 'package:birsu/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class ConversationsPage extends ConsumerWidget {
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(conversationsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          context.loc.chats,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  Icons.menu_outlined,
                  size: 25.r,
                ),
              ).paddingOnly(right: 10.w);
            },
          )
        ],
      ),
      endDrawer: const DrawerPage(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            foregroundDecoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.4),
            ),
            child: Lottie.asset(
              AppLotties.ltLightBackground,
              frameRate: FrameRate.max,
              repeat: true,
              animate: true,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: conversations.when(
              data: (data) {
                final docSnapshot = data.docs;
                if (docSnapshot.isNotEmpty) {
                  return Material(
                    color: Colors.transparent,
                    child: ListView.separated(
                      itemCount: docSnapshot.length,
                      itemBuilder: (context, index) {
                        final item = docSnapshot[index];
                        final conversation = Conversation.fromFirestore(item);
                        return ConversationItem(conversation: conversation);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider()
                            .paddingSymmetric(horizontal: 10.w);
                      },
                    ),
                  );
                } else {
                  return Text(
                    context.loc.conversationsEmptyInfo,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).center;
                }
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Center(
                child: Text(error.toString()),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.router.push(const UsersRoute());
        },
        label: Text(context.loc.newChat),
        icon: const Icon(Icons.message_outlined),
      ),
    );
  }
}
