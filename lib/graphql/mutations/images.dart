import '../fragments/image_fragments.dart';

class ImageMutations {
  String createImage(
      Map<String, dynamic> imageInput) {
    String createImage = """
      mutation {
        createImage(data: {            
              isMainImage: ${imageInput['isMainImage']},
              public: ${imageInput['public']},
              key: "${imageInput['key']}",
              s3bucket: "${imageInput['s3bucket']}",
              user: {
                connect: "${imageInput['user_id']}", 
              },
          }) 
          {
              ${ImageFragments().fullImage()}
          }   
        }
        """;

    return createImage;
  }

  String partialImageUpdate(Map<String, dynamic> imageInput) {
    String updateImageString = """
      mutation {
        partialUpdateImage(id: "${imageInput['image']['_id']}", 
        data:{
         isMainImage: false 
        }
        ){
          ${ImageFragments().fullImage()}
        }  
      }
    """;

    return updateImageString;
  }

}
