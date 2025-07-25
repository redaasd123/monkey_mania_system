
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';


class SearchSchoolBuilder extends StatelessWidget {
  const SearchSchoolBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolCubit, SchoolState>(
      builder: (context, state) {
        if (state is SchoolSuccessState) {
          final schools = state.schools;
          return ListView.separated(
            itemBuilder: (context, index) {
              final school = schools[index];
              return ListTile(
                onTap: () {
                  final cubit = BlocProvider.of<SchoolCubit>(context);
                  cubit.selectSchool(school); // فقط هذا السطر
                },
                title: Text(school.name),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: schools.length,
          );
        } else if (state is SchoolLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SchoolFailureState) {
          return Center(child: Text('Error: ${state.errMessage}'));
        } else {
          return const SizedBox(); // Default empty
        }
      },
    );
  }
}
