import '../fragments/image_fragments.dart';

class ImageMutations {
  String createImage(
      Map<String, dynamic> imageInput) {
    String createImage = """
      mutation {
        createImage(data: {            
              isMainImage: "${imageInput['isMainImage']}",
              key: "${imageInput['key']}",
              user: "${imageInput['user']}", 
          }) 
          {
              ${ImageFragments().fullImage()}
          }   
        }
        """;

    return createImage;
  }
}
