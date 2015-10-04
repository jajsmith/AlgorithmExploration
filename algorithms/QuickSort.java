import java.util.Arrays; // Contains java.util.Arrays

public class QuickSort {
	public static void main(String[] args) {
		int[] a = {3, 5, 6, 0, 9, 134, 9, 17, 1, 2, 3};

		System.out.println("Sorting...");
		System.out.println(Arrays.toString(a));

		int[] aSorted = {0, 1, 2, 3, 3, 5, 6, 9, 9, 17, 134};
		sort(a, 0, (a.length - 1) );
		System.out.println("Expected: " + Arrays.toString(aSorted));
		System.out.println("Is: " + Arrays.toString(a));
	}

	public static void sort(int[] arr, int low, int high) {
		// Check for errors in given variables
		if (arr == null || arr.length == 0) { return;}
		if (low >= high) { return;}

		// Select points to do work with
		int point = low + (high - low) / 2;
		int pivot = arr[point];

		int i = low, j = high;

		// Get to work;
		while (i <= j) {
			while (arr[i] < pivot) { i++; }
			while (arr[j] > pivot) { j--; }
			if (i <= j) {
				int temp = arr[i];
				arr[i] = arr[j];
				arr[j] = temp;
				i++;
				j--;
			}
		}

		// Recurse on left/right
		if (low < j) { 
			sort(arr, low, j);
		}
		if (high > i) {
			sort(arr, i, high);
		}
	}
}
