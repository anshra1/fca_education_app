import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/core/common/views/loading_view.dart';
import 'package:fca_education_app/core/common/widgets/gradient_background.dart';
import 'package:fca_education_app/core/common/widgets/nested_back_button.dart';
import 'package:fca_education_app/core/common/widgets/not_found_text.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/app/cubit/material_cubit.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/app/providers/resource_controller.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/widgets/resource_tile.dart';
import 'package:flutter/material.dart' hide MaterialState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CourseMaterialsView extends StatefulWidget {
  const CourseMaterialsView(this.course, {super.key});

  static const routeName = '/course-materials';

  final Course course;

  @override
  State<CourseMaterialsView> createState() => _CourseMaterialsViewState();
}

class _CourseMaterialsViewState extends State<CourseMaterialsView> {
  void getMaterials() {
    context.read<MaterialCubit>().getMaterials(widget.course.id);
  }

  @override
  void initState() {
    super.initState();
    getMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${widget.course.title} Materials'),
        leading: const NestedBackButton(),
      ),
      body: GradientBackground(
        child: BlocConsumer<MaterialCubit, MaterialStates>(
          listener: (_, state) {
            if (state is MaterialError) {
              CoreUtils.showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is LoadingMaterials) {
              return const Loadingview();
            } else if ((state is MaterialsLoaded && state.materials.isEmpty) ||
                state is MaterialError) {
              return NotFoundText(
                text: 'No videos found for ${widget.course.title}',
              );
            } else if (state is MaterialsLoaded) {
              final materials = state.materials
                ..sort(
                  (a, b) => b.uploadDate.compareTo(a.uploadDate),
                );
              return SafeArea(
                child: ListView.separated(
                  itemCount: materials.length,
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (_, __) => const Divider(
                    color: Color(0xFFE6E8EC),
                  ),
                  itemBuilder: (_, index) {
                    return ChangeNotifierProvider(
                      create: (_) =>
                          sl<ResourceController>()..init(materials[index]),
                      child: const ResourceTile(),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
