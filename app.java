import java.util.Scanner;

public class app{
    public static void main(String[] args){
        Scanner in = new Scanner(System.in);
        System.out.println("Programa de Ackermann");
        System.out.print("Insira o valor de m: ");
        int m = in.nextInt();
        if (m < 0){
            System.out.println("Valor de m inválido");
            System.exit(0);
        }
        System.out.print("Insira o valor de n: ");
        int n = in.nextInt();
        if (n < 0){
            System.out.println("Valor de n inválido");
            System.exit(0);
        }
        System.out.println("A(" + m + ", " + n + ") = " + Ackermann(m, n));
        in.close();
    }

    public static int Ackermann(int m, int n){
        if(m == 0){
            return n + 1;
        }else if(n == 0){
            return Ackermann(m - 1, 1);
        }else{
            return Ackermann(m - 1, Ackermann(m, n - 1));
        }
    }
}