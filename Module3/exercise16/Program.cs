using System;

class Person
{
    public string? Name { get; set; }
    public string? Address { get; set; }
}

class Program
{
    static void Main()
    {
        Person? person = new Person
        {
            Name = "Chandra",
            Address = null
        };

        // Null-conditional operator (?.)
        Console.WriteLine("Name: " + person?.Name);

        // Null-coalescing operator (??)
        Console.WriteLine("Address: " + (person?.Address ?? "No Address Available"));

        Console.WriteLine();

        // Null object example
        Person? person2 = null;

        Console.WriteLine("Person2 Name: " + (person2?.Name ?? "No Name Found"));
    }
}
