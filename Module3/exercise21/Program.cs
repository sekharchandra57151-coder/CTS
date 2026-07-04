using System;

class Program
{
    static void CheckObject(object obj)
    {
        // Pattern matching with 'is'
        if (obj is int number)
        {
            Console.WriteLine("It is an integer: " + number);
        }
        else if (obj is string text)
        {
            Console.WriteLine("It is a string: " + text);
        }
        else
        {
            Console.WriteLine("Unknown type");
        }

        // Pattern matching with switch
        switch (obj)
        {
            case int n:
                Console.WriteLine("Square of number: " + (n * n));
                break;

            case string s:
                Console.WriteLine("String length: " + s.Length);
                break;

            default:
                Console.WriteLine("No operation available");
                break;
        }
    }

    static void Main()
    {
        CheckObject(10);
        Console.WriteLine();

        CheckObject("Chandra");
        Console.WriteLine();

        CheckObject(3.14);
    }
}
