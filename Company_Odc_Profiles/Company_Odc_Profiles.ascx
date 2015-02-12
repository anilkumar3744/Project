<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Company_Odc_Profiles.ascx.cs" Inherits="vrtxIntranetSol.Company_Odc_Profiles.Company_Odc_Profiles" %>
<SharePoint:CssRegistration runat="server" Name="/_layouts/15/VrtxIntranetStyles/CSS/intranet.css" />

<div class="inner-left" style="width=550px">
    <div class="odcprofile-ctr">
        <div class="odcprofile-pic-ctr">
            <asp:Image ID="imgOdcPic" Width="100" Height="100" runat="server" />

        </div>
        <div class="odcprofile-intro-ctr">
            <h2>
                <asp:Label ID="lblFirstName" runat="server" />
                &nbsp
                     <asp:Label ID="lblLastName" runat="server"></asp:Label></h2>
            <p>
                <asp:Label ID="EmpDescription" runat="server"></asp:Label>
            </p>
        </div>
    </div>

    <div class="odcprofile-ctr-2">
        <h3>
            <img src="/_layouts/15/VrtxIntranetStyles/Images/basic-info-icon.png" width="24" height="26" />My Basic Information</h3>

        <div class="odc-basicinfo-grid" style="padding: 5px">
            <table width="100%" border="0" cellspacing="0" cellpadding="8">
                <tr>
                    <td align="left" class="bold-text">Designation</td>
                    <td>:</td>
                    <td>
                        <asp:Label ID="lblDesignation" runat="server"></asp:Label></td>
                    <td align="left" class="bold-text">Home&nbsp;Phone&nbsp;Number</td>
                    <td>:</td>
                    <td>
                        <asp:Label ID="lblhomePhNo" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="bold-text">Mobile&nbsp;Number</td>
                    <td>:</td>
                    <td>
                        <asp:Label ID="lblMobNum" runat="server"></asp:Label></td>
                    <td align="left" class="bold-text">Vertex&nbsp;Email&nbsp;ID</td>
                    <td>:</td>
                    <td>
                        <asp:Label ID="lblEmailID" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="bold-text">ICQ&nbsp;Number</td>
                    <td>:</td>
                    <td>
                        <asp:Label ID="lblICQNo" runat="server"></asp:Label></td>
                    <td align="left" class="bold-text">Extension&nbsp;Number</td>
                    <td>:</td>
                    <td>
                        <asp:Label ID="lblExtNo" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="bold-text">Department</td>
                    <td>:</td>
                    <td>
                        <asp:Label ID="lblDept" runat="server"></asp:Label></td>
                    <td align="left" class="bold-text">DOB</td>
                    <td>:</td>
                    <td>
                        <asp:Label ID="lblDOB" runat="server" Text='<%#Eval("DOB","{0:MMM}") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" class="bold-text" colspan="1">Profile&nbsp;Tagging</td>
                    <td>:</td>

                    <td>
                       <div id="divProfile" runat="server"></div>
                    </td>
                </tr>
            </table>
        </div>
        <h3>
            <img src="/_layouts/15/VrtxIntranetStyles/Images/Personal information.png" width="24" height="24" />My Personal Information</h3>

        <div class="question1">
            <p class="bold-text">Overview (DOJ, Experience)	</p>
            <p>
                <asp:Label runat="server" ID="lblOverView"></asp:Label>
            </p>
        </div>

        <div class="question2">
            <p class="bold-text">
                Forte (Skill Set) : 
                       <p>
                           <asp:Label runat="server" ID="lblForte"></asp:Label>
                       </p>
        </div>

        <div class="question1">
            <p class="bold-text">About My Spouse/Significant Other &amp; Children :	</p>
            <p>
                <asp:Label runat="server" ID="lblSpouse"></asp:Label>
            </p>
        </div>

        <div class="question2">
            <p class="bold-text">What I like to do when I kick Back-My Hobbies :</p>
            <p>
                <asp:Label runat="server" ID="lblHobbies"></asp:Label>
            </p>
        </div>

        <div class="question1">
            <p class="bold-text">What am I reading now? What's the Best Book I've read? :</p>
            <p>
                <asp:Label runat="server" ID="lblBestBook"></asp:Label>
            </p>
        </div>

        <div class="question2">
            <p class="bold-text">Who inspired me the most &amp; Why? :</p>
            <p>
                <asp:Label runat="server" ID="lblInspired"></asp:Label>
            </p>
        </div>

        <div class="question1">
            <p class="bold-text">Things I love about the jobs that I've had :</p>
            <p>
                <asp:Label runat="server" ID="lblJob"></asp:Label>
            </p>
        </div>

        <div class="question2">
            <p class="bold-text">What makes me tick :</p>
            <p>
                <asp:Label runat="server" ID="lblTick"></asp:Label>
            </p>
        </div>

        <div class="question1">
            <p class="bold-text">How I spend a Lazy Afternoon :	</p>
            <p>
                <asp:Label runat="server" ID="lblAfternoon"></asp:Label>
            </p>
        </div>

        <div class="question2">
            <p class="bold-text">The Best Restaurant That I've ever eaten at :</p>
            <p>
                <asp:Label runat="server" ID="lblRestaurant"></asp:Label>
            </p>
        </div>

        <div class="question1">
            <p class="bold-text">My Favorite Foods :</p>
            <p>
                <asp:Label runat="server" ID="lblFoods"></asp:Label>
            </p>
        </div>

        <div class="question2">
            <p class="bold-text">I am Most Proud of :</p>
            <p>
                <asp:Label runat="server" ID="lblProud"></asp:Label>
            </p>
        </div>

        <div class="question1">
            <p class="bold-text">The Most intresting thing/place that I have seen :</p>
            <p>
                <asp:Label runat="server" ID="lblIntrestes"></asp:Label>
            </p>
        </div>

        <div class="question2">
            <p class="bold-text">If I could change anything about the world :	</p>
            <p>
                <asp:Label runat="server" ID="lblWorldChange"></asp:Label>
            </p>
        </div>

        <div class="question1">
            <p class="bold-text">The sports team that I follow are :</p>
            <p>
                <asp:Label runat="server" ID="lblSports"></asp:Label>
            </p>
        </div>

        <div class="question2">
            <p class="bold-text">The Music I Listen to :</p>
            <p>
                <asp:Label runat="server" ID="lblMusic"></asp:Label>
            </p>
        </div>

        <div class="question1">
            <p class="bold-text">My Favorite TV Show :</p>
            <p>
                <asp:Label runat="server" ID="lblFavoriteTV"></asp:Label>
            </p>
        </div>

        <h3>
            <img src="/_layouts/15/VrtxIntranetStyles/Images/certification.png" width="24" height="24" />My Certifications</h3>
        <div class="certification-ctnr">
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <asp:GridView ID="GvCertificates" Width="710px" runat="server" AutoGenerateColumns="false" DataKeyNames="ID" CssClass="certification-grid">
                    <AlternatingRowStyle CssClass="certification-grid1" BorderWidth="0" />
                    <%--<RowStyle CssClass="certification-grid2" BorderWidth="0" />--%>
                    <HeaderStyle HorizontalAlign="Left" Height="20px" CssClass="grid-header" />
                     
                    <Columns>

                        <asp:TemplateField HeaderText="S.no" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ID" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server" Text='<%#Eval("ID")%>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Technology" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblTechnology" runat="server" Text='<%#Eval("Technology")%>' CssClass="certification-grid"></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="Certification ID" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server" Text='<%#Eval("CertificationID") %>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Name of Certificate" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblNameofCertificate" runat="server" Text='<%#Eval("Certificate") %>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Certified Date" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblCertifiedDate" runat="server" Text='<%#Eval("CertifiedDate","{0:d}") %>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Until Date" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblUntilDate" runat="server" Text='<%#Eval("UntilDate","{0:d}")%>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User Name" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("UserName") %>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </table>
        </div>
    </div>
</div>








