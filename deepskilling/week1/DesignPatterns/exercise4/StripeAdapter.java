package deepskilling.Module1.DesignPatterns.exercise4;

class StripeAdapter implements PaymentProcessor {
    private StripeGateway stripe;

    public StripeAdapter(StripeGateway stripe) {
        this.stripe = stripe;
    }

    public void processPayment(double amount) {
        stripe.makePayment(amount);
    }
}
