<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomeContent.ascx.cs" Inherits="VrtxIntranetPortal.HomeContent.HomeContent" %>

<script type="text/javascript" src="/_layouts/15/init.js"></script>
<script type="text/javascript" src="/_layouts/15/sp.runtime.js"></script>
<script type="text/javascript" src="/_layouts/15/sp.js"></script>
<link href ="/_layouts/15/VrtxIntranetStyles/CSS/craftyslide.css" rel="stylesheet" />
<style>

 .button-india{
	font-size:11px;
	font-weight:bold;
	line-height:16px;
	color:#000;
	text-align:center;
	text-transform:uppercase;
	width:47px;
	margin: 15px 0;
	float:left;
}

.button-india a{
	background:#f16530;
	color:#fff;
	text-decoration:none;
	margin:0;
	padding:8px;

}

.button-india a:hover{
	background:#133d8c;
	color:#FFF;
	text-decoration:none;
	margin:0;
	padding:8px;
}	

.button-usa{
	font-size:11px;
	font-weight:bold;
	line-height:16px;
	color:#000;
	text-align:center;
	text-transform:uppercase;
	width:38px;
	margin: 15px 0;
	position:relative;
	float:left;
}

.button-usa a{
	background:#f16530;
	color:#fff;
	text-decoration:none;
	margin:0;
	padding:8px;

}

.button-usa a:hover{
	background:#133d8c;
	color:#FFF;
	text-decoration:none;
	margin:0;
	padding:8px;
}	


.button-ind-active{
	font-size:11px;
	font-weight:bold;
	line-height:16px;
	color:#000;
	text-align:center;
	text-transform:uppercase;
	width:47px;
	margin: 15px 0;
	position:relative;
	float:left;
}

.button-ind-active a{
	background:#133d8c;
	color:#fff;
	text-decoration:none;
	margin:0;
	padding:8px;

}

.button-usa-active{
	font-size:11px;
	font-weight:bold;
	line-height:16px;
	color:#000;
	text-align:center;
	text-transform:uppercase;
	width:38px;
	margin: 15px 0;
	position:relative;
	float:left;
}

.button-usa-active a{
	background:#133d8c;
	color:#fff;
	text-decoration:none;
	margin:0;
	padding:8px;

}

.button-general{
	font-size:11px;
	font-weight:bold;
	line-height:16px;
	color:#000;
	text-align:left;
	text-transform:uppercase;
	width:150px;
	margin: 15px 0;
	position:relative;
	float:left;
}

</style>

<div class="second-ctr">
   
    <div class="message-area">
          <div class="message-ceo-ctr">
           <div id="slideshow">
        <ul>
          <li>
           <%-- <h2>Message From CEO</h2>--%>
             <img runat="server" id="picture1"     width="100" height="100"  />
            <h3>Organizational Announcement</h3>
           
              <p id="content1" runat="server"  style ="height:270px">
              
              </p>
          
            <div class="button-Readmore"><a href="/SitePages/MoreCEO.aspx" runat="server" target="_blank" >Read more1</a></div>
          </li>
          
          <li>
           <%-- <h2>Message From President</h2>--%>
             <img  id="picture2" runat="server" alt="" width="100" height="100"  />
            <h3>Organizational Announcement</h3>
            <p id="content2" runat ="server" style ="height:270px"></p>
            <div class="button-Readmore"><a href="/SitePages/MoreCEO.aspx" runat="server" target="_blank" >Read more2</a></div>
          </li>
          
           <li>
            <%--<h2>Message From Director</h2>--%>
             <img id="picture3" runat="server"   alt="" width="100" height="100"  />
            <h3>Organizational Announcement</h3>
            <p id="content3" runat="server" style ="height:270px" ></p>
            <div class="button-Readmore"><a  href="/SitePages/MoreCEO.aspx" runat="server" target="_blank" >Read more3</a></div>
          </li>
          
                          
        </ul> 
   </div>
          </div>
        </div>
    <div class="middle-area">

        <div class="holidays">
            <h2>Holidays of the month</h2>
            <div id="Holidays" runat="server" style="height: 150px">
            </div>
            <div  class="button-india" id="divIndiaHoliday">
                <a href="javascript:void(0)" id="btnHolidayIndia">India</a>
            </div>
            <div  class="button-usa"  id="divUSAHoliday">
                <a href="javascript:void(0)" id="btnHolidayUSA">USA</a>
            </div>
            <div class="button-general">
                <a href="#" id="hncMorHoliday" target ="_blank">More Holidays</a>
            </div>

        </div>
        <div class="smalltools">
            <h2>Smart tools</h2>
            <div runat="server" id="divSmart" style="height: 120px"></div>
            <div class="button-india"  id="idSmartIndia"><a href="javascript:void(0)" id="btnSmatToolIndia">INDIA</a></div>

            <div class="button-usa" id="idSmartUsa"><a href="javascript:void(0)" id="btnSmatTooUSA">USA</a></div>
            <div class="button-general"><a href="/SitePages/SmartTools.aspx">More Tools</a></div>
        </div>
    </div>
    <div class="middle-area">
        <div class="home-jobs" style="height:222px">
               <h2>Job Openings @ Vertex</h2>
            <a href="javascript:void(0)" >
                <img src="/_layouts/15/VrtxIntranetStyles/Images/JobOpenings-img.jpg" height="150" width="245" style="border: 0" /></a>
              <div class="button-india" id="divIndiaJob"><a id="ancIndia" href="http://careers.vertexcs.com/" target="_blank">INDIA</a></div>
              <div class="button-usa" id="divUsaJob"><a id="ancUsa" href="http://www.vertexcs.com/current-openings-us" target="_blank">USA</a></div>
            

        </div>
        <!---------Vertical Blocks (wats-new) ------->
        <div class="home-news">
            <h2>What's New @ Vertex</h2>
            <div id="whatsNew" runat="server"></div>
            <div id="divwhatsIndia" class="button-india"><a href="javascript:void(0)" id="btnWhatsNewIndia">INDIA</a></div>
            <div id="divwhatsUsa"  class="button-usa"><a href="javascript:void(0)" id="btnWhatsNewUSA">USA</a></div>
            <div class="button-general"><a href="/SitePages/MoreEvents.aspx">More Events</a></div>
        </div>
    </div>
    <div class="profile-area">
        <div class="profile-area-ctr">
            <h2>Profile of the day</h2>
            <asp:Image ID="imgProfile" runat="server" />
            <h3 id="ProfileHeading" runat ="server" ></h3>
            <p id="ProfileTxt" runat="server" ></p>
            <div class="button-Readmore" id="btnProfile" runat="server" ><a href="#">Read more</a></div>
        </div>
    </div>



</div>
<asp:HiddenField runat ="server" ID="hdnCountry" />


<script src="/_layouts/15/VrtxIntranetStyles/JS/craftyslide.min.js"></script>
<script src="/_layouts/15/VrtxIntranetPortal/IntranetJS/HomeContent.js"></script>
<script>

    $("#slideshow").craftyslide();


    function loadids(cntroltye) {
        var varaid = "";
        if (cntroltye == "SmatTool")
            varaid = ('<%=divSmart.ClientID%>');
        else if (cntroltye == "Holiday")
            varaid = ('<%=Holidays.ClientID%>');
        else if (cntroltye == "WhatsNews")
            varaid = ('<%=whatsNew.ClientID%>');

        else if (cntroltye == "hdnCountry")
            varaid = ('<%=hdnCountry.ClientID%>');

    return varaid;
}
</script>