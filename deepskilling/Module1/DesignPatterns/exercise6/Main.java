package deepskilling.Module1.DesignPatterns.exercise6;

public class Main {
    public static void main(String[] args) {

        Image image = new ProxyImage("sample.jpg");

        // Image will load only when display() is called
        System.out.println("First call:");
        image.display();

        System.out.println("\nSecond call:");
        image.display(); // Uses cached image
    }
}