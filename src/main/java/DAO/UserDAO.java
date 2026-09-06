package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Models.User;
import utils.DBConnection;

public class UserDAO {
	
	 public static String insertQuery = """
             INSERT INTO users (username, email, password)
             VALUES (?, ?, ?)
             """;

	 public static String selectQuery = """
             SELECT * FROM users
             WHERE username = ?
             """;

	 public static String selectQueryByEmail = """
			 SELECT * FROM users
			 WHERE email = ?
			 """;

	 public static String selectQueryByEmailAndPassword = """
			 SELECT * FROM users
			 WHERE email = ? AND password = ?
			 """;

	 public static String selectQueryAllUsers = """
			 SELECT * FROM users
			 """;
	

	public boolean SaveUser (User user) {
		 try (Connection connection = DBConnection.getConnection()){
	             PreparedStatement statement = connection.prepareStatement(insertQuery);

	            statement.setString(1, user.getUsername());
	            statement.setString(2, user.getEmail());
	            statement.setString(3, user.getPassword());

	            int rowsAffected = statement.executeUpdate();
	            return rowsAffected > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
};

	public User FindByEmail(String email) {
		try (Connection connection = DBConnection.getConnection()) {
			PreparedStatement statement = connection.prepareStatement(selectQueryByEmail);
			statement.setString(1, email);

			ResultSet resultSet = statement.executeQuery();
			User user =   new User();
			
			while (resultSet.next()) {
			
				user.setEmail(resultSet.getString("email"));
				user.setID(resultSet.getLong("id"));
				user.setPassword(resultSet.getString("password"));
				user.setUsername(resultSet.getString("username"));
				user.setCreated_At("created_at");
				
			}
			
			return user ;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	};

	public User getUserByEmailAndPassword(String email, String password) {
			try(Connection connection = DBConnection.getConnection())
			{
				PreparedStatement statement = connection.prepareStatement(selectQueryByEmailAndPassword);
				statement.setString(1, email);
				statement.setString(2, password);

				var resultSet = statement.executeQuery();
				if(resultSet.next())
				{
					User user = new User();
					user.setID(resultSet.getLong("id"));
					user.setUsername(resultSet.getString("username"));
					user.setEmail(resultSet.getString("email"));
					user.setPassword(resultSet.getString("password"));
					
					return user;
				}
				else {
					return null;
				}

			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
		}


		public List<User> getAllUsers() {
			try (Connection connection = DBConnection.getConnection())
			{
				PreparedStatement statement = connection.prepareStatement(selectQueryAllUsers);
				var resultSet = statement.executeQuery();

				List<User> users = new ArrayList<>();

				while (resultSet.next())
				{
					User user = new User();
					user.setID(resultSet.getLong("id"));
					user.setUsername(resultSet.getString("username"));
					user.setEmail(resultSet.getString("email"));
					user.setPassword(resultSet.getString("password"));
					users.add(user);
				}

				return users;
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
		}



}
