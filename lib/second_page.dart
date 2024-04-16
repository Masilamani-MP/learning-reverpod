import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class Secondpage extends ConsumerStatefulWidget {
  const Secondpage({super.key});

  @override
  ConsumerState<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends ConsumerState<Secondpage> {
  @override
  Widget build(BuildContext context) {
    final address = ref.watch(addressProvider);
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(address.toString()),
        ),
      ),
    );
  }
}
