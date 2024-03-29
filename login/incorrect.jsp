<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Display message indicating password is incorrect, and allow a retry
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>


<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>


<dspace:layout style="submission" navbar="default"
               locbar="nolink"
               titlekey="jsp.login.incorrect.title">


                <%-- <h1>Log In to DSpace</h1> --%>
               

                


    <%-- <p align="center"><strong>The e-mail address and password you supplied were not valid.  Please try again, or have you <a href="<%= request.getContextPath() %>/forgot">forgotten your password</a>?</strong></p> --%>
    <p class="alert alert-danger"><strong><fmt:message key="jsp.login.incorrect.text">
        <fmt:param><%= request.getContextPath() %>/forgot</fmt:param>
    </fmt:message></strong></p>

	<div class="panel panel-primary">
        <div class="panel-heading"><center><h3><strong><fmt:message key="jsp.login.password.heading"/></strong></h3></center>
        
        </div>
    <dspace:include page="/components/login-form.jsp" />
    </div>
</dspace:layout>
