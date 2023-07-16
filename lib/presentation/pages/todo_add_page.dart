import 'package:flutter/material.dart';
import 'package:todotxt/constants/screen.dart';
import 'package:todotxt/presentation/widgets/app_bar.dart';

class TodoAddPage extends StatelessWidget {
  const TodoAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < maxScreenWidthCompact) {
      return _buildNarrowLayout(context);
    } else {
      return _buildWideLayout(context);
    }
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(showToolBar: false),
      body: Center(
        child: Text('Adding todo'),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Adding todo'),
      ),
    );
  }
}
