// ignore_for_file: file_names

import 'package:final_project/Cubits/home_cubit.dart';
import 'package:final_project/Cubits/home_state.dart';
import 'package:final_project/item_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is HomeLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Course categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (context.read<HomeCubit>().categorise.isEmpty)
                    const Center(
                      child: Text('No Data'),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: context.read<HomeCubit>().categorise.length,
                        itemBuilder: (context, index) {
                          return ItemWidget(
                            image: context
                                .read<HomeCubit>()
                                .categorise[index]
                                .image!,
                            name: context
                                .read<HomeCubit>()
                                .categorise[index]
                                .name,
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}