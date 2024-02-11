import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Cubits/home_state.dart';
import 'package:final_project/Data_models/category_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<CategoryDataModel> categorise = [];

  Future<void> getCategoriseFromDatabase() async {
    try {
      emit(HomeLoading());

      await FirebaseFirestore.instance
          .collection('categories')
          .get()
          .then((value) {
        for (var c in value.docs) {
          categorise.add(CategoryDataModel.fromDoc(c.data()));
        }
        emit(HomeLoaded());
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
