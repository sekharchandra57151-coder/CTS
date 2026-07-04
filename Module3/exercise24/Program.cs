using System;
using System.IO;
using System.Text.Json;

class User
{
    public string Name { get; set; }
    public int Age { get; set; }
    public string Email { get; set; }
}

class Program
{
    static void Main()
    {
        // Create object
        User user = new User
        {
            Name = "Chandra",
            Age = 22,
            Email = "chandra@example.com"
        };

        // Serialize object to JSON
        string jsonString = JsonSerializer.Serialize(user);

        // Save JSON to file
        File.WriteAllText("user.json", jsonString);

        Console.WriteLine("Serialized JSON:");
        Console.WriteLine(jsonString);

        Console.WriteLine();

        // Read JSON from file
        string jsonFromFile = File.ReadAllText("user.json");

        // Deserialize JSON back to object
        User deserializedUser = JsonSerializer.Deserialize<User>(jsonFromFile);

        Console.WriteLine("Deserialized Object:");
        Console.WriteLine("Name: " + deserializedUser.Name);
        Console.WriteLine("Age: " + deserializedUser.Age);
        Console.WriteLine("Email: " + deserializedUser.Email);
    }
}
