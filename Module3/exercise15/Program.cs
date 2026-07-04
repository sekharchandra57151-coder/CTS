using System;

// Abstract class
abstract class Vehicle
{
    public abstract void Drive();
}

// Interface
interface IDrivable
{
    void Start();
}

// Car class inherits abstract class and implements interface
class Car : Vehicle, IDrivable
{
    public override void Drive()
    {
        Console.WriteLine("Car is driving...");
    }

    public void Start()
    {
        Console.WriteLine("Car has started...");
    }
}

class Program
{
    static void Main()
    {
        Car car = new Car();

        car.Start();
        car.Drive();

        Console.WriteLine();

        // Polymorphism using abstract class
        Vehicle v = new Car();
        v.Drive();

        // Polymorphism using interface
        IDrivable d = new Car();
        d.Start();
    }
}