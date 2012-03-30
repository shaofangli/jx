package jx.common.mappers;

import com.opensymphony.module.sitemesh.mapper.AbstractDecoratorMapper;
import com.opensymphony.module.sitemesh.Decorator;
import com.opensymphony.module.sitemesh.Page;
import com.opensymphony.module.sitemesh.Config;
import com.opensymphony.module.sitemesh.DecoratorMapper;

import javax.servlet.http.HttpServletRequest;
import java.util.Properties;

public class AjaxDecoratorMapper extends AbstractDecoratorMapper {
    private String ajaxExtension = ".ajax";

    public void init(Config config, Properties properties, DecoratorMapper decoratorMapper) throws InstantiationException {
        super.init(config, properties, decoratorMapper);
        if (properties.get("ajaxExtension") != null) {
            ajaxExtension = (String) properties.get("ajaxExtension");
        }
    }

    public Decorator getDecorator(HttpServletRequest request, Page page) {

        boolean callMapperChain;
        String originalURI = (String) request.getAttribute("javax.servlet.error.request_uri");
        if (originalURI != null) {
            //
            // cut off the query string
            //
            int qIdx = originalURI.indexOf("?");
            if (qIdx != -1) {
                originalURI = originalURI.substring(0, qIdx);
            }
        }
        callMapperChain =  (originalURI == null || !originalURI.endsWith(ajaxExtension)) &&
                (!request.getServletPath().endsWith(ajaxExtension));

        return callMapperChain ? super.getDecorator(request, page) : null;
    }
}
