using System;

// Primary Constructor
class Person(string name, int age)
{
    // Auto-properties
    public string Name { get; set; } = name;
    public int Age { get; set; } = age;

    public void DisplayInfo()
    {
        Console.WriteLine("Name: " + Name);
        Console.WriteLine("Age: " + Age);
    }
}

class Program
{
    static void Main()
    {
        Person p1 = new Person("Chandra", 22);

        p1.DisplayInfo();
    }
}
