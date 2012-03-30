package jx.common.models;

import jx.common.tools.Utils;

/**
 * POJO representing a datasource.
 *
 * Author: Vlad Ilyushchenko
 */
public class DataSourceInfo {
    private String jdbcURL;
    private int busyConnections;
    private int establishedConnections;
    private int maxConnections;
    private boolean resettable;
    private String username;

    public String getJdbcURL() {
        return jdbcURL;
    }

    public void setJdbcURL(String jdbcURL) {
        this.jdbcURL = jdbcURL;
    }

    public int getBusyConnections() {
        return busyConnections;
    }

    public void setBusyConnections(int busyConnections) {
        this.busyConnections = busyConnections;
    }

    public int getEstablishedConnections() {
        return establishedConnections;
    }

    public void setEstablishedConnections(int establishedConnections) {
        this.establishedConnections = establishedConnections;
    }

    public int getMaxConnections() {
        return maxConnections;
    }

    public void setMaxConnections(int maxConnections) {
        this.maxConnections = maxConnections;
    }

    public boolean isResettable() {
        return resettable;
    }

    public void setResettable(boolean resettable) {
        this.resettable = resettable;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getScore() {
        return Utils.calcPoolUsageScore(getMaxConnections(), getBusyConnections(), getEstablishedConnections());
    }
}
