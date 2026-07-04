using System;

class Contact
{
    public string? Name { get; set; }
    public string? PhoneNumber { get; set; }
}

class Program
{
    static void Main()
    {
        // Contact object with values
        Contact? contact1 = new Contact
        {
            Name = "Chandra",
            PhoneNumber = "9876543210"
        };

        // Null contact object
        Contact? contact2 = null;

        // Safe access using null-conditional chaining
        Console.WriteLine("Contact 1 Name: " + (contact1?.Name ?? "No Name Available"));
        Console.WriteLine("Contact 1 Phone: " + (contact1?.PhoneNumber ?? "No Phone Available"));

        Console.WriteLine();

        Console.WriteLine("Contact 2 Name: " + (contact2?.Name ?? "No Name Available"));
        Console.WriteLine("Contact 2 Phone: " + (contact2?.PhoneNumber ?? "No Phone Available"));
    }
}
