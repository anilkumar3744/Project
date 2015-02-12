<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Company.ascx.cs" Inherits="VrtxIntranetPortal.Company.Company" %>

<SharePoint:CssRegistration runat="server" Name="/_layouts/15/VrtxIntranetStyles/CSS/intranet.css" />
<%--<script type="text/javascript" src=""/>--%>
<%--<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>--%>
<script>

    $(document).ready(function () {
        $(".expandContent").click(function () {
            $("#htmlable").toggle();
        });


    });
    
</script>





<div class="inner-right">
    <div class="right-menu-ctr">
        <div class="right-menu-header">IN THIS PAGE</div>
        <ul>
            <li><a href="../SitePages/Corporate%20Overview.aspx">Corporate Overview</a></li>
            <li><a href="../SitePages/Moreceo.aspx">Message Board</a></li>
            <li><a href="javascript:void(0)">Management Directories</a></li>
            <li class="expandContent"><a href="javascript:void(0)">ODC Service Profiles</a>
                <ul runat="server" id="htmlable" innerhtml='<%#Eval("htmlable")%>'>
                </ul>

            </li>
            <li><a href="../SitePages/CalendarofCorporateEvents.aspx">Calendar of Corporate Events</a></li>
            <!--<li><a href="javascript:void(0)">Company Newsletter</a></li>  -->
            <li><a href="../SitePages/ClientTestimonials.aspx">Client Testimonials</a></li>
        </ul>
        <p><a href="javascript:void(0)">
            <img src="/_layouts/15/VrtxIntranetStyles/Images/archieves.jpg" width="244" height="38" /></a></p>

        <p><a href="javascript:void(0)">
            <img src="/_layouts/15/VrtxIntranetStyles/Images/ask-an-expert.jpg" width="240" height="127" /></a></p>


    </div>



</div>
