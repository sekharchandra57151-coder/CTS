using System;
using System.Net;

class Program
{
    static void Main()
    {
        Console.Write("Enter your name: ");
        string userInput = Console.ReadLine();

        // Sanitize input using HTML encoding
        string safeInput = WebUtility.HtmlEncode(userInput);

        Console.WriteLine("\nOriginal Input:");
        Console.WriteLine(userInput);

        Console.WriteLine("\nSanitized Input:");
        Console.WriteLine(safeInput);
    }
}