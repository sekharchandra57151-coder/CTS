package deepskilling.Module1.DesignPatterns.exercise8;

public class Main {
    public static void main(String[] args) {

        // Pay with Credit Card
        PaymentContext payment1 = new PaymentContext(new CreditCardPayment());
        payment1.executePayment(5000);

        // Pay with PayPal
        PaymentContext payment2 = new PaymentContext(new PayPalPayment());
        payment2.executePayment(2500);
    }
}
