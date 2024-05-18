import 'package:equatable/equatable.dart';
import 'package:fca_education_app/src/course/features/materials/domain/entity/resourse.dart';
import 'package:fca_education_app/src/course/features/materials/domain/usecases/add_material.dart';
import 'package:fca_education_app/src/course/features/materials/domain/usecases/get_material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialStates> {
  MaterialCubit({
    required AddMaterial addMaterial,
    required GetMaterials getMaterials,
  })  : _addMaterial = addMaterial,
        _getMaterials = getMaterials,
        super(const MaterialInitial());

  final AddMaterial _addMaterial;
  final GetMaterials _getMaterials;

  Future<void> addMaterials(List<Resource> materials) async {
    emit(const AddingMaterials());

    for (final material in materials) {
      final result = await _addMaterial(params: material);
      result.fold(
        (failure) {
          emit(MaterialError(failure.errorMessage));
          return;
        },
        (_) => null,
      );
    }
    if (state is! MaterialError) emit(const MaterialsAdded());
  }

  Future<void> getMaterials(String courseId) async {
    emit(const LoadingMaterials());
    final result = await _getMaterials(params: courseId);
    result.fold(
      (failure) => emit(MaterialError(failure.errorMessage)),
      (materials) => emit(MaterialsLoaded(materials)),
    );
  }
}
