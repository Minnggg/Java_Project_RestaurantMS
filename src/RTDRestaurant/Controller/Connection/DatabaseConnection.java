package RTDRestaurant.Controller.Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static DatabaseConnection instance;
    private Connection connection;

    public static DatabaseConnection getInstance() {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }

    private DatabaseConnection() {
    }

    // Kết nối tới MySQL trong XAMPP
    public void connectToDatabase() throws SQLException {
        final String url = "jdbc:mysql://localhost:3306/nha_hang?useSSL=false&serverTimezone=UTC";
        final String username = "root"; // Thường mặc định là 'root'
        final String password = ""; // Mật khẩu mặc định của XAMPP là rỗng

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL Driver
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("Kết nối thành công đến MySQL!");
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy MySQL Driver!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối MySQL!");
            e.printStackTrace();
            throw e;
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }
}
