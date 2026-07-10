package deepskilling.Module1.DesignPatterns.exercise3;

class Computer {
    private String CPU;
    private int RAM;
    private int Storage;

    // Private constructor
    private Computer(Builder builder) {
        this.CPU = builder.CPU;
        this.RAM = builder.RAM;
        this.Storage = builder.Storage;
    }

    // Display method
    public void showDetails() {
        System.out.println("CPU: " + CPU);
        System.out.println("RAM: " + RAM + "GB");
        System.out.println("Storage: " + Storage + "GB");
    }

    // Static nested Builder class
    static class Builder {
        private String CPU;
        private int RAM;
        private int Storage;

        public Builder setCPU(String CPU) {
            this.CPU = CPU;
            return this;
        }

        public Builder setRAM(int RAM) {
            this.RAM = RAM;
            return this;
        }

        public Builder setStorage(int Storage) {
            this.Storage = Storage;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }
    }
}