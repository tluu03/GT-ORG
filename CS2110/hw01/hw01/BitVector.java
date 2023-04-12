/**
 * CS 2110 Summer 2022 HW1
 * Part 1 - Coding a bit vector
 *
 * @author Tony Luu
 *
 * Global rules for this file:
 * - You may not use multiplication, division or modulus in any method.
 * - You may not use more than 2 conditionals per method, and you may only use
 *   them in select methods. Conditionals are if-statements, if-else statements,
 *   or ternary expressions. The else block associated with an if-statement does
 *   not count toward this sum.
 * - You may not use looping constructs in most methods. Looping constructs
 *   include for loops, while loops and do-while loops. See below for exceptions
 * - In those methods that allow looping, you may not use more than 2 looping
 *   constructs, and they may not be nested.
 * - You may not declare any file-level variables.
 * - You may not declare any objects.
 * - You may not use switch statements.
 * - You may not use casting.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any method from this or
 *   another file to implement any method. Recursive solutions are not
 *   permitted.
 * - You may only perform addition or subtraction with the number 1.
 *
 * Method-specific rules for this file:
 * - All methods must be done in one line, except for: zerosCount, onesCount,
 *   and size.
 * - Looping and conditionals as described above are only allowed for:
 *   zerosCount, onesCount, and size
 * - You can only use addition and subtraction in: zerosCount, onesCount, and
 *   size
 */
public class BitVector
{
    /**
     * 32-bit data initialized to all zeros. Here is what you will be using to
     * represent the Bit Vector. Do not change its scope from private.
     */
    private int bits;

    /** You may not add any more fields to this class other than the given one. */

    /**
     * Sets the bit (sets to 1) pointed to by index.
     * @param index index of which bit to set.
     *              0 for the least significant bit (right most bit).
     *              31 for the most significant bit.
     */
    public void set(int index)
    {
        //left shift by index and use or operator to set bit
        bits = bits | (1 << index);
    }

    /**
     * Clears the bit (sets to 0) pointed to by index.
     * @param index index of which bit to set.
     *              0 for the least significant bit (right most bit).
     *              31 for the most significant bit.
     */
    public void clear(int index)
    {
        //we use the and operator and the inversion symbol to ensure no trailing 0's that could 
        //clear things we do not want to clear
        bits = bits & ~(1 << index);
    }

    /**
     * Toggles the bit (sets to the opposite of its current value) pointed to by
     * index.
     * @param index index of which bit to set.
     *              0 for the least significant bit (right most bit).
     *              31 for the most significant bit.
     */
    public void toggle(int index)
    {
        bits = bits ^ (1 << index);
    }

    /**
     * Returns true if the bit pointed to by index is currently set.
     * @param index index of which bit to check.
     *              0 for the least significant bit (right-most bit).
     *              31 for the most significant bit.
     * @return true if the bit is set, false if the bit is clear.
     *         If the index is out of range (index >= 32), then return false.
     */
    public boolean isSet(int index)
    {
        //check if index is less than 32 then and that result
        //to the result of bits & 1<<index
        //if it isnt 0 then its set
        return (index < 32) && ((bits & (1 << index)) != 0);
    }

    /**
     * Returns true if the bit pointed to by index is currently clear.
     * @param index index of which bit to check.
     *              0 for the least significant bit (right-most bit).
     *              31 for the most significant bit.
     * @return true if the bit is clear, false if the bit is set.
     *         If the index is out of range (index >= 32), then return true.
     */
    public boolean isClear(int index)
    {
        //similar process to isSet however instead of checking against 0
        //we check 1 << index and then not our entire result
        return !((index < 32) && (bits & (1 << index)) == (1 << index));
    }

    /**
     * Returns the number of bits currently set (=1) in this bit vector.
     * You may use the ++ operator to increment your counter.
     */
    public int onesCount()
    {
        //keep a count
        int count = 0;
        //if the bit at index is != 0 then increment count
        for (int i = 0; i < 32; i++){
            if((bits & (1 << i)) != 0){
                count++;
            }
        }
        return count;
    }

    /**
     * Returns the number of bits currently clear (=0) in this bit vector.
     * You may use the ++ operator to increment your counter.
     */
    public int zerosCount()
    {
        int count = 0;
        //similar to ones count
        for (int i = 0; i < 32; i++){
            if((bits & (1 << i)) == 0){
                count++;
            }
        }
        return count;
    }

    /**
     * Returns the "size" of this BitVector. The size of this bit vector is
     * defined to be the minimum number of bits that will represent all of the
     * ones.
     *
     * For example, the size of the bit vector 00010000 will be 5.
     */
    public int size()
    {
        //start at the end to get bit size
        for (int i = 31; i >= 0; i--) {
        	if ((bits & (1 << i)) != 0) {
                //accounts for size and fixes value
        		return i + 1;
        	}
        }
        return 1;
    }
}
