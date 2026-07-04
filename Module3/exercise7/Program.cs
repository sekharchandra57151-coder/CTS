using System;

class Program
{
    // Method with two integers
    static int CalculateTotal(int a, int b)
    {
        return a + b;
    }

    // Method with three doubles
    static double CalculateTotal(double a, double b, double c)
    {
        return a + b + c;
    }

    static void Main()
    {
        int total1 = CalculateTotal(10, 20);
        double total2 = CalculateTotal(10.5, 20.5, 30.5);

        Console.WriteLine("Total (int): " + total1);
        Console.WriteLine("Total (double): " + total2);
    }
}