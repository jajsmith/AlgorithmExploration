import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int length = Integer.valueOf(s.nextLine());
        int[] values = new int[length];
        for (int i =0; i < length; i++) {
            values[i] = s.nextInt();
        }
        quicksort(values, 0, length-1);
    }
    
    public static void quicksort(int[] values, int low, int high) {     
        int first_greater = low, check = low;
        int pivot = values[high];
        
        while (check < high) { 
            while (values[check] > pivot && check < high) {
                check++;
            }
            if (values[check] < pivot) {
                int temp = values[check];
                values[check] = values[first_greater];
                values[first_greater] = temp;
                check++;
                first_greater++;
            }          
        }
        if (pivot <= values[first_greater]) {
            values[high] = values[first_greater];
            values[first_greater] = pivot;
        }
        
        // print
        for (int i = 0; i < values.length; i++) {
            System.out.print(values[i] + " ");
        }
        System.out.println();
        if (first_greater - 1 > low) { quicksort(values, low, first_greater - 1); }
        if (first_greater + 1 < high) { quicksort(values, first_greater + 1, high); }
    }
}
