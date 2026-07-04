using System;
using System.Collections.Generic;
using System.Linq;

class Order
{
    public int OrderId { get; set; }
    public string CustomerName { get; set; }
    public double TotalAmount { get; set; }
}

class Program
{
    static void Main()
    {
        List<Order> orders = new List<Order>()
        {
            new Order { OrderId = 1, CustomerName = "Chandra", TotalAmount = 5000 },
            new Order { OrderId = 2, CustomerName = "Sekhar", TotalAmount = 12000 },
            new Order { OrderId = 3, CustomerName = "Ravi", TotalAmount = 8000 }
        };

        // Filter orders with amount > 7000
        var filteredOrders = orders
            .Where(o => o.TotalAmount > 7000)
            .Select(o => new
            {
                o.OrderId,
                o.CustomerName
            });

        Console.WriteLine("Filtered Orders:");

        foreach (var order in filteredOrders)
        {
            Console.WriteLine($"Order ID: {order.OrderId}, Customer: {order.CustomerName}");
        }
    }
}
