package deepskilling.Module1.DesignPatterns.exercise4;

class StripeGateway {
    public void makePayment(double amount) {
        System.out.println("Payment of Rs." + amount + " processed through Stripe.");
    }
}