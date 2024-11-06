import java.sql.*;
import java.util.Scanner;

public class JavaConnect {
    private static final String URL = "jdbc:mysql://localhost:3306/te31433_db";
    private static final String USER = "te31433";
    private static final String PASSWORD = "te31433";

    public static void main(String[] args) {
        try (Scanner input = new Scanner(System.in);
            Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            
            System.out.println("Database Connected..");
            String createTableSQL = "CREATE TABLE IF NOT EXISTS users(id INT PRIMARY KEY, name VARCHAR(50), email VARCHAR(50))";
            PreparedStatement preparedStatement = connection.prepareStatement(createTableSQL);
            preparedStatement.executeUpdate();

            int choice;
            do {
                System.out.println("Enter Choice: 1. Insert 2. Update 3. Delete 4. Display 5. Exit");
                choice = input.nextInt();
                input.nextLine();
                switch (choice) {
                    case 1:
                        System.out.println("Enter ID:");
                        int id = input.nextInt();
                        input.nextLine();
                        System.out.println("Enter Name:");
                        String name = input.nextLine();
                        System.out.println("Enter Email:");
                        String email = input.nextLine();
                        insertRecord(connection, id, name, email);
                        break;
                    case 2:
                        System.out.println("Enter ID to Update:");
                        int updateId = input.nextInt();
                        input.nextLine();
                        System.out.println("Enter New Name:");
                        String updateName = input.nextLine();
                        System.out.println("Enter New Email:");
                        String updateEmail = input.nextLine();
                        updateRecord(connection, updateId, updateName, updateEmail);
                        break;
                    case 3:
                        System.out.println("Enter ID to Delete:");
                        int deleteId = input.nextInt();
                        deleteRecord(connection, deleteId);
                        break;
                    case 4:
                        displayRecords(connection);
                        break;
                    case 5:
                        System.out.println("Exiting...");
                        break;
                    default:
                        System.out.println("Invalid choice.");
                }
            } while (choice != 5);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void insertRecord(Connection connection, int id, String name, String email) throws SQLException {
        String sql = "INSERT INTO users (id, name, email) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, name);
            preparedStatement.setString(3, email);
            preparedStatement.executeUpdate();
            System.out.println("Record inserted.");
        }
    }

    public static void updateRecord(Connection connection, int id, String name, String email) throws SQLException {
        String sql = "UPDATE users SET name = ?, email = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setInt(3, id);
            int rows = preparedStatement.executeUpdate();
            System.out.println(rows > 0 ? "Record updated." : "No record found.");
        }
    }

    public static void deleteRecord(Connection connection, int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            int rows = preparedStatement.executeUpdate();
            System.out.println(rows > 0 ? "Record deleted." : "No record found.");
        }
    }

    public static void displayRecords(Connection connection) throws SQLException {
        String sql = "SELECT * FROM users";

        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            System.out.println("ID\tName\t\tEmail");
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                System.out.printf("%d\t%s\t\t%s%n", id, name, email);
            }
        }
    }
}