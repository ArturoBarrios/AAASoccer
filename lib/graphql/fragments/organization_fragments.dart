class OrganizationFragments{

  String fullOrganization(){
     String fullOrganizationReturn = r'''                  
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

    return fullOrganizationReturn;

  }
}