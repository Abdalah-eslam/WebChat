package Services.Auth;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.mindrot.jbcrypt.BCrypt;

import DAO.UserDAO;
import DTO.Userdto;
import Models.User;
import utils.JWT;

public class Auth_Service implements IAuth_Service {

    private UserDAO userDAO;


    public Auth_Service() {
        userDAO = new UserDAO();
    }


    @Override
    public Userdto login(String email, String password) {
        User existUser= userDAO.FindByEmail(email);
       if (existUser.getEmail() != null) {
    	   System.out.println("username "+existUser.getUsername()+ " password "+existUser.getPassword());
    	if ( BCrypt.checkpw(password, existUser.getPassword())) {
    		
    		
    		Userdto userdto = new Userdto();
    		userdto.setrole("user");
    		userdto.setUsername(existUser.getUsername());
    		userdto.setId(existUser.getID());
    		
    		String jwt =JWT.GenrateJwt(userdto.getUsername(), userdto.getId(), "user" );
    		userdto.setToken(jwt); 
    		System.out.println("JWT ----------> "+jwt);
    		return userdto;
			
		
        
        
    }  
    
       }
       
       return null ;
    }

	


	@Override
	public void logout(String token) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public boolean isAuthenticated(String token) {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public Userdto register(User user) {
		// hashing password
		String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashedPassword);
		
		if ( userDAO.SaveUser(user)) {
			Userdto userdto = new Userdto();
		userdto.setrole("user");
		userdto.setUsername(user.getUsername());
		userdto.setId(user.getID());
		String jwt =JWT.GenrateJwt(userdto.getUsername(),userdto.getId(), "user");
		userdto.setToken(jwt);
		
		System.out.println("JWT ----------> "+jwt);
		
		return userdto;
			
		}
	
		
		return null;
	}



}