import java.io.IOException;
import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;
import java.util.Random;

public class RandomValue extends EvalFunc<Tuple> {
    private static String[] options = { "MR", "Pig", "Hive", "MongoDB" };
    private static TupleFactory mTupleFactory = TupleFactory.getInstance();
    private static Random random = new Random();

    public Tuple exec(Tuple input) throws IOException {
        if (input == null || input.size() == 0 || input.get(0) == null)
            return null;
        try {
            /*
             * We need a tuple factory to generate a tuple with input as well as the random
             * output
             * Tuples and databags are customised defined types so has their own
             * constructors
             */
            Tuple output = mTupleFactory.newTuple(input.getAll());
            Integer index = Math.abs(random.nextInt()) % 4;
            output.append(options[index]);
            return output;

        } catch (Exception e) {
            throw new IOException("Caught exception processing input row ", e);
        }
    }

}