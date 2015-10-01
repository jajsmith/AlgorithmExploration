import java.io.*; 
// Get access to ???
import java.util.*;
// Get access to Scanner (for reading)

public class BigSum {
	public static void main() {
		// Scanner connects to System.in to read lines
		Scanner scan = new Scanner(System.in);
		// if you wanted to scan a file:
		// Scanner scan = new Scanner(new BufferedReader(new FileReader("file.txt")));

		// BufferedReader reads from a character-input stream.
		//  Much more efficient because it goes straight from memory and only
		//	Touches the disk when it needs too.

		// FileReader reads in characters (as opposed to FileInputStream in bytes)
		
		// scan.nextInt() reads a number from System.in
		// scan.nextLong allows long types to be assigned
		int n = scan.nextInt();
		long sum = 0;
		long next = 0;
		for (int i=0; i < n; i++) {
			next = scan.nextLong();
			sum += next;
		}
		System.out.println(sum);
	}
}
