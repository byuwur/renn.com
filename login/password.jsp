<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Page that displays the email/password login form
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<dspace:layout navbar="default" locbar="off" titlekey="jsp.login.password.title" nocache="true">
	<div class="panel panel-primary">
        <div class="panel-heading"> <center><h3><strong><fmt:message key="jsp.login.password.heading"/></strong></h3></center>
        
        </div>
	    <dspace:include page="/components/login-form.jsp" />
    </div>
</dspace:layout>
