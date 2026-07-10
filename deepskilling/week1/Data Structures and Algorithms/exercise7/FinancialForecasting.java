public class FinancialForecasting {

    // Recursive method to calculate future value
    public static double calculateFutureValue(double currentValue, double growthRate, int years) {
        
        // Base case
        if (years == 0) {
            return currentValue;
        }

        // Recursive case
        return calculateFutureValue(
                currentValue * (1 + growthRate),
                growthRate,
                years - 1
        );
    }

    public static void main(String[] args) {
        double presentValue = 10000;   // Initial amount
        double growthRate = 0.10;      // 10% annual growth
        int years = 5;

        double futureValue = calculateFutureValue(presentValue, growthRate, years);

        System.out.println("Future Value after " + years + " years: " + futureValue);
    }
}
