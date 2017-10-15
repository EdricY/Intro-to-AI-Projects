import java.util.Arrays;

/**
 * Created by Edric on 4/27/2017.
 */
public class GeneticRunner {
    public static void main (String[] args){
        int N = 20;
        try {
            N = Integer.parseInt(args[0]);
        } catch (Exception e){
        }

        EvalString[] strings = new EvalString[N];

        //create first generation
        for (int i = 0; i < N; i++){
            strings[i] = new EvalString(getRandomTestString());
        }

        printEvalStrings(strings);
        Arrays.sort(strings);
    }

    public static void printEvalStrings(EvalString[] strings){
        int[] distribution = new int[7];
        for (EvalString s : strings){
            System.out.println(s + " " + s.score);
            distribution[s.score]++;
        }
        System.out.println("Summary:");
        for (int i = 0; i < distribution.length; i++){
            System.out.println(i + " correct: " + distribution[i]);
        }
    }

    public static String getRandomTestString(){
        String s = new String();
        String[] set = {"T", "F", "#"};
        for (int i = 0; i < 4; i++){
            s += getRandomChar();
        }
        return s;
    }
    public static String getRandomChar(){
        String[] set = {"T", "F", "#"};
        int rand = (int)(Math.random() * 3);
        return set[rand];
    }

    public static class EvalString implements Comparable<EvalString>{
        public String s;
        public int score;
        public EvalString(String s){
            this.s = s;
            this.score = Classifier.scoreString(s);
        }
        @Override
        public int compareTo(EvalString that) {
            return that.score - this.score;
        }
        public String toString() {
            return this.s;
        }
    }
}

