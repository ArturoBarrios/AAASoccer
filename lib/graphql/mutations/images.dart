import '../fragments/image_fragments.dart';

class ImageMutations {


  String createChatImage(
      Map<String, dynamic> imageInput) {
    String createImage = """
      mutation {
        createImage(data: {            
              isMainImage: ${imageInput['isMainImage']},
              public: ${imageInput['public']},
              key: "${imageInput['key']}",
              s3bucket: "${imageInput['s3bucket']}",
              chat: {
                connect: "${imageInput['chat_id']}", 
              },
          }) 
          {
              ${ImageFragments().fullImage()}
          }   
        }
        """;

    return createImage;
  }

  String createUserImage(
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
  String createEventImage(
      Map<String, dynamic> imageInput) {
    String createImage = """
      mutation {
        createImage(data: {            
              isMainImage: ${imageInput['isMainImage']},
              public: ${imageInput['public']},
              key: "${imageInput['key']}",
              s3bucket: "${imageInput['s3bucket']}",
              event: {
                connect: "${imageInput['event_id']}", 
              },
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

  String createTeamImage(
      Map<String, dynamic> imageInput) {
    String createImage = """
      mutation {
        createImage(data: {            
              isMainImage: ${imageInput['isMainImage']},
              public: ${imageInput['public']},
              key: "${imageInput['key']}",
              s3bucket: "${imageInput['s3bucket']}",
              team: {
                connect: "${imageInput['team_id']}", 
              },
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

  String deleteImage(
      Map<String, dynamic> imageInput) {
    String removeImageString = """      
      mutation {
        deleteImage(id: "${imageInput['_id']}") {
          _id
          
        }
      }
        """;

    return removeImageString;
  }

}
