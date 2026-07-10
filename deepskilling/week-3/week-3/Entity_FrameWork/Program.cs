using Microsoft.EntityFrameworkCore;

using var context = new AppDbContext();

Console.WriteLine("------ LAB 4 : INSERT DATA ------");

// Avoid inserting duplicate data
if (!context.Categories.Any())
{
    var electronics = new Category
    {
        Name = "Electronics"
    };

    var groceries = new Category
    {
        Name = "Groceries"
    };

    await context.Categories.AddRangeAsync(electronics, groceries);

    await context.Products.AddRangeAsync(
        new Product
        {
            Name = "Laptop",
            Price = 75000,
            Category = electronics
        },
        new Product
        {
            Name = "Rice Bag",
            Price = 1200,
            Category = groceries
        });

    await context.SaveChangesAsync();

    Console.WriteLine("Sample data inserted.");
}
else
{
    Console.WriteLine("Data already exists.");
}

Console.WriteLine();

Console.WriteLine("------ LAB 5 : RETRIEVE DATA ------");

// Retrieve all products
Console.WriteLine("\nAll Products");

var products = await context.Products.ToListAsync();

foreach (var p in products)
{
    Console.WriteLine($"{p.Id}  {p.Name}  ₹{p.Price}");
}

// Find by ID
Console.WriteLine("\nFind Product with ID = 1");

var product = await context.Products.FindAsync(1);

if (product != null)
{
    Console.WriteLine($"{product.Name} - ₹{product.Price}");
}

// First product costing more than ₹50,000
Console.WriteLine("\nProduct Price > ₹50,000");

var expensive = await context.Products
                             .FirstOrDefaultAsync(p => p.Price > 50000);

if (expensive != null)
{
    Console.WriteLine($"{expensive.Name} - ₹{expensive.Price}");
}