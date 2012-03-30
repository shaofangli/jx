package jx.common.tools.fileUpload;

import javax.servlet.http.HttpSession;

public class DefaultReportItemManage implements ReportItemManageImpl
{

    private HttpSession session = null;
    private String saveId = null;

    public DefaultReportItemManage(HttpSession session)
    {
        this.session = session;
    }

    public void init()
    {
        saveId = "reportItemIndex." + System.currentTimeMillis();
        session.setAttribute("reportItemIndex", saveId);
        session.setAttribute(saveId, null);
    }

    public void save(ReportItemImpl reportItem)
    {
        session.setAttribute(saveId, reportItem);
    }

    public void dispose()
    {
        String saveId = (String) session.getAttribute("reportItemIndex");
        if (saveId != null)
        {
            session.setAttribute(saveId, null);
            session.setAttribute("reportItemIndex", null);
        }
    }

    public ReportItemImpl getItem()
    {
        if (session != null)
        {
            String saveId = (String) session.getAttribute("reportItemIndex");
            if (saveId != null)
                return (ReportItemImpl) session.getAttribute(saveId);
        }
        return null;
    }

    public static ReportItemImpl getItem(HttpSession session)
    {
        if (session != null)
        {
            String saveId = (String) session.getAttribute("reportItemIndex");
            if (saveId != null)
                return (ReportItemImpl) session.getAttribute(saveId);
        }
        return null;
    }

}
