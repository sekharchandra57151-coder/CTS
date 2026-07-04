using System;

class Student
{
    public required string Name { get; set; }
    public required int Age { get; set; }
    public string Course { get; set; } = "Not Assigned";
}

class Program
{
    static void Main()
    {
        // Required properties must be initialized
        Student s1 = new Student
        {
            Name = "Chandra",
            Age = 22
        };

        Console.WriteLine("Student Details:");
        Console.WriteLine("Name: " + s1.Name);
        Console.WriteLine("Age: " + s1.Age);
        Console.WriteLine("Course: " + s1.Course);
    }
}
