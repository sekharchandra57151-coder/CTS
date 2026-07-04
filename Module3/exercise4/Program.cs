using System;

class Student
{
    public string Name { get; set; }

    public Student(string name)
    {
        Name = name;
    }
}

class Program
{
    static void Main()
    {
        // Using var
        var number = 100;
        var message = "Hello C#";

        // Using new()
        Student s1 = new("Chandra");

        Console.WriteLine("Value: " + number);
        Console.WriteLine("Type: " + number.GetType());

        Console.WriteLine();

        Console.WriteLine("Value: " + message);
        Console.WriteLine("Type: " + message.GetType());

        Console.WriteLine();

        Console.WriteLine("Student Name: " + s1.Name);
        Console.WriteLine("Type: " + s1.GetType());
    }
}
