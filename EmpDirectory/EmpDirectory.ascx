<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmpDirectory.ascx.cs" Inherits="VrtxIntranetPortal.EmpDirectory.EmpDirectory" %>

<table style="width:100%" id="tblEmpDetails">

</table>
<!--<SharePoint:ScriptLink id="ScriptLink1" runat ="server" Localizable="false" Name="/_layouts/15/VrtxIntranetStyles/JS/jquery-1.8.1.js"></SharePoint:ScriptLink>
<SharePoint:ScriptLink id="ScriptLink2" runat ="server" Localizable="false" Name="/_layouts/15/VrtxIntranetStyles/JS/jquery.dataTables.js"></SharePoint:ScriptLink>
<SharePoint:ScriptLink id="ScriptLink3" runat ="server" Localizable="false" Name="/_layouts/15/VrtxIntranetPortal/IntranetJS/Empdirectory.js"></SharePoint:ScriptLink>-->
<Sharepoint:ScriptLink runat="server" Name="SP.js" Localizable="false" ID="s1" LoadAfterUI="true"/>
 <Sharepoint:ScriptLink runat="server" Name="SP.Runtime.js" Localizable="false" ID="s2" LoadAfterUI="true"/>

<script src="../_layouts/15/VrtxIntranetStyles/JS/jquery-1.8.1.js"></script>
<%--<script type="text/javascript" src="../_layouts/15/init.js"></script>--%>
<script src="../_layouts/15/VrtxIntranetStyles/JS/jquery.dataTables.js"></script>
<script  src="../_layouts/15/VrtxIntranetPortal/IntranetJS/Empdirectory.js"></script>
<SharePoint:CssRegistration runat="server" Name="../_layouts/15/VrtxIntranetStyles/CSS/jquery.dataTables.css" />
