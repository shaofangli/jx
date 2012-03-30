package jx.common.tools;


public interface Token {

    String getText();

    String getInnerText();

    String getName();

    int getType();

    int getLine();

    int getCol();
}
