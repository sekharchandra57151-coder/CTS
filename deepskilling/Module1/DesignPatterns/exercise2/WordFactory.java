package deepskilling.Module1.DesignPatterns.exercise2;

class WordFactory extends DocumentFactory {
    Document createDocument() {
        return new WordDocument();
    }
}
