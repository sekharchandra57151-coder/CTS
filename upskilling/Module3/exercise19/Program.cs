using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // List<string>
        List<string> fruits = new List<string>()
        {
            "Apple",
            "Banana",
            "Mango"
        };

        Console.WriteLine("List Items:");
        foreach (string fruit in fruits)
        {
            Console.WriteLine(fruit);
        }

        Console.WriteLine();

        // Add and Remove in List
        fruits.Add("Orange");
        fruits.Remove("Banana");

        Console.WriteLine("Updated List:");
        foreach (string fruit in fruits)
        {
            Console.WriteLine(fruit);
        }

        Console.WriteLine();

        // Dictionary<int, string>
        Dictionary<int, string> students = new Dictionary<int, string>()
        {
            {1, "Chandra"},
            {2, "Sekhar"},
            {3, "Ravi"}
        };

        Console.WriteLine("Dictionary Items:");
        foreach (var student in students)
        {
            Console.WriteLine("ID: " + student.Key + ", Name: " + student.Value);
        }

        Console.WriteLine();

        // Add and Remove in Dictionary
        students.Add(4, "Kiran");
        students.Remove(2);

        Console.WriteLine("Updated Dictionary:");
        foreach (var student in students)
        {
            Console.WriteLine("ID: " + student.Key + ", Name: " + student.Value);
        }
    }
}
