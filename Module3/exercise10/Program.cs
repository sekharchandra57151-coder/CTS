using System;

class Car
{
    public string Make;
    public string Model;
    public int Year;

    // Default Constructor
    public Car()
    {
        Make = "Unknown";
        Model = "Unknown";
        Year = 0;
    }

    // Parameterized Constructor
    public Car(string make, string model, int year)
    {
        Make = make;
        Model = model;
        Year = year;
    }

    public void Display()
    {
        Console.WriteLine("Make: " + Make);
        Console.WriteLine("Model: " + Model);
        Console.WriteLine("Year: " + Year);
        Console.WriteLine();
    }
}

class Program
{
    static void Main()
    {
        // Using default constructor
        Car car1 = new Car();

        // Using parameterized constructor
        Car car2 = new Car("Toyota", "Camry", 2024);

        Console.WriteLine("Car 1 Details:");
        car1.Display();

        Console.WriteLine("Car 2 Details:");
        car2.Display();
    }
}
