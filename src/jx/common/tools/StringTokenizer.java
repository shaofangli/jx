package jx.common.tools;


import java.io.IOException;
import java.io.StringReader;

public class StringTokenizer extends Tokenizer {

    public StringTokenizer() {
    }

    public StringTokenizer(final String str) {
        setString(str);
    }

    public void setString(final String str) {
        setReader(new StringReader(str));
    }

    public boolean hasMore() {
        try {
            return super.hasMore();
        } catch (IOException e) {
            return false;
        }
    }

    public Token getToken() {
        try {
            return super.getToken();
        } catch (IOException e) {
            return null;
        }
    }

    public Token nextToken() {
        try {
            return super.nextToken();
        } catch (IOException e) {
            return null;
        }
    }
}
