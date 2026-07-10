using Microsoft.AspNetCore.Mvc;

namespace FirstWebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EmployeeController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetEmployees()
        {
            var employees = new[]
            {
                new { Id = 1, Name = "John", Salary = 50000 },
                new { Id = 2, Name = "Alice", Salary = 60000 }
            };

            return Ok(employees);
        }
    }
}