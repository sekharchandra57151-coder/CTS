class Book {
    int bookId;
    String title;
    String author;

    Book(int bookId, String title, String author) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
    }

    void display() {
        System.out.println(bookId + " " + title + " " + author);
    }
}

public class LibraryManagement {

    // Linear Search
    public static Book linearSearch(Book[] books, String target) {
        for (Book b : books) {
            if (b.title.equalsIgnoreCase(target)) {
                return b;
            }
        }
        return null;
    }

    // Binary Search (books must be sorted by title)
    public static Book binarySearch(Book[] books, String target) {
        int left = 0;
        int right = books.length - 1;

        while (left <= right) {
            int mid = (left + right) / 2;

            int compare = books[mid].title.compareToIgnoreCase(target);

            if (compare == 0) {
                return books[mid];
            } else if (compare < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        // Sorted by title for binary search
        Book[] books = {
            new Book(101, "C Programming", "Dennis Ritchie"),
            new Book(102, "Data Structures", "Mark Allen"),
            new Book(103, "Java Basics", "James Gosling"),
            new Book(104, "Python Guide", "Guido van Rossum")
        };

        // Linear Search
        Book result1 = linearSearch(books, "Java Basics");
        if (result1 != null) {
            System.out.println("Linear Search Found:");
            result1.display();
        } else {
            System.out.println("Book not found.");
        }

        // Binary Search
        Book result2 = binarySearch(books, "Java Basics");
        if (result2 != null) {
            System.out.println("\nBinary Search Found:");
            result2.display();
        } else {
            System.out.println("Book not found.");
        }
    }
}
