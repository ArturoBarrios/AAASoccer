class ImageFragments{

  String fullImage(){
     String fullImageReturn = r'''                  
          _id  
          url
          key
          isMainImage
          user{
            _id
            name
            email
            userType
          }                                                   
    ''';

    return fullImageReturn;

  }
}