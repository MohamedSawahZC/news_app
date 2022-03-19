import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/shared/cubit/cubit.dart';
import 'package:new_app/shared/cubit/states.dart';

import '../../shared/components.dart';

class SearchScreen extends StatelessWidget {
var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit = NewsCubit.get(context);
        var list = cubit.search;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: defaultFormField(
                    controller: searchController,
                    label: 'Search',
                    type: TextInputType.text,
                    prefix: Icons.search,
                    onChange: (value){
                      cubit.getSearch(value);
                    },
                    validate: (String? value){
                      if(value!.isEmpty){
                        return 'Search must not be empty';
                      }
                      return null;
                    }
                ),
              ),
              articleBuilder(list: list ,cubit: cubit,length: cubit.search.length),
            ],
          ),
        );
      },
    );
  }
}
