<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - fragment JSP to be included in site, community or collection home to show discovery facets
  -
  - Attributes required:
  -    discovery.fresults    - the facets result to show
  -    discovery.facetsConf  - the facets configuration
  -    discovery.searchScope - the search scope 
  --%>

<%@page import="org.dspace.discovery.configuration.DiscoverySearchFilterFacet"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.dspace.discovery.DiscoverResult.FacetResult"%>
<%@ page import="java.util.List"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>

<%
	boolean brefine = false;
	
	Map<String, List<FacetResult>> mapFacetes = (Map<String, List<FacetResult>>) request.getAttribute("discovery.fresults");
	List<DiscoverySearchFilterFacet> facetsConf = (List<DiscoverySearchFilterFacet>) request.getAttribute("facetsConfig");
	String searchScope = (String) request.getAttribute("discovery.searchScope");
	if (searchScope == null)
	{
	    searchScope = "";
	}
	
	if (mapFacetes != null)
	{
	    for (DiscoverySearchFilterFacet facetConf : facetsConf)
		{
		    String f = facetConf.getIndexFieldName();
		    List<FacetResult> facet = mapFacetes.get(f);
		    if (facet != null && facet.size() > 0)
		    {
		        brefine = true;
		        break;
		    }
		    else
		    {
		        facet = mapFacetes.get(f+".year");
			    if (facet != null && facet.size() > 0)
			    {
			        brefine = true;
			        break;
			    }
		    }
		}
	}
	if (brefine) {
%>
<div class="col-md-<%= discovery_panel_cols %>">
<div class="panel panel-primary">
<div class="panel panel-heading">
<center><h3 class="facets"><strong><fmt:message key="jsp.search.facet.refine" /></strong></h3></center>
</div>
<div id="facets" class="panel panel-body">
<%
	for (DiscoverySearchFilterFacet facetConf : facetsConf)
	{
    	String f = facetConf.getIndexFieldName();
    	List<FacetResult> facet = mapFacetes.get(f);
 	    if (facet == null)
 	    {
 	        facet = mapFacetes.get(f+".year");
 	    }
 	    if (facet == null)
 	    {
 	        continue;
 	    }
	    String fkey = "jsp.search.facet.refine."+f;
	    int limit = facetConf.getFacetLimit()+1;
	    %><div id="facet_<%= f %>" class="facet col-md-<%= discovery_facet_cols %>">
	    <span class="facetName"><center><strong><fmt:message key="<%= fkey %>" /></strong></center></span>
	    <ul class="list-group"><%
	    int idx = 1;
	    int currFp = UIUtil.getIntParameter(request, f+"_page");
	    if (currFp < 0)
	    {
	        currFp = 0;
	    }
	    if (facet != null)
	    {
		    for (FacetResult fvalue : facet)
		    { 
		        if (idx != limit)
		        {
		        %><li class="list-group-item"><span class="badge"><%= fvalue.getCount() %></span> <a href="<%= request.getContextPath()
		            + searchScope
	                + "/simple-search?filterquery="+URLEncoder.encode(fvalue.getAsFilterQuery(),"UTF-8")
	                + "&amp;filtername="+URLEncoder.encode(f,"UTF-8")
	                + "&amp;filtertype="+URLEncoder.encode(fvalue.getFilterType(),"UTF-8") %>"
	                title="<fmt:message key="jsp.search.facet.narrow"><fmt:param><%=fvalue.getDisplayedValue() %></fmt:param></fmt:message>">
	                <%= StringUtils.abbreviate(fvalue.getDisplayedValue(),36) %></a></li><%
		        }
		        idx++;
		    }
		    if (currFp > 0 || idx > limit)
		    {
		        %><li class="list-group-item"><span style="visibility: hidden;">.</span>
		        <% if (currFp > 0) { %>
		        <a class="pull-left" href="<%= request.getContextPath()
		                + searchScope
		                + "?"+f+"_page="+(currFp-1) %>"><fmt:message key="jsp.search.facet.refine.previous" /></a>
	            <% } %>
	            <% if (idx > limit) { %>
	            <a href="<%= request.getContextPath()
		            + searchScope
	                + "?"+f+"_page="+(currFp+1) %>"><span class="pull-right"><fmt:message key="jsp.search.facet.refine.next" /></span></a>
	            <%
	            }
	            %></li><%
		    }
	    }
	    %></ul></div><%
	}
%></div></div><%
	}
%>