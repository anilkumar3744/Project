<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HRManualTalentmanagment.ascx.cs" Inherits="VrtxIntranetPortal.HRManualTalentmanagment.HRManualTalentmanagment" %>

<SharePoint:CssRegistration runat="server" Name="/_layouts/15/VrtxIntranetStyles/CSS/intranet.css" />



<div class="inner-right">
    <div class="right-menu-ctr">
        <div class="right-menu-header">IN THIS PAGE</div>
        <ul>
            <li><a href="../SitePages/EmpDirectory.aspx">Employee Directories</a>

            </li>
            <li class="expandContent"><a class="list-active" href="javascript:void(0)">List of Holidays</a>
                <ul class="htmlable">
                    <li><a class="list-active" href="../SitePages/CurrentHolidays.aspx?ctype=india">India</a></li>
                    <li><a href="../SitePages/CurrentHolidays.aspx?ctype=usa">USA</a></li>
                    <li><a href="../SitePages/CurrentHolidays.aspx?ctype=pg">P&G</a></li>
                </ul>


            </li>
            <li><a href="http://careers.vertexcs.com/jobs/" target="_blank" dir="rtl">Current Openings</a></li>
            <li><a href="javascript:void(0)">Employee Certification</a>
                <ul>
                    <li><a class="list-active" href="../SitePages/EmployeeAchievment.aspx?ctype=Latest">Latest</a></li>
                    <li><a href="../SitePages/EmployeeAchievment.aspx?ctype=Certificate">By Certificate</a></li>
                    <li><a href="../SitePages/EmployeeAchievment.aspx?ctype=user">By User</a></li>
                </ul>

            </li>
            <li><a href="../SitePages/EIS.aspx">Employee Information Systems</a></li>
            <li><a href="javascript:void(0)">Employee Manual - USA</a>

                <ul runat="server" id="usahtmlable" innerhtml='<%#Eval("htmlable")%>'></ul>



            </li>
            <li><a href="javascript:void(0)">Employee Manual - India</a>

                <ul runat="server" id="indiahtml" innerhtml='<%#Eval("htmlable")%>'></ul>



            </li>
            <li><a href="../SitePages/HRNewsletter.aspx">HR Newsletter</a></li>
            <li><a href="../SitePages/TrainingDevelopment.aspx">Training & Development</a></li>
            <li><a href="../SitePages/OrganizationChart.aspx">Organization Chart</a></li>
            <li><a href="../SitePages/downloads.aspx">Downloads</a></li>
            <li><a href="../SitePages/EmpOrentation.aspx">Employee Orientation</a></li>
        </ul>
        <p><a href="javascript:void(0)">
            <img src="/_layouts/15/VrtxIntranetStyles/Images/archieves.jpg" width="244" height="38" /></a></p>

        <p><a href="javascript:void(0)">
            <img src="/_layouts/15/VrtxIntranetStyles/Images/ask-an-expert.jpg" width="240" height="127" /></a></p>


    </div>



</div>
