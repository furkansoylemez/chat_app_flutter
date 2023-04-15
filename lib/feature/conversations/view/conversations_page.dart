import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/resource/resources.dart';
import 'package:birsu/feature/conversations/logic/conversations.dart';
import 'package:birsu/feature/conversations/view/conversation_item.dart';
import 'package:birsu/feature/drawer/view/drawer_page.dart';
import 'package:birsu/model/conversation.dart';
import 'package:birsu/provider/app_theme_mode.dart';
import 'package:birsu/provider/chat_socket.dart';
import 'package:birsu/widgets/common_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ConversationsPage extends ConsumerStatefulWidget {
  const ConversationsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConversationsPageState();
}

class _ConversationsPageState extends ConsumerState<ConversationsPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _handleAppGoesToBackground();
    } else if (state == AppLifecycleState.resumed) {
      _handleAppComesToForeground();
    }
  }

  void _handleAppGoesToBackground() {
    ref.read(chatSocketProvider.notifier).sendOfflineEvent();
  }

  void _handleAppComesToForeground() {
    ref.read(chatSocketProvider.notifier).sendOnlineEvent();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    ref.watch(chatSocketProvider);
    final conversations = ref.watch(conversationsProvider);
    final appThemeMode = ref.watch(appThemeModeProvider);

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
            height: screenSize.height,
            width: screenSize.width,
            foregroundDecoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.4),
            ),
            child: CommonLottie(
              appThemeMode == ThemeMode.light
                  ? AppLotties.ltLightBackground
                  : AppLotties.ltDarkBackground,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: conversations.when(
              data: (data) {
                final conversationList = data.docs;
                if (conversationList.isNotEmpty) {
                  return Material(
                    color: Colors.transparent,
                    child: ListView.separated(
                      itemCount: conversationList.length,
                      itemBuilder: (context, index) {
                        final item = conversationList[index];
                        return ConversationItem(
                          conversation: Conversation.fromDocument(item),
                        );
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
              loading: () => const CircularProgressIndicator().center,
              error: (error, _) => Text(error.toString()).center,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _navigateToUsersRoute(context);
        },
        label: Text(context.loc.newChat),
        icon: const Icon(Icons.message_outlined),
      ),
    );
  }

  void _navigateToUsersRoute(BuildContext context) {
    context.router.push(const UsersRoute());
  }
}
