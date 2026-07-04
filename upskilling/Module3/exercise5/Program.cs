using System;

class Program
{
    static void Main()
    {
        Console.Write("Enter your score: ");
        int score = Convert.ToInt32(Console.ReadLine());

        // Using if-else
        if (score >= 90)
        {
            Console.WriteLine("Grade using if-else: A");
        }
        else if (score >= 75)
        {
            Console.WriteLine("Grade using if-else: B");
        }
        else if (score >= 50)
        {
            Console.WriteLine("Grade using if-else: C");
        }
        else
        {
            Console.WriteLine("Grade using if-else: Fail");
        }

        // Using switch with pattern matching
        string grade = score switch
        {
            >= 90 => "A",
            >= 75 => "B",
            >= 50 => "C",
            _ => "Fail"
        };

        Console.WriteLine("Grade using switch: " + grade);
    }
}