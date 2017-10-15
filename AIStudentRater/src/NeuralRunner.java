/**
 * Created by Edric on 4/28/2017.
 */
public class NeuralRunner {
    static int MAX_TRIES = 40;

    public static void main(String[] args){
        double[] weights = new double[4];
        for (int i = 0; i < weights.length; i++){
            weights[i] = (Math.random() * 2) - 1;
        }

        int passes = 0;
        int numCorrect = Classifier.scoreWeights(weights);
        while (numCorrect != 6 && passes < MAX_TRIES){
            System.out.print(numCorrect + "/6 correct: "); printWeights(weights);
            numCorrect = Classifier.scoreWeights(weights);
            passes ++;
        }

        System.out.print(numCorrect + "/6 correct: "); printWeights(weights);

    }

    public static void printWeights(double[] weights){
        for (double w : weights){
            System.out.print(w + " ");
        }
        System.out.println();
    }
}
