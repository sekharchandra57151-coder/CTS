package deepskilling.Module1.DesignPatterns.exercise5;

public class Main {
    public static void main(String[] args) {

        Notifier notifier = new EmailNotifier();

        // Add SMS feature
        notifier = new SMSNotifierDecorator(notifier);

        // Add Slack feature
        notifier = new SlackNotifierDecorator(notifier);

        notifier.send("Hello! This is a test notification.");
    }
}
