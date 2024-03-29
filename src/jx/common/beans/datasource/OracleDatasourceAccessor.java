package jx.common.beans.datasource;

import oracle.jdbc.pool.OracleDataSource;
import oracle.jdbc.pool.OracleConnectionCacheManager;

import java.util.Properties;

import jx.common.beans.DatasourceAccessor;
import jx.common.models.DataSourceInfo;
import jx.common.tools.Utils;

/**
 * Accesses oracle.jdbc.pool.OracleDataSource.
 *
 * Oracle connection pool is quite different from any other available for Tomcat.
 * Datasources are run by static OracleConnectionCacheManager, whereby application context scope datasource
 * would have a named entry in OracleConnectionCacheManager.
 *
 * Datasources do not have information about pool as such, therefore this accessor has to do quite tidious job
 * of verifying whether the datasource has a record in the cache manager or not. The pool information is subsequently
 * retrieved from the relevant cache manager entry. 
 *
 */
public class OracleDatasourceAccessor implements DatasourceAccessor {

    public DataSourceInfo getInfo(Object resource) throws Exception {
        DataSourceInfo dataSourceInfo = null;

        if (canMap(resource)) {
            OracleDataSource source = (OracleDataSource) resource;
            OracleConnectionCacheManager occm = OracleConnectionCacheManager.getConnectionCacheManagerInstance();
            Properties cacheProperties = source.getConnectionCacheProperties();
            String cacheName = source.getConnectionCacheName();
            cacheName = cacheName != null && occm.existsCache(cacheName) ? cacheName : null;

            if (cacheProperties != null) {

                dataSourceInfo = new DataSourceInfo();
                if (cacheName != null) {
                    dataSourceInfo.setBusyConnections(occm.getNumberOfActiveConnections(cacheName));
                    dataSourceInfo.setEstablishedConnections(occm.getNumberOfAvailableConnections(cacheName) + dataSourceInfo.getBusyConnections());
                } else {
                    dataSourceInfo.setBusyConnections(0);
                    dataSourceInfo.setEstablishedConnections(0);
                }

                dataSourceInfo.setMaxConnections(Utils.toInt(cacheProperties.getProperty("MaxLimit"), -1));
                dataSourceInfo.setJdbcURL(source.getURL());
                dataSourceInfo.setUsername(source.getUser());
                dataSourceInfo.setResettable(true);
            }
        }
        return dataSourceInfo;
    }

    public boolean reset(Object resource) throws Exception {
        OracleDataSource source = (OracleDataSource) resource;
        source.close();
        return true;
    }

    public boolean canMap(Object resource) {
        return "oracle.jdbc.pool.OracleDataSource".equals(resource.getClass().getName()) &&
                resource instanceof OracleDataSource;
    }
}
