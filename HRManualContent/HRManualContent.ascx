<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HRManualContent.ascx.cs" Inherits="VrtxIntranetPortal.HRManualContent.HRManualContent" %>

<script type="text/javascript">

    var noSpaceString;
    var hndchangecolour
    function GetDiscriptions(linkText) {
        debugger;
        var text = $(linkText).text();

        var hndClinet = "<%=hdnDummyDescription.ClientID%>";

        $("#" + hndClinet).val(text);

       
        var strDescrition = "<%=btnsubmit.ClientID %>";
        
        
        $("#" + strDescrition).click();
    }
    function Changecolour() {
        debugger;
      
        $("#" + hndchangecolour).css("background-color", "#c3d9eb");

    }
</script>

<asp:UpdatePanel runat="server">
    <ContentTemplate>
        <div style="width: 100%; float: left">
            <table>
                <tr>
                    <td style="width: 35%; vertical-align: top;">
                        <div runat="server" id="policyHtml" style="font-family: Arial, Helvetica, sans-serif; font-size: 12px;" innerhtml='<%#Eval("htmlable")%>'></div>
                    </td>

                    <td style="width: 65%">
                        <div runat="server" id="descriptionHtml" innerhtml='<%#Eval("htmlable")%>'></div>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdnDummyDescription" runat="server" />
            <asp:HiddenField ID="hdchangecolur" runat="server" />
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
<div style="display: none">
    
    <asp:Button Text="text" ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" />
</div>
<asp:Label ID="Label1" runat="server" Visible="false" Text="Label"></asp:Label>
<%--<asp:Button id="btnSubmit"  runat="server" Visible="false" OnClick="Unnamed1_Click" />--%>
 