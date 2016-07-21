 

public class StringUtils {
	/**
	 * If string is Palindrome the this function will return true else false
	 * @param input
	 * @return
	 */
	public static boolean isPalindrome(String input) {
		if (input == null) {
			throw new IllegalArgumentException("Input String must be not null");
		}
		char[] word = input.toCharArray();
		boolean match = true;
		int forward = 0;
		int backward = word.length - 1;
		while ((backward > forward) && match) {
			if (word[forward] != word[backward]) {
				match = false;
			}
			++forward;
			--backward;
		}
		return match;
	}
	
	public static void main(String[] args) {
		System.out.println(  isPalindrome("12121"));
	}
}
