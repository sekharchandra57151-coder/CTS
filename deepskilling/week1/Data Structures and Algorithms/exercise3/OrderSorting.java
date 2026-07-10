class Order {
    int orderId;
    String customerName;
    double totalPrice;

    Order(int orderId, String customerName, double totalPrice) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
    }

    void display() {
        System.out.println(orderId + " " + customerName + " " + totalPrice);
    }
}

public class OrderSorting {

    // Bubble Sort
    public static void bubbleSort(Order[] orders) {
        int n = orders.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (orders[j].totalPrice > orders[j + 1].totalPrice) {
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                }
            }
        }
    }

    // Quick Sort
    public static void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pi = partition(orders, low, high);
            quickSort(orders, low, pi - 1);
            quickSort(orders, pi + 1, high);
        }
    }

    public static int partition(Order[] orders, int low, int high) {
        double pivot = orders[high].totalPrice;
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (orders[j].totalPrice < pivot) {
                i++;
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }

        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;

        return i + 1;
    }

    public static void displayOrders(Order[] orders) {
        for (Order o : orders) {
            o.display();
        }
    }

    public static void main(String[] args) {
        Order[] orders = {
            new Order(1, "Ravi", 2500),
            new Order(2, "Priya", 1200),
            new Order(3, "Kiran", 4500),
            new Order(4, "Sneha", 3000)
        };

        System.out.println("Before Sorting:");
        displayOrders(orders);

        // Bubble Sort
        bubbleSort(orders);
        System.out.println("\nAfter Bubble Sort:");
        displayOrders(orders);

        // Quick Sort
        quickSort(orders, 0, orders.length - 1);
        System.out.println("\nAfter Quick Sort:");
        displayOrders(orders);
    }
}