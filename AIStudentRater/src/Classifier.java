/**
 * Created by Edric on 4/27/2017.
 */
public class Classifier {
    static Student[] students = new Student[]{
            new Student("Richard", new boolean[] {true, true, false, true}),
            new Student("Alan", new boolean[] {true, true, true, false}),
            new Student("Alison", new boolean[] {false, false, true, false}),
            new Student("Jeff", new boolean[] {false, true, false, true}),
            new Student("Gail", new boolean[] {true, false, true, true}),
            new Student("Simon", new boolean[] {false, true, true, true})
    };
    static boolean[] results = {true, true, true, false, true, false};

    public Classifier(){
    }

    public static int scoreString(String evalString){
        int numCorrect = 0;
        for (int i = 0; i < results.length; i++){
            if (testStudent(students[i], evalString) == results[i])
                numCorrect++;
        }
        return numCorrect;
    }

    public static boolean testStudent(Student student, String evalString){
        char[] chars = evalString.toCharArray();
        boolean [] bools = student.stats;
        for(int i = 0; i < bools.length; i++){
            if(chars[i] == '#') continue;
            else if (chars[i] == 'T' && bools[i]) continue;
            else if (chars[i] == 'F' && !bools[i]) continue;
            else return false;
        }
        return true;
    }

    public static int scoreWeights(double[] weights){
        int numCorrect = 0;
        double[] weights_cpy = new double[weights.length];
        for(int i = 0; i < weights.length; i++)
            weights_cpy[i] = weights[i];

        for (int i = 0; i < results.length; i++) {
            boolean[] stats = students[i].stats;
            double totalWeights = 0;
            for(int j = 0; j < stats.length; j++) {
                if (stats[j]) totalWeights += weights[j];
            }

            if(totalWeights >= .5 && results[i]) {
                numCorrect++;
                adjustWeightsUpCorrect(weights_cpy, stats);

            } else if(totalWeights < .5 && !results[i]) {
                numCorrect++;
                adjustWeightsDownCorrect(weights_cpy, stats);
            } else {
                if (results[i])
                    adjustWeightsUpWrong(weights_cpy, stats);
                else
                    adjustWeightsDownWrong(weights_cpy, stats);
            }
        }

        for(int i = 0; i < weights.length; i++)
            weights[i] = weights_cpy[i];

        return numCorrect;
    }

    public static void adjustWeightsUpCorrect(double[] weights, boolean[] stats){
        for (int i = 0; i < stats.length; i++) {
            if (stats[i]) weights[i] += .05;
            else weights[i] -= .05;
        }
    }

    public static void adjustWeightsDownCorrect(double[] weights, boolean[] stats){
        for (int i = 0; i < stats.length; i++) {
            if (stats[i]) weights[i] += .05;
            else weights[i] -= .05;
        }
    }
    public static void adjustWeightsUpWrong(double[] weights, boolean[] stats){
        for (int i = 0; i < stats.length; i++) {
            if (stats[i]) weights[i] += .25;
            else weights[i] -= .25;
        }
    }
    public static void adjustWeightsDownWrong(double[] weights, boolean[] stats){
        for (int i = 0; i < stats.length; i++) {
            if (stats[i]) weights[i] -= .25;
            else weights[i] += .25;
        }
    }

    public static class Student {
        public boolean[] stats;
        public String name;
        public Student(String name, boolean[] stats){
            this.name = name;
            this.stats = stats;
        }
    }


}
