public class SingletonTest {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        logger1.log("First message");

        Logger logger2 = Logger.getInstance();
        logger2.log("Second message");

        // Checking both references point to same object
        if (logger1 == logger2) {
            System.out.println("Both logger objects are the same instance.");
        } else {
            System.out.println("Different instances created.");
        }
    }
}