import 'package:equatable/equatable.dart';
import 'package:fca_education_app/%20core/res/media_res.dart';

class PageContent extends Equatable {
 const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

 const PageContent.first()
      : this(
          image: MediaResources.casualReading,
          title: 'Brand new curriculum',
          description:
              'This is the First online education platform designed by the '
              "World's top educators",
        );
 const PageContent.second()
      : this(
          image: MediaResources.casualReading,
          title: 'Brand a fun atomosphere',
          description:
              'This is the first online education platform designed by the '
              "World's top educators",
        );
const  PageContent.third()
      : this(
          image: MediaResources.casualMediataionScience,
          title: 'Easy to join the lessons',
          description:
              'This is the First online education platform designed by the '
              "World's top educators",
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
