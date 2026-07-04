class Employee {
    int employeeId;
    String name;
    String position;
    double salary;

    Employee(int employeeId, String name, String position, double salary) {
        this.employeeId = employeeId;
        this.name = name;
        this.position = position;
        this.salary = salary;
    }

    void display() {
        System.out.println(employeeId + " " + name + " " + position + " " + salary);
    }
}

public class EmployeeManagement {
    private Employee[] employees;
    private int count;

    EmployeeManagement(int size) {
        employees = new Employee[size];
        count = 0;
    }

    // Add Employee
    public void addEmployee(Employee emp) {
        if (count < employees.length) {
            employees[count] = emp;
            count++;
            System.out.println("Employee added successfully.");
        } else {
            System.out.println("Employee array is full.");
        }
    }

    // Search Employee
    public Employee searchEmployee(int id) {
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == id) {
                return employees[i];
            }
        }
        return null;
    }

    // Traverse Employees
    public void traverseEmployees() {
        for (int i = 0; i < count; i++) {
            employees[i].display();
        }
    }

    // Delete Employee
    public void deleteEmployee(int id) {
        int index = -1;

        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == id) {
                index = i;
                break;
            }
        }

        if (index != -1) {
            for (int i = index; i < count - 1; i++) {
                employees[i] = employees[i + 1];
            }
            employees[count - 1] = null;
            count--;
            System.out.println("Employee deleted successfully.");
        } else {
            System.out.println("Employee not found.");
        }
    }

    public static void main(String[] args) {
        EmployeeManagement em = new EmployeeManagement(5);

        em.addEmployee(new Employee(101, "Rahul", "Manager", 50000));
        em.addEmployee(new Employee(102, "Anita", "Developer", 40000));
        em.addEmployee(new Employee(103, "Karan", "Tester", 35000));

        System.out.println("\nEmployee Records:");
        em.traverseEmployees();

        Employee found = em.searchEmployee(102);
        if (found != null) {
            System.out.println("\nEmployee Found:");
            found.display();
        } else {
            System.out.println("Employee not found.");
        }

        em.deleteEmployee(101);

        System.out.println("\nAfter Deletion:");
        em.traverseEmployees();
    }
}
