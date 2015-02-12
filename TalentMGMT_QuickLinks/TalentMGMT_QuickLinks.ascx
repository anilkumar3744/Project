<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TalentMGMT_QuickLinks.ascx.cs" Inherits="vrtxIntranetSol.TalentMGMT_QuickLinks.TalentMGMT_QuickLinks" %>
<SharePoint:CssRegistration runat="server" Name="/_layouts/15/VrtxIntranetStyles/CSS/intranet.css" />


<div class="inner-right">
    <div class="right-menu-ctr">
        <div class="right-menu-header">IN THIS PAGE</div>
        <ul>
            <li><a href="#">Employee Directories</a>

            </li>
            <li><a class="list-active" href="#">List of Holidays</a>
                <ul>
                    <li><a class="list-active" href="/SitePages/HOLIDAYS.aspx?ctype=India">India</a></li>
                    <li><a href="/SitePages/HOLIDAYS.aspx?ctype=USA">USA</a></li>
                    <li><a href="/SitePages/HOLIDAYS.aspx?ctype=pg">P&G</a></li>
                </ul>


            </li>
            <li><a href="#">Current Openings</a></li>
            <li><a href="#">Employee Achievements</a></li>
            <li><a href="#">Employee Information Systems</a></li>
            <li><a href="#">HR Manual</a></li>
            <li><a href="#">HR Newsletter</a></li>
            <li><a href="#">Training & Development</a></li>
            <li><a href="#">Organization Chart</a></li>
            <li><a href="#">Downloads</a></li>
            <li><a href="#">Employee Orientation</a></li>
        </ul>
        <p><a href="#">
            <img src="/_layouts/15/VrtxIntranetStyles/Images/archieves.jpg" width="244" height="38" /></a></p>

        <p><a href="#">
            <img src="/_layouts/15/VrtxIntranetStyles/Images/ask-an-expert.jpg" width="240" height="127" /></a></p>

    </div>
</div>




