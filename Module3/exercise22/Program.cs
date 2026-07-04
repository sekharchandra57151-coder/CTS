using System;

class Program
{
    // Method returning a tuple
    static (int, string) GetStudentDetails()
    {
        return (101, "Chandra");
    }

    static void Main()
    {
        // Deconstruct tuple
        var (id, name) = GetStudentDetails();

        Console.WriteLine("Student ID: " + id);
        Console.WriteLine("Student Name: " + name);
    }
}
