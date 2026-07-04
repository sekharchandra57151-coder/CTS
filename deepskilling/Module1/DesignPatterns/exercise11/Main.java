package deepskilling.Module1.DesignPatterns.exercise11;

public class Main {
    public static void main(String[] args) {

        // Inject dependency
        CustomerRepository repository = new CustomerRepositoryImpl();
        CustomerService service = new CustomerService(repository);

        // Fetch customer details
        service.getCustomerDetails(101);
    }
}