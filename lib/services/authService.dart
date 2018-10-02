import '../entities/contextInfo.dart';


class AuthService {
    static AuthService instance = new AuthService();
    ContextInfo currentContext;

    AuthService(){
      currentContext = new ContextInfo();
      currentContext.userName = "";
      currentContext.customerName = "Company 2"; //TODO Remove after dev 
      currentContext.accOfficeName = "";
    }   
}