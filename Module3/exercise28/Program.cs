using System;
using System.Diagnostics;
using System.IO;

class Logger
{
    public static void Log(string message)
    {
        // Write to console
        Console.WriteLine(message);

        // Write to trace listeners
        Trace.WriteLine(message);
    }
}

class Program
{
    static void Main()
    {
        // Create file listener
        TextWriterTraceListener fileListener =
            new TextWriterTraceListener("log.txt");

        // Add listener
        Trace.Listeners.Add(fileListener);

        // Enable auto flush
        Trace.AutoFlush = true;

        Logger.Log("Application Started");
        Logger.Log("Performing some operation...");
        Logger.Log("Application Ended");

        // Close listener
        Trace.Close();

        Console.WriteLine("\nLogs saved to log.txt");
    }
}
