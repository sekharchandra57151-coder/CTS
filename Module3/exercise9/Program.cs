using System;

class Program
{
    static int CalculateFactorial(int number)
    {
        // Local Function
        int Factorial(int n)
        {
            if (n == 0 || n == 1)
                return 1;

            return n * Factorial(n - 1);
        }

        return Factorial(number);
    }

    static void Main()
    {
        Console.Write("Enter a number: ");
        int num = Convert.ToInt32(Console.ReadLine());

        int result = CalculateFactorial(num);

        Console.WriteLine("Factorial of " + num + " is: " + result);
    }
}
