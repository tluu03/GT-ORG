/**
 * CS 2110 Summer 2022 HW1
 * Part 2 - Coding with bases
 *
 * @author Tony Luu
 *
 * Global rules for this file:
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, if-else statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum.
 * - You may not use more than 2 looping constructs per method. Looping
 *   constructs include for loops, while loops and do-while loops.
 * - You may not use nested loops.
 * - You may not declare any file-level variables.
 * - You may not use switch statements.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any method from this or
 *   another file to implement any method. Recursive solutions are not
 *   permitted.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from string literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 *
 * Method-specific rules for this file:
 * - You may not use multiplication, division or modulus in any method, EXCEPT
 *   decimalStringToInt (where you may use multiplication only)
 * - You may declare exactly one String variable each in intToOctalString and
 *   and binaryStringToHexString.
 */
public class Bases
{
    /**
     * Convert a string containing ASCII characters (in binary) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid binary numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: binaryStringToInt("111"); // => 7
     */
    public static int binaryStringToInt(String binary)
    {
        int decimal = 0;
        for (int i = 0; i < binary.length(); i++) {
            if (binary.charAt(i) == '1') {
                //once 1 is found += 1 left shifted by 2^n or
                //n = binary.length() - i - 1;
                decimal += 1 << binary.length() - i - 1;
            }
        }
        return decimal;
    }

    /**
     * Convert a string containing ASCII characters (in decimal) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid decimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: decimalStringToInt("46"); // => 46
     *
     * You may use multiplication in this method.
     */
    public static int decimalStringToInt(String decimal)
    {
        int conversion = 0;
        int counter = 1;
        for (int i = decimal.length() - 1; i >= 0; i--) {
            //charAt returns ascii values- manipulate by subtracting by 48
          conversion += (decimal.charAt(i)-48) * counter;
          //to account for tens space
          counter *= 10;
        }
        return conversion;
    }

    /**
     * Convert a string containing ASCII characters (in hex) to an int.
     * The input string will only contain numbers and uppercase letters A-F.
     * You do not need to handle negative numbers. The Strings we will pass in will be
     * valid hexadecimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: hexStringToInt("A6"); // => 166
     */
    public static int hexStringToInt(String hex)
    {
        int result = 0;
        for (int i = 0; i < hex.length(); i++) {
            //left shift 4 to account for additional bits
            result = result << 4;
            //less than 57 means number so subtraxct 48
            if (hex.charAt(i) <= 57) {
                result += hex.charAt(i) - 48;
            } else {
                //character so subtract 55
                result += hex.charAt(i) - 55;
            }
        }
        return result;
    }

    /**
     * Convert a int into a String containing ASCII characters (in octal).
     *
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters
     * necessary to represent the number that was passed in.
     *
     * Example: intToOctalString(166); // => "246"
     *
     * You may declare one String variable in this method.
     */
    public static String intToOctalString(int octal)
    {
        String result = "";
        while(octal > 0){
            result = (octal & 7) + result;
            //divide and get remainder
            octal = octal >> 3;
        }
        return result;
    }

    /**
     * Convert a String containing ASCII characters representing a number in
     * binary into a String containing ASCII characters that represent that same
     * value in hex.
     *
     * The output string should only contain numbers and capital letters.
     * You do not need to handle negative numbers.
     * All binary strings passed in will contain exactly 32 characters.
     * The hex string returned should contain exactly 8 characters.
     *
     * Example: binaryStringToHexString("00001111001100101010011001011100"); // => "0F32A65C"
     *
     * You may declare one String variable in this method.
     */
    public static String binaryStringToHexString(String binary)
    {
        String hexString = "";
        int binTemp = 0;
        for (int i = 31; i >= 0; i--) {
            if (binary.charAt(i) == 49) {
                binTemp = binTemp | 1 << (31 - i);
            }
        }
        int counter = 8;
        while (counter != 0) {
            int x = binTemp & 0xF;
            //converts binary string to appropriate character values
            if (x + 48 > 57) {
                hexString = ((char) (x + 55)) + hexString;
            } else {
                hexString = ((char) (x + 48)) + hexString;
            }
            //right shifting to account for bits
            binTemp = binTemp >> 4;
            
            counter--;
        }
        return hexString;
    }
}
