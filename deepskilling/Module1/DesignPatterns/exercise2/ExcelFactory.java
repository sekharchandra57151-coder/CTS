package deepskilling.Module1.DesignPatterns.exercise2;

class ExcelFactory extends DocumentFactory {
    Document createDocument() {
        return new ExcelDocument();
    }
}
