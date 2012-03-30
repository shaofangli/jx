package jx.common.db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.sql.*;

import jx.common.models.PageInfo;


public class Database {

    private static final Log log = LogFactory.getLog(Database.class);

    /**
     * DB conenction
     */
    private Connection connection = null;

    int i = 0;

    /**
     * DB statement
     */
    private Statement statement = null;

    /**
     * ResultSet prepared
     */
    private PreparedStatement prepared = null;

    /**
     * DB ResultSet
     */
    private ResultSet resultset = null;

    /**
     * BD 初始化
     * 
     * @return Connection
     * @exception DAOException
     *                数据库连接发生错误时抛出
     */
    public void initialize() throws DAOException {
        free();
        try {
        	connection = DriverManager.getConnection("proxool.Oracle");
        } catch (SQLException ex) {
            log.error("initialize:" + ex.getMessage());
            connection = null;
            throw new DAOException(ex);
        }
    }
    
    public Connection getConnection() {
    	return this.connection;
    }
    
    public Statement getStatement() {
    	return this.statement;
    }

    /**
     * @return Statement
     * @exception DAOException
     *                数据库操作发生错误时抛出
     */
    private Statement open() throws DAOException {
        close();
        try {
            statement = connection
                    .createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                            ResultSet.CONCUR_UPDATABLE);
            statement.setQueryTimeout(15);
        } catch (SQLException ex) {
        	log.error("open():"+ ex.getMessage());
            statement = null;
            throw new DAOException(ex);
        }
        return statement;
    }

    /**
     * @return PreparedStatement
     * @exception DAOException
     *                数据库操作发生错误时抛出
     */
    private PreparedStatement open(String sql) throws DAOException {
        close();
        try {
            prepared = connection.prepareStatement(sql,
                    java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
                    java.sql.ResultSet.CONCUR_READ_ONLY);
            prepared.setQueryTimeout(15);
        } catch (SQLException ex) {
        	log.error("open(String sql):"+ ex.getMessage());
            prepared = null;
            throw new DAOException(ex);
        }
        return prepared;
    }

    /**
     * @param index
     *            参数index
     * @param param
     *            匹配参数值(char)
     * @exception DAOException
     *                数据库操作发生错误时抛出
     */
    private void setParameter(int index, char param) throws DAOException {

        setParameter(index, new Character(param));
    }

    /**
     * @param index
     *            参数index
     * @param param
     *            匹配参数值(int)
     * @exception DAOException
     *                数据库操作发生错误时抛出
     */
    private void setParameter(int index, int param) throws DAOException {

        setParameter(index, new Integer(param));
    }

    /**
     * @param index
     *            参数index
     * @param param
     *            匹配参数值（double）
     * @exception DAOException
     *                数据库操作发生错误时抛出
     */
    private void setParameter(int index, double param) throws DAOException {

        setParameter(index, new Double(param));
    }

    /**
     * @param index
     *            参数index
     * @param param
     *            匹配参数(object)
     * @exception DAOException
     *                数据库操作发生错误时抛出
     */
    private void setParameter(int index, Object param) throws DAOException {
        try {
            if (param instanceof String) {prepared.setString(index, (String) param);}
            if (param instanceof Character)
                prepared.setString(index, ((Character) param).toString());
            if (param instanceof Integer)
                prepared.setInt(index, ((Integer) param).intValue());
            if (param instanceof Double)
                prepared.setDouble(index, ((Double) param).doubleValue());
            if (param instanceof Date)
                prepared.setDate(index, (Date) param);
        } catch (SQLException ex) {
            log.error("setParameter:"+ ex.getMessage());
            throw new DAOException(ex);
        }
    } 

    /**
     * @return
     * @exception DAOException
     */
    private ResultSet executeQuery() throws DAOException {
        try {

            resultset = prepared.executeQuery();

        } catch (SQLException ex) {
            log.error("executeQuery:"+ ex.getMessage());
            resultset = null;
            throw new DAOException(ex);
        }
        return resultset;
    }
    /**
     * @param sql
     * @return
     * @exception DAOException
     */
    private int executeUpdate() throws DAOException {
        int count = 0;
        try {
            count = prepared.executeUpdate();
        } catch (SQLException ex) {
            log.error("executeUpdate:"+ ex.getMessage());
            throw new DAOException(ex);
        }
        return count;
    }
    /**
     * 执行数据库更新操作
     * 
     * @param sql
     *            SQL语句(update)
     * @param param
     *            匹配参数列表
     * @exception DAOException
     *                数据库操作错误是抛出
     */
    public int update(ArrayList param,String sql) throws DAOException {
        log.debug("update sql:" + sql + " param:"+ param.toString());
        int count = 0;
        
        open(sql);

        for (int i = 0; i < param.size(); i++) {
            setParameter(i + 1, param.get(i));
        }
        count = executeUpdate();
        
        return count;
//        if (count <= 0) {
//            throw new DAOException("update fail!1", DAOException.NOT_FOUND);
//        }
    }

    /**
     * 执行数据库插入操作
     * 
     * @param sql
     *            SQL语句(insert)
     * @param param
     *            匹配参数列表
     * @exception DAOException
     *                数据库操作错误是抛出
     */
    public int insert(ArrayList param,String sql) throws DAOException {

       return update(param,sql);
    }

    /**
     * 执行数据库删除操作
     * 
     * @param sql
     *            SQL语句(delete)
     * @param param
     *            匹配参数列表
     * @exception DAOException
     *                数据库操作错误是抛出
     */
    public int delete(ArrayList param,String sql) throws DAOException {

    	return update(param,sql);
    }

    /**
     * 执行数据库检索操作
     * 
     * @param sql
     *            SQL语句(select)
     * @param param
     *            匹配参数列表
     * @return ResultSet 检索结果集
     * @exception DAOException
     *                数据库操作错误是抛出
     */
    public ResultSet select(ArrayList param,String sql) throws DAOException {
    	
        log.debug("select sql:" + sql + " param:"
                + param.toString());
        ResultSet rs = null;
        open(sql);
        for (int i = 0; i < param.size(); i++) {
            setParameter(i + 1, param.get(i));
        }
        rs = executeQuery();
        return rs;
    }
    /**
     * @param sql
     * @return
     * @exception DAOException
     */
    public int executeUpdate(String sql) throws DAOException {
        int count = 0;
        try {
            count = open().executeUpdate(sql);
        } catch (SQLException ex) {
            log.error("executeUpdate:"+ ex.getMessage()+" sql:"+sql);
            throw new DAOException(ex);
        }
        return count;
    }
    /**
     * @param sql
     * @return
     * @exception DAOException
     */
    public ResultSet executeQuery(String sql) throws DAOException {
        try {
            resultset = open().executeQuery(sql);
        } catch (SQLException ex) {
            log.error("executeQuery:" + ex.getMessage());
            resultset = null;
            throw new DAOException(ex);
        }
        return resultset;
    }
    /**
     * @exception DAOException
     */

    public void close() throws DAOException {
        try {
            if (resultset != null) {
                resultset.close();
            }
            if (prepared != null) {
                prepared.close();
            }
        } catch (SQLException ex) {
            log.error("close:"+ ex.getMessage());
            throw new DAOException(ex);
        }
        prepared = null;
        resultset = null;
    }

    /**
     * @exception DAOException
     */
    public void commit() throws DAOException {
        try {
            connection.commit();
        } catch (SQLException ex) {
            log.error("commit:" + ex.getMessage());
            throw new DAOException(ex);
        }
    }

    /**
     * @exception DAOException
     */
    public void rollback() throws DAOException {
        try {
            connection.rollback();
        } catch (SQLException ex) {
            log.error("rollback:" + ex.getMessage());
            throw new DAOException(ex);
        }
    }
    /**
     * 
     * @param bol
     */
    public void setAutoCommit(boolean bol){
    	try {
            connection.setAutoCommit(bol);
        } catch (SQLException ex) {
            log.error("setAutoCommit:" + ex.getMessage());
            throw new DAOException(ex);
        }
    }

    /**
     * @exception DAOException
     * 释放回连接池;
     */
    public void free() throws DAOException {
        try {
        	if(statement != null){
        		statement.clearBatch();
        		statement.clearWarnings();
        		statement.close();
        	}
            if (connection != null) {
                if (connection.isClosed() == false)
                    connection.close();
            }
        } catch (SQLException ex) {
            log.error("free:" + ex.getMessage());
            throw new DAOException(ex);
        }
        statement = null;
        connection = null;
   }
    
    /**
     * @exception DAOException
     */
    public void terminate() throws DAOException {
         close();
         free();
    }
    
    /**
     * 简单的sql语句封装;
     */
    public String getSimpleSql(char flag,String table,String column,String where) throws DAOException {
    	StringBuffer sql = new StringBuffer();
    	try { 
             switch(flag)
             {
             	case 's': sql.append("select "+column+" from "+table+(where==null?"":(" where "+where)));break;
             	case 'u': sql.append("update "+table+" set "+column+(where==null?"":(" where "+where)));break;
             	case 'i': sql.append("insert into "+table+"("+column+") values("+where+")");break;
             	case 'd': sql.append("delete from "+table+(where==null?"":(" where "+where)));break;
             }
        } catch (Exception ex) {
        	log.error("getSimpleSql:"+ex.getMessage());
            throw new DAOException(ex.getMessage());
        }
        //System.out.println("sql-->"+sql.toString());
        return sql.toString();
   }
    /**
     * 调用分页存储过程;
     */
    public void execuPaginationSelect(PageInfo pageInfo) throws DAOException {
    	CallableStatement cs = null;
    	try { 
    	       cs = this.connection.prepareCall("{call Pagination(?,?,?,?,?,?,?)}");
       		   cs.setFloat("v_page_size", pageInfo.getPage_size());
       		   cs.setFloat("v_current_page", pageInfo.getCurrent_page());
       		   cs.setString("v_subsql", pageInfo.getPage_sql());
       		   
       		   cs.registerOutParameter("v_out_allpagecount", oracle.jdbc.OracleTypes.INTEGER);
       		   cs.registerOutParameter("v_out_allrowscount", oracle.jdbc.OracleTypes.INTEGER);
       		   cs.registerOutParameter("v_out_currentrowscount", oracle.jdbc.OracleTypes.INTEGER);
       		   cs.registerOutParameter("p_cursor", oracle.jdbc.OracleTypes.CURSOR);

       		   cs.execute();
       		   pageInfo.setAll_pagecount(cs.getInt("v_out_allpagecount"));
       		   pageInfo.setAll_rowscount(cs.getInt("v_out_allrowscount"));
       		   pageInfo.setCurrent_rowscount(cs.getInt("v_out_currentrowscount"));
       		   pageInfo.setRs_obj((ResultSet)cs.getObject("p_cursor"));
       		   
       		   if(pageInfo.getAll_pagecount() == 0)
       			   pageInfo.setCurrent_page(0);
        } catch (Exception ex) {
        	log.error("execuPaginationSelect:" + ex.getMessage()+" sql:"+pageInfo.getPage_sql());
            throw new DAOException(ex.getMessage());
        }finally{
        	try {
				cs.close();
			} catch (SQLException e) {
				throw new DAOException(e);
			}
        }
   }
}