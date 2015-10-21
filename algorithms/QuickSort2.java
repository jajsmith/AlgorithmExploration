import java.io.*;
import java.util.*;

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
        if (high - low < 1) {return;}
     
        int l = low, r = high;
        int pivot = values[high];
        int mid = low + (high - low) / 2;
        //swap pivot from end to middle
        values[high] = values[mid];
        values[mid] = pivot;

        while (l <= r) {
            while (values[l] < pivot) {
                l++;
            }
            while (values[r] > pivot) {
                r--;
            }
            if (l <= r) {
                int t = values[r];
                values[r] = values[l];
                values[l] = t;
                l++;
                r--;
            }
        }
       
        // print
        for (int i = 0; i < values.length; i++) {
            System.out.print(values[i] + " ");
        }
        System.out.println();
        if (low < r) { quicksort(values, low, r); }
        if (high > l) { quicksort(values, l, high); }
    }
}
