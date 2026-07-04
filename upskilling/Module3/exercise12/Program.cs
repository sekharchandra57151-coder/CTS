using System;

class Product
{
    // Auto-property
    public string Name { get; set; }

    // Backing field
    private double _price;

    // Property with validation
    public double Price
    {
        get { return _price; }
        set
        {
            if (value < 0)
            {
                Console.WriteLine("Price cannot be negative. Setting to 0.");
                _price = 0;
            }
            else
            {
                _price = value;
            }
        }
    }
}

class Program
{
    static void Main()
    {
        Product p1 = new Product();

        p1.Name = "Laptop";
        p1.Price = 50000;

        Console.WriteLine("Product Name: " + p1.Name);
        Console.WriteLine("Product Price: " + p1.Price);

        Console.WriteLine();

        // Testing validation
        p1.Price = -1000;

        Console.WriteLine("Updated Price: " + p1.Price);
    }
}
