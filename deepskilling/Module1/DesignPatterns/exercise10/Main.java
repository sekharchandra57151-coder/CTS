package deepskilling.Module1.DesignPatterns.exercise10;

public class Main {
    public static void main(String[] args) {

        // Create Model
        Student student = new Student("Chandra", 101, "A");

        // Create View
        StudentView view = new StudentView();

        // Create Controller
        StudentController controller = new StudentController(student, view);

        // Display initial data
        System.out.println("Initial Student Details:");
        controller.updateView();

        // Update student data
        controller.setStudentName("Sekhar");
        controller.setStudentGrade("A+");

        System.out.println("\nUpdated Student Details:");
        controller.updateView();
    }
}
