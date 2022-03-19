import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/shared/cubit/cubit.dart';

import '../../shared/components.dart';
import '../../shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    var cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = cubit.sports;
        return articleBuilder(list: list, cubit: cubit,length: cubit.sports.length);
      },
    );
  }
}
