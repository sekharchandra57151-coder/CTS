using System;
using System.IO;
using System.Text;

class Program
{
    static void Main()
    {
        // Writing sample text into file
        File.WriteAllText("sample.txt", "Hello Chandra! Welcome to C# File Handling.");

        // Reading from file using FileStream
        using (FileStream fs = new FileStream("sample.txt", FileMode.Open, FileAccess.Read))
        {
            byte[] buffer = new byte[fs.Length];
            fs.Read(buffer, 0, buffer.Length);

            string content = Encoding.UTF8.GetString(buffer);

            Console.WriteLine("File Content:");
            Console.WriteLine(content);
        }

        Console.WriteLine();

        // Writing data to MemoryStream
        using (MemoryStream ms = new MemoryStream())
        {
            byte[] data = Encoding.UTF8.GetBytes("This is stored in memory.");

            ms.Write(data, 0, data.Length);

            Console.WriteLine("MemoryStream Bytes Written: " + ms.Length);
        }
    }
}
