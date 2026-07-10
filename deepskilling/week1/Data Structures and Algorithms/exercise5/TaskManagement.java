class Task {
    int taskId;
    String taskName;
    String status;
    Task next;

    Task(int taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
        this.next = null;
    }

    void display() {
        System.out.println(taskId + " " + taskName + " " + status);
    }
}

public class TaskManagement {
    private Task head;

    // Add Task
    public void addTask(int id, String name, String status) {
        Task newTask = new Task(id, name, status);

        if (head == null) {
            head = newTask;
        } else {
            Task temp = head;
            while (temp.next != null) {
                temp = temp.next;
            }
            temp.next = newTask;
        }
        System.out.println("Task added successfully.");
    }

    // Search Task
    public Task searchTask(int id) {
        Task temp = head;

        while (temp != null) {
            if (temp.taskId == id) {
                return temp;
            }
            temp = temp.next;
        }
        return null;
    }

    // Traverse Tasks
    public void traverseTasks() {
        Task temp = head;

        while (temp != null) {
            temp.display();
            temp = temp.next;
        }
    }

    // Delete Task
    public void deleteTask(int id) {
        if (head == null) {
            System.out.println("List is empty.");
            return;
        }

        if (head.taskId == id) {
            head = head.next;
            System.out.println("Task deleted successfully.");
            return;
        }

        Task temp = head;
        while (temp.next != null && temp.next.taskId != id) {
            temp = temp.next;
        }

        if (temp.next != null) {
            temp.next = temp.next.next;
            System.out.println("Task deleted successfully.");
        } else {
            System.out.println("Task not found.");
        }
    }

    public static void main(String[] args) {
        TaskManagement tm = new TaskManagement();

        tm.addTask(1, "Design UI", "Pending");
        tm.addTask(2, "Write Code", "In Progress");
        tm.addTask(3, "Test Application", "Pending");

        System.out.println("\nTask List:");
        tm.traverseTasks();

        Task found = tm.searchTask(2);
        if (found != null) {
            System.out.println("\nTask Found:");
            found.display();
        } else {
            System.out.println("Task not found.");
        }

        tm.deleteTask(1);

        System.out.println("\nAfter Deletion:");
        tm.traverseTasks();
    }
}