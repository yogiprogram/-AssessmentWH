 
import java.util.ArrayList;

public class ArraysComplementary {

	public static ArrayList<int[]> findComplementary(final int k, final int[] inputArray) {
		ArrayList<int[]> comps = new ArrayList<int[]>();
		for (int i = 0; i < inputArray.length - 1; i++) {
			for (int j = i + 1; j < inputArray.length; j++) {
				if (k == inputArray[i] + inputArray[j])
					comps.add(new int[] { inputArray[i], inputArray[j] });
			}
		}
		return comps;
	}
 
}
