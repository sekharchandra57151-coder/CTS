using Microsoft.EntityFrameworkCore;

public class AppDbContext : DbContext
{
    public DbSet<Product> Products => Set<Product>();
    public DbSet<Category> Categories => Set<Category>();

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(
            "Server=localhost,1433;" +
            "Database=RetailInventoryDB;" +
            "User Id=sa;" +
            "Password=YourStrong@Pass123;" +
            "TrustServerCertificate=True;");
    }
}