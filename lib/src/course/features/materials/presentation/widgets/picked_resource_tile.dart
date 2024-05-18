import 'package:fca_education_app/core/res/media_res.dart';
import 'package:fca_education_app/src/course/features/materials/domain/entity/picked_resources.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/widgets/picked_resource_horizontal_text.dart';
import 'package:flutter/material.dart';

class PickedResourceTile extends StatelessWidget {
  const PickedResourceTile(
    this.resource, {
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final PickedResource resource;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Image.asset(MediaResources.material),
            ),
            title: Text(
              resource.path.split('/').last,
              maxLines: 1,
            ),
            contentPadding: const EdgeInsets.only(left: 16, right: 5),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
                IconButton(onPressed: onDelete, icon: const Icon(Icons.close)),
              ],
            ),
          ),
          const Divider(height: 1),
          PickedResourceHorizontalText(label: 'Author', value: resource.author),
          PickedResourceHorizontalText(label: 'Title', value: resource.title),
          PickedResourceHorizontalText(
            label: 'Description',
            value: resource.description.trim().isEmpty
                ? 'None'
                : resource.description,
          ),
        ],
      ),
    );
  }
}
