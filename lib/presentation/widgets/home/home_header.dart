import 'package:e_commerce/presentation/data/home_mock_data.dart';
import 'package:e_commerce/presentation/widgets/home/home_header_clipper.dart';
import 'package:e_commerce/presentation/widgets/home/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final VoidCallback? onNotificationTap;

  const HomeHeader({
    super.key,
    this.userName = kHomeUserName,
    this.avatarUrl = kHomeUserAvatar,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final headerBg = scheme.surfaceContainerHighest;
    final headerFg = scheme.onInverseSurface;

    return SizedBox(
      height: HomeLayout.headerHeight + 36,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          ClipPath(
            clipper: HomeHeaderClipper(),
            child: Container(
              width: double.infinity,
              height: HomeLayout.headerHeight,
              color: headerBg,
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 12,
                left: HomeLayout.horizontalPadding,
                right: HomeLayout.horizontalPadding,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(avatarUrl),
                    onBackgroundImageError: (_, __) {},
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: headerFg.withValues(alpha: 0.85),
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: headerFg,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onNotificationTap,
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.notifications_none_outlined,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: HomeLayout.horizontalPadding,
            right: HomeLayout.horizontalPadding,
            bottom: 0,
            child: const SearchBarWidget(),
          ),
        ],
      ),
    );
  }
}
