package jx.common.tools.fileUpload;

public interface ReportItemManageImpl
{
    public abstract void init();

    public abstract ReportItemImpl getItem();

    public abstract void save(ReportItemImpl reportitem);

    public abstract void dispose();
}
