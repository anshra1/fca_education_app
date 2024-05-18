part of 'material_cubit.dart';

abstract class MaterialStates extends Equatable {
  const MaterialStates();
  @override
  List<Object> get props => [];
}

class MaterialInitial extends MaterialStates {
  const MaterialInitial();
}

class AddingMaterials extends MaterialStates {
  const AddingMaterials();
}

class LoadingMaterials extends MaterialStates {
  const LoadingMaterials();
}

class MaterialsAdded extends MaterialStates {
  const MaterialsAdded();
}

class MaterialsLoaded extends MaterialStates {
  const MaterialsLoaded(this.materials);

  final List<Resource> materials;

  @override
  List<Object> get props => [materials];
}

class MaterialError extends MaterialStates {
  const MaterialError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
