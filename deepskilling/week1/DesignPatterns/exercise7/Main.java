package deepskilling.Module1.DesignPatterns.exercise7;
public class Main {
    public static void main(String[] args) {

        StockMarket stock = new StockMarket("TCS", 3500.00);

        Observer mobile = new MobileApp("InvestorOne");
        Observer web = new WebApp("StockWatcher");

        stock.registerObserver(mobile);
        stock.registerObserver(web);

        System.out.println("Stock price changed:");
        stock.setPrice(3600.50);

        System.out.println("\nStock price changed again:");
        stock.setPrice(3705.75);
    }
}