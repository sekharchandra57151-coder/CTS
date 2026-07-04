package deepskilling.Module1.DesignPatterns.exercise3;

public class BuilderTest {
    public static void main(String[] args) {

        Computer gamingPC = new Computer.Builder()
                .setCPU("Intel i9")
                .setRAM(32)
                .setStorage(1000)
                .build();

        System.out.println("Gaming PC Configuration:");
        gamingPC.showDetails();

        System.out.println();

        Computer officePC = new Computer.Builder()
                .setCPU("Intel i5")
                .setRAM(16)
                .setStorage(512)
                .build();

        System.out.println("Office PC Configuration:");
        officePC.showDetails();
    }
}
