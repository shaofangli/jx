package jx.common.db;

import java.sql.SQLException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class DAOException extends RuntimeException {

    protected static final Log log = LogFactory.getLog(DAOException.class);

    public static final int NOT_FOUND = 9999;

    /**
     */
    private int errorCode = 0;

    /**
     * @param message
     */
    public DAOException(String message) {
        super(message);
        log.error("The exception occured. " + getMessage());
        
    }

    /**
     * @param ex
     *            SQLException
     */
    public DAOException(SQLException ex) {
        super(ex.getMessage());
        setErrorCode(ex.getErrorCode());
        log.error("The exception occured. " + getMessage());
    }

    /**
     * @param message
     * @param errorCode
     */
    public DAOException(String message, int errorCode) {
        super(message);
        setErrorCode(errorCode);
        log.error("The exception occured. " + getMessage());
    }

    /**
     * @return int
     */
    public int getErrorCode() {
        return errorCode;
    }

    /**
     * @param errorCode
     */
    public void setErrorCode(int errorCode) {
        this.errorCode = errorCode;
    }

}