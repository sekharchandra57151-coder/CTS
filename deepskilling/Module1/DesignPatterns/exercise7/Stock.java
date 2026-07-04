package deepskilling.Module1.DesignPatterns.exercise7;

public interface Stock {
    void registerObserver(Observer observer);
    void removeObserver(Observer observer);
    void notifyObservers();
}
