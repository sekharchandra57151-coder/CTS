using System;

class Parent
{
    public string PublicMessage = "I am Public";
    private string PrivateMessage = "I am Private";
    protected string ProtectedMessage = "I am Protected";

    public void ShowPrivate()
    {
        Console.WriteLine(PrivateMessage);
    }
}

class Child : Parent
{
    public void ShowProtected()
    {
        Console.WriteLine(ProtectedMessage);
    }
}

class Program
{
    static void Main()
    {
        Parent p = new Parent();

        // Public member (accessible anywhere)
        Console.WriteLine(p.PublicMessage);

        // Private member (accessible only inside Parent class)
        p.ShowPrivate();

        Child c = new Child();

        // Public inherited member
        Console.WriteLine(c.PublicMessage);

        // Protected member accessed through derived class method
        c.ShowProtected();
    }
}