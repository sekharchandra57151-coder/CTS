using System;

class Student
{
    public string Name;
}

class Program
{
    static void ModifyValue(int num)
    {
        num = 100;
    }

    static void ModifyReference(Student s)
    {
        s.Name = "Sekhar";
    }

    static void Main()
    {
        int number = 10;
        Console.WriteLine("Before ModifyValue: " + number);

        ModifyValue(number);

        Console.WriteLine("After ModifyValue: " + number);

        Console.WriteLine();

        Student student = new Student();
        student.Name = "Chandra";

        Console.WriteLine("Before ModifyReference: " + student.Name);

        ModifyReference(student);

        Console.WriteLine("After ModifyReference: " + student.Name);
    }
}