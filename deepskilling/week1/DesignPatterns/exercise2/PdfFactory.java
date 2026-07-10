package deepskilling.Module1.DesignPatterns.exercise2;

class PdfFactory extends DocumentFactory {
    Document createDocument() {
        return new PdfDocument();
    }
}
