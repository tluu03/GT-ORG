public class test {
    public static void main(String[] args) {
        System.out.print(decimalStringToInt(0));
    }
    public static String decimalStringToInt(int octal)
    {
        String result = "";
        for(int i = 0; i < octal + 1; i++){
            if(octal == 0){
                return "0";
            }
            int oct = octal & 0b111;
            result = ((char) (oct + 48)) + result;
            octal = octal >> 3;
        }
        return result;
    }

}