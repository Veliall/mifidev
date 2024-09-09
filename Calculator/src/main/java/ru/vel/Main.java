package ru.vel;
import java.util.Scanner;
import java.util.Set;

public class Main {
    private final static Set<String> OPERATIONS = Set.of("-", "+", "*", "/");

    public static void main(String[] args) {
        int operand = 0;
        String operation = "+";
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.print("Enter a number or command ('s' to stop, 'c' to clear): ");
            String input = scanner.nextLine().trim();

            if (input.equals("s")) {
                break;
            }

            if (input.equals("c")) {
                operand = 0;
                operation = "+";
                System.out.println("Calculation cleared. Current result: " + operand);
                continue;
            }

            int operandInput;
            try {
                operandInput = parseOperand(input);
            } catch (RuntimeException e) {
                System.out.println(e.getMessage());
                continue;
            }

            switch (operation) {
                case "+" -> operand += operandInput;
                case "-" -> operand -= operandInput;
                case "*" -> operand *= operandInput;
                case "/" -> {
                    if (operandInput == 0) {
                        System.out.println("Error: Division by zero.");
                        continue;
                    }
                    operand /= operandInput;
                }
            }
            System.out.println("Current result: " + operand);

            System.out.print("Enter an operation (+, -, *, /): ");
            operation = scanner.nextLine().trim();
            while (!OPERATIONS.contains(operation)) {
                System.out.println("Invalid operation: " + operation);
                System.out.print("Please enter a valid operation (+, -, *, /): ");
                operation = scanner.nextLine().trim();
            }
        }
        scanner.close();
        System.out.println("Calculator stopped.");
    }

    private static int parseOperand(String input) {
        try {
            return Integer.parseInt(input);
        } catch (NumberFormatException e) {
            throw new RuntimeException("""
                    We are lazy, so we work only with integers.
                    Maybe you want to use double or long, but not this time, buddy!
                    There's nothing like that in the task)""");
        }
    }
}