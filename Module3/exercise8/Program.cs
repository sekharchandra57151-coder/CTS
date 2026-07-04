using System;

class Program
{
    // ref: value must be initialized before passing
    static void UpdateValue(ref int x)
    {
        x = x + 10;
    }

    // out: value does not need initialization
    static void GetValue(out int y)
    {
        y = 50;
    }

    // in: value is read-only
    static void DisplayValue(in int z)
    {
        Console.WriteLine("Value using in: " + z);
    }

    static void Main()
    {
        // ref example
        int a = 20;
        Console.WriteLine("Before ref: " + a);
        UpdateValue(ref a);
        Console.WriteLine("After ref: " + a);

        Console.WriteLine();

        // out example
        int b;
        GetValue(out b);
        Console.WriteLine("Value from out: " + b);

        Console.WriteLine();

        // in example
        int c = 100;
        DisplayValue(in c);
    }
}
