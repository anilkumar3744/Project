<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmployeeAchievements.ascx.cs" Inherits="VrtxIntranetPortal.EmployeeAchievements.EmployeeAchievements" %>








<SharePoint:CssRegistration runat="server" Name="/_layouts/15/VrtxIntranetStyles/CSS/intranet.css" />

<script type="text/javascript" >

    function CheckReportsTo(source, arguments) {
        if (aspnetForm.ctl00_ctl41_g_257a10db_160e_41de_b98e_8a6ae44da70d_pplContarctEmp_containerCell_downlevelTextBox.value == "")
            arguments.IsValid = false;
        else
            arguments.IsValid = true;

    }

    function vlaiddatePeoplePickr()
    {
        debugger;
        var sttPeople = "#" + "<%=pplContarctEmp.ClientID %>";
        var sttPeopledior = $(sttPeople)
        var strng = $('ctl00_ctl41_g_257a10db_160e_41de_b98e_8a6ae44da70d_pplContarctEmp_downlevelTextBox');
        ctl00_ctl41_g_257a10db_160e_41de_b98e_8a6ae44da70d_pplContarctEmp_downlevelTextBox
        if (strng.text() == "")
        {
            alert("Please enter user name");
            return false;
        }
        
        return true;
      

    }
   
    function validatedDropdown()
    {
        //debugger;
        var strFoll = "#" + "<%=ddlTechnologies.ClientID %>";
        if ($(strFoll).get(0).selectedIndex == 0) {
            alert("Please select Technologies ");
            $(strFoll).focus();
            return false;
        }
        else { return true;}


    }
  
    </script> 

<div id="peoplePicker" runat="server" Visible="false">
    <table>

        <tr >
            <td style="padding-left: 335px;"">
                 <asp:Label Text="Select User" ID="lblSelectuser" runat="server" />
            </td>
            <td style=" padding-bottom: 6px;">
               
                <SharePoint:PeopleEditor ID="pplContarctEmp" runat="server"  Height="21px"    Width="300px" MultiSelect="false" ValidatorEnabled="false" EnableBrowse="true"  
                                AllowEmpty="false" />

            </td>
            <td>
                <asp:Button id="peoplePickerbutton" Text="Submit" runat="server" OnClick="peoplePickerbutton_Click"  />
            </td>
        </tr>
    </table> 
    
</div>
<div id="peoplepickerByCertification" runat="server" visible="false">
    <table>
        <tr>

            <td>

                <asp:Label Text="Technologies : " runat="server" />

            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlTechnologies" OnSelectedIndexChanged="ddlTechnologies_OnSelectedIndexChanged" Width ="200px" AutoPostBack="true">
                    
                </asp:DropDownList>&nbsp;<span style ="color:red;font-size:17px">*</span>
            </td>
            <tr>
            <td>

                <asp:Label Text="Certifications : " runat="server" />

            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlCertifications" Width ="200px">
                    <asp:ListItem Text="Select" Value="0" /> 
                </asp:DropDownList>
            </td>
            
        </tr>
        <tr>
           <td colspan ="2">
                 <asp:Button id="btnpeoplepickerByCertification" Text="Submit" runat="server" OnClick="btnpeoplepickerByCertification_Click"  OnClientClick ="return validatedDropdown() " />
            </td>
        </tr>
    </table>
</div>
<asp:GridView ID="gvEmpAchievements" runat="server" AutoGenerateColumns="false" BorderStyle="None"   GridLines="None" Width ="100%" >

    <Columns>
        <asp:TemplateField HeaderText="" >
            <ItemTemplate>

                <table style="background-color: #f7f7f7; overflow: hidden; text-align: center; margin-bottom: 10px; margin-left: 0px; " >
                    <tr>
                        <td>
                            <table style="width:100%" >
                                <tr>

                                    <td>
                                        
                                    <a style="text-decoration: none;" href='<%# Eval("Title", "/SitePages/ODCServiceProfiles.aspx?username={0}") %>'>  <asp:Image ID="imgImage" runat="server"  Height="100" Width="100" ImageUrl='<%# Eval("Attachments")%>' /></a>
                                    
                                    </td>
                                </tr>
                                <tr>
                                    <td>

                                        <asp:HyperLink ID="HyperLink2" NavigateUrl='<%# Eval("Title", "/SitePages/ODCServiceProfiles.aspx?username={0}") %>' Text='<%# Eval("Title")%>' Target="_blank" runat="server"></asp:HyperLink>
                                        <%--<asp:Label ID="lblEmpName" Text='<%#Eval("Title")%>' runat="server"></asp:Label>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDesignation" Text='<%#Eval("Designation")%>' runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>

                        <td style="vertical-align:top;width:100%" >

                            <div runat="server" id="htmlable" innerhtml='<%#Eval("htmlable")%>'></div>

                        </td>
                    </tr>
                </table>

            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<table style="text-align:center;width:100%">
    <tr>
        <td>
            <asp:Label ID="errorMsg" runat="server" Visible ="false" style="font-weight:bold;font-size:17px"></asp:Label>
        </td>

    </tr>

</table>


