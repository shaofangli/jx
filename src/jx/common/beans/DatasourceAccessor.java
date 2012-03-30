package jx.common.beans;

import jx.common.models.DataSourceInfo;


/**
 * Part of datasource type abstraction layer. Allows to extent Probe functionality to any kind of datasources.
 *
 * Author: Vlad Ilyushchenko
 *
 */
public interface DatasourceAccessor {
    DataSourceInfo getInfo(Object resource) throws Exception;
    boolean reset(Object resource) throws Exception;
    boolean canMap(Object resource);
}
