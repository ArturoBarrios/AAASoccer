class ImageFragments{

  String fullImage(){
     String fullImageReturn = r'''                  
          _id  
          url
          key
          isMainImage
          chat{
            _id
            name
          }
          user{
            _id
            name
            email
            userType
          }    
          event{
            _id
            name
          }     
          team{
            _id
            name
          }     
          organization{
            _id
            name
          }                                     
    ''';

    return fullImageReturn;

  }
}