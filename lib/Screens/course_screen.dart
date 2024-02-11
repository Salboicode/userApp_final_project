import 'package:final_project/Cubits/category_cubit.dart';
import 'package:final_project/Cubits/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryCubit(categoryName)..getCoursesByCategoryName(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 114, 58, 124),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            categoryName,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is CategoryLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    if (context.read<CategoryCubit>().courses.isEmpty)
                      const Center(
                        child: Text('No Data'),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              context.read<CategoryCubit>().courses.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10) ,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 114, 58, 124),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                title: Text(
                                  context
                                      .read<CategoryCubit>()
                                      .courses[index]
                                      .name,
                                      style: const TextStyle(
                                        color: Colors.white
                                      ),
                                ),
                                subtitle: Text(
                                  context
                                      .read<CategoryCubit>()
                                      .courses[index]
                                      .description,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                ),
                              ),
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
      ),
    );
  }
}
