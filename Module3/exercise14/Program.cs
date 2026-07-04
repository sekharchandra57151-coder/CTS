using System;

// Base class
class Shape
{
    public virtual void Draw()
    {
        Console.WriteLine("Drawing a shape");
    }
}

// Derived class Circle
class Circle : Shape
{
    public override void Draw()
    {
        Console.WriteLine("Drawing a Circle");
    }
}

// Derived class Rectangle
class Rectangle : Shape
{
    public override void Draw()
    {
        Console.WriteLine("Drawing a Rectangle");
    }
}

class Program
{
    static void Main()
    {
        Shape s1 = new Circle();
        Shape s2 = new Rectangle();

        s1.Draw();
        s2.Draw();
    }
}
