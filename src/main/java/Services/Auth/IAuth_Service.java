package Services.Auth;

import DTO.Userdto;
import Models.User;

interface IAuth_Service {
    public Userdto login(String username, String password);
    public Userdto register(User user);
    public void logout(String token);
    public boolean isAuthenticated(String token);
}