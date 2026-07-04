using System;

// Record with init properties
public record Employee
{
    public string Name { get; init; }
    public int Age { get; init; }
    public string Department { get; init; }
}

class Program
{
    static void Main()
    {
        // Create original record
        Employee emp1 = new Employee
        {
            Name = "Chandra",
            Age = 22,
            Department = "IT"
        };

        // Create modified copy using 'with'
        Employee emp2 = emp1 with { Department = "HR" };

        Console.WriteLine("Original Employee:");
        Console.WriteLine($"Name: {emp1.Name}, Age: {emp1.Age}, Department: {emp1.Department}");

        Console.WriteLine();

        Console.WriteLine("Modified Employee:");
        Console.WriteLine($"Name: {emp2.Name}, Age: {emp2.Age}, Department: {emp2.Department}");
    }
}
