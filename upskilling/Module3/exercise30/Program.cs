using System;
using MySql.Data.MySqlClient;

class Program
{
    static string connectionString = "server=localhost;database=CompanyDB;user=root;password=root123;";

    static void Main()
    {
        InsertEmployee("Chandra", 50000);
        ReadEmployees();
        UpdateEmployee(1, 70000);
        DeleteEmployee(1);
    }

    static void InsertEmployee(string name, double salary)
    {
        using MySqlConnection con = new MySqlConnection(connectionString);

        string query = "INSERT INTO Employees (Name, Salary) VALUES (@Name, @Salary)";

        MySqlCommand cmd = new MySqlCommand(query, con);

        cmd.Parameters.AddWithValue("@Name", name);
        cmd.Parameters.AddWithValue("@Salary", salary);

        con.Open();
        cmd.ExecuteNonQuery();

        Console.WriteLine("Inserted successfully");
    }

    static void ReadEmployees()
    {
        using MySqlConnection con = new MySqlConnection(connectionString);

        string query = "SELECT * FROM Employees";

        MySqlCommand cmd = new MySqlCommand(query, con);

        con.Open();

        MySqlDataReader reader = cmd.ExecuteReader();

        while (reader.Read())
        {
            Console.WriteLine(reader["Id"] + " " +
                              reader["Name"] + " " +
                              reader["Salary"]);
        }
    }

    static void UpdateEmployee(int id, double salary)
    {
        using MySqlConnection con = new MySqlConnection(connectionString);

        string query = "UPDATE Employees SET Salary=@Salary WHERE Id=@Id";

        MySqlCommand cmd = new MySqlCommand(query, con);

        cmd.Parameters.AddWithValue("@Salary", salary);
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        cmd.ExecuteNonQuery();

        Console.WriteLine("Updated successfully");
    }

    static void DeleteEmployee(int id)
    {
        using MySqlConnection con = new MySqlConnection(connectionString);

        string query = "DELETE FROM Employees WHERE Id=@Id";

        MySqlCommand cmd = new MySqlCommand(query, con);

        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        cmd.ExecuteNonQuery();

        Console.WriteLine("Deleted successfully");
    }
}