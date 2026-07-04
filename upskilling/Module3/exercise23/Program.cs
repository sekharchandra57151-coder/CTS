using System;
using System.Threading.Tasks;

class Program
{
    // Async method to simulate file upload
    static async Task<string> UploadFileAsync()
    {
        try
        {
            Console.WriteLine("Uploading file...");

            // Simulate delay of 3 seconds
            await Task.Delay(3000);

            return "File uploaded successfully!";
        }
        catch (Exception ex)
        {
            return "Error: " + ex.Message;
        }
    }

    static async Task Main()
    {
        try
        {
            string result = await UploadFileAsync();
            Console.WriteLine(result);
        }
        catch (Exception ex)
        {
            Console.WriteLine("Main Error: " + ex.Message);
        }
    }
}
