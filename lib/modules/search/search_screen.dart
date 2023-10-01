import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  SearchScreen({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder:(context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,

                  onChange: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                    NewsCubit.get(context).getSearch(value: value);
                  },

                  validate:(value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  labelText: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(child: ArticalBuilder(list, context,),),
            ],
          ),
        );
      } ,
    );
  }
}
