import 'package:fca_education_app/%20core/common/app/providers/tab_navigatore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersistentView extends StatefulWidget {
  const PersistentView({this.body, super.key});

  final Widget? body;

  @override
  State<PersistentView> createState() => _PersistentViewState();
}

class _PersistentViewState extends State<PersistentView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  @override
  bool get wantKeepAlive => true;
}
