<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ODCServiceProfiles.ascx.cs" Inherits="vrtxIntranetSol.ODCServiceProfiles.ODCServiceProfiles" %>
<SharePoint:CssRegistration runat="server" Name="/_layouts/15/VrtxIntranetStyles/CSS/intranet.css" />

<div class="inner-left">
        <div class="odcprofile-ctr">
 <h2><asp:Label runat="server" ID="lblTitle"></asp:Label>
</h2>
<asp:Label ID="lblDescription" runat="server"></asp:Label>
<h2>TEAM</h2>
<asp:Repeater ID="RepeaterImages" runat="server">

    <ItemTemplate>
        <div style="float: left;padding:10px;border:solid;border-width:0px;margin:5px">
            <table>
                <tr>
                    <td>
                            <asp:ImageButton ID="ImgUserPic" src='<%#Eval("ProfileTag")%>' runat="server" Width="100" Height="100" />
                        </td>
                </tr>
                <tr>
                    <td style="font-weight:bold">
                    <asp:HyperLink ID="lblFirstName" Text='<%#Eval("Title") %>' runat="server" NavigateUrl='<%# Eval("Title", "/SitePages/ODCServiceProfiles.aspx?username={0}") %>'  Target="_blank" ></asp:HyperLink>
                   <%-- <asp:HyperLink ID="lblUserName" Text='<%#Eval("LastName") %>' runat="server" ></asp:HyperLink>--%>
                    </td>
                </tr>               

            </table>
        </div>
    </ItemTemplate>
</asp:Repeater>
            </div>
    </div>
