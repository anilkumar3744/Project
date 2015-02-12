<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmpHistoryForm.ascx.cs" Inherits="vrtxIntranetSol.EmpHistoryForm.EmpHistoryForm" %>
<%@ Register Assembly="AjaxControlToolkit, Version=3.0.30930.28736, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e"
    Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<SharePoint:ScriptLink Name="../_layouts/15/VrtxIntranetStyles/JS/jquery-1.8.1.js" runat="server"></SharePoint:ScriptLink>
<SharePoint:CssRegistration runat="server" Name="/_layouts/15/VrtxIntranetStyles/CSS/intranet.css" />
<style>
    .editCertificates {
    }
     .deleteCertificate {
    }

    /*.emp-button {
        background-color: #f16530;
        border: #f16530 solid 1px;
        color: #FFF;
        padding: 5px;
        margin: 0 5px 0 0;
        
    }*/

    .input[type=button], input[type=reset], input[type=submit], button {
        background-color: #f16530;
        border: #f16530 solid 1px;
        color: #FFF;
        padding: 5px;
        margin: 0 5px 0 0;
    }        .input[type=button]:hover, input[type=reset]:hover, input[type=submit]:hover, button:hover {
            background-color: #f16530;
            border: #f16530 solid 1px;
            color: #FFF;
            padding: 5px;
            margin: 0 5px 0 0;
            cursor: pointer;
        }
    .body, td, th {
        font-family: Arial,Helvetica, sans-serif;
        font-size: 12px;
    }
</style>
<script type="text/javascript">

    $(document).ready(function () {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(AddNewCertificate);
        AddNewCertificate();

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(updateCertification);
        updateCertification();

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(ValueRetainResource);
        ValueRetainResource();

        DivCollandExpand();
        //checkUserName();


    });



    function ICQNumber() {
        //debugger;
        var str = "#" + "<%= txtICQNo.ClientID %>";

        if (jQuery.trim($(str).val()).length > 9) {
            alert("Pls enter 9 digit number");
            $(str).focus();
            return false;
        }
        return true;
    }

    function ExtNumberFor4Digits(e) {
        var str = $("<%=txtExtNo.ClientID%>");
        if (jQuery.trim($(str).val()).value > 4) {
            if (String.fromCharCode(e.keyCode).match(/^[a-zA-Z$&+,:;=?@#|'<>.-^*()%!]$/g))
                return false;
            else
                return true;
        }
    }

    function ExtNumber() {
        var str = "#" + "<%= txtExtNo.ClientID %>";

        if (jQuery.trim($(str).val()).length > 4 && String.fromCharCode(e.keyCode).match(/^[a-zA-Z$&+,:;=?@#|'<>.-^*()%!]$/g)) {
            alert("Pls enter 4 digit number");
            $(str).focus();
            return false;
        }

    }


    function checkFirstName() {
        //debugger;
        var FirstNameReg = /^[a-zA-Z\s]+$/;
        var FNameVal = $("#<%=txtFirstName.ClientID %>").val();
        if (FNameVal != '') {
            if (!FirstNameReg.test(FNameVal)) {
                alert("Enter a valid FirstName.");
                $("#<%=txtFirstName.ClientID %>").focus();
                return false;
            }
        }
    }

    function checkLastName() {
        var LastNameReg = /^[a-zA-Z-_\s]+$/;
        var LNameVal = $("#<%=txtLastName.ClientID %>").val();
        if (LNameVal != '') {
            if (!LastNameReg.test(LNameVal)) {
                alert("Enter a valid LastName.");
                $("#<%=txtLastName.ClientID %>").focus();
                return false;
            }
        }

    }
    function numbersonly(e) {

        var unicode = e.charCode ? e.charCode : e.keyCode
        var stVal = e.srcElement.value;
        if (unicode == 46) {
            if (unicode == 46 && stVal.indexOf('.') != -1)
                return false;

            else
                return true;
        }

        if (unicode != 8) {
            if (unicode < 48 || unicode > 57) {
                alert("please enter Numbers");
                return false;
            }
        }

    }
    function DivCollandExpand() {

        $("#tdbasic").click(function () {
            if ($("#tdbasic").html() == "+ Employee Basic Information") {
                $("#trBasic").show();
                $("#tdbasic").html("- Employee Basic Information");
            }

            else {
                $("#trBasic").hide();
                $("#tdbasic").html("+ Employee Basic Information");
            }


        });
        $("#tdEmpAddtionalDeatails").click(function () {
            if ($("#tdEmpAddtionalDeatails").html() == "+ Employee additional Information") {
                $("#trEmpAddtionalDeatails").show();
                $("#tdEmpAddtionalDeatails").html("- Employee additional Information");
            }

            else {
                $("#trEmpAddtionalDeatails").hide();
                $("#tdEmpAddtionalDeatails").html("+ Employee additional Information");
            }


        });

        $("#tdcertifications").click(function () {
            if ($("#tdcertifications").html() == "+ Employee Certification Details") {
                $("#trcertifications").show();
                $("#tdcertifications").html("- Employee Certification Details");
            }

            else {
                $("#trcertifications").hide();
                $("#tdcertifications").html("+ Employee Certification Details");
            }


        });

    }
    function isDate(txtDate) {
        var currVal = txtDate;
        if (currVal == '')
            return false;

        var rxDatePattern = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/; //Declare Regex
        var dtArray = currVal.match(rxDatePattern); // is format OK?

        if (dtArray == null)
            return false;

        //Checks for mm/dd/yyyy format.
        dtMonth = dtArray[1];
        dtDay = dtArray[3];
        dtYear = dtArray[5];

        if (dtMonth < 1 || dtMonth > 12)
            return false;
        else if (dtDay < 1 || dtDay > 31)
            return false;
        else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
            return false;
        else if (dtMonth == 2) {
            var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
            if (dtDay > 29 || (dtDay == 29 && !isleap))
                return false;
        }
        return true;
    }
    function checkCurrentDate(sender, args) {
        // debugger;
        var CurrentDate = new Date();
        var SelectedDate = new Date($('[id$=txtOnePageReportStartDate]').val());

        if (CurrentDate == SelectedDate) {
            alert("Date of birth should  be less than Today's date");
            $(SelectedDate).focus();
            return false;
        }

        var startDatePM = $("#<%=txtOnePageReportStartDate.ClientID %>");
        var strRel = new Date();
        if (Date.parse(strRel) < Date.parse((startDatePM).val())) {
            alert("Date of birth should not be greater than Todays date");
            $(startDatePM).focus();
            return false;
        }
    }


    function checkDate(sender, args) {
        //debugger;
        var startDatePM = $("#<%=txtCertifiedDate.ClientID %>");
        var strRel = $("#<%=txtUntilDate.ClientID %>");
        var DoB = $("#<%=txtOnePageReportStartDate.ClientID%>");

        if (jQuery.trim($(startDatePM).val()) != "") {
            if (!isDate(jQuery.trim($(startDatePM).val()))) {
                alert('Invalid start date');
                $(startDatePM).focus();
                return false;
            }
        }
        else {
            alert('Please enter start date');
            $(startDatePM).focus();
            return false;

        }
        if (jQuery.trim($(strRel).val()) != "") {
            if (!isDate(jQuery.trim($(strRel).val()))) {
                alert('Invalid Release Date');
                $(strRel).focus();
                return false;
            }
            else {
                if ($(startDatePM).val() == "") {
                    alert("Start Date should not be empty if Release Date is Entered");
                    $(startDatePM).focus();
                    return false;
                }
            }
        }

        if (Date.parse($(strRel).val()) < Date.parse($(startDatePM).val())) {
            alert("End date should not be less than start date");
            $(strRel).focus();
            return false;
        }

        var CurrentDate = new Date();
        var SelectedDate = new Date($('[id$=txtCertifiedDate]').val());



        if (CurrentDate > SelectedDate) {
            //CurrentDate is more than SelectedDate
        }
        else {
            alert("Certified date should  be less than current date");
            $(SelectedDate).focus();
            return false;
        }
    }

    function ValueRetainResource() {
        //debugger;
        var hdnfieldUtil = $("#<%=hdnAssignUtil.ClientID %>").val();
        if (hdnfieldUtil == 1) {
            $("#<%=txtCerificateEdit.ClientID %>").val($("#<%=hdnEditId.ClientID %>").val());
            ShowDialogProgram(true);
            $("#<%=drpTechnology.ClientID %>").val($("#<%=hdnTechnology.ClientID %>").val());
            $("#<%=drpNameOfCertification.ClientID %>").val($("#<%=hdnNameOfCertification.ClientID %>").val());
            $("#<%=txtCertificationID.ClientID %>").val($("#<%=hdnCertificationID.ClientID %>").val());
            $("#<%=txtUntilDate.ClientID %>").val($("#<%=hdnEndDate.ClientID %>").val());
            $("#<%=txtCertifiedDate.ClientID %>").val($("#<%=hdnStartDate.ClientID %>").val());
            $("#<%=HlnCertificate.ClientID %>").val($("#<%=hdnAttachment.ClientID %>").val());
        }

    }

    function ShowDialogProgram(modal) {
        //debugger;
        var idUtil = $("#<%=txtCerificateEdit.ClientID %>").val();
        if (idUtil != "") {
            $("#<%= btnSubmit.ClientID %>").hide();
            $("#<%= btnUpdate.ClientID %>").show();
        }
        else {
            $("#<%= btnSubmit.ClientID %>").show();
            $("#<%= btnUpdate.ClientID %>").hide();
        }
        $("#<%=HlnCertificate.ClientID%>").hide();
        $("#<%=drpTechnology.ClientID %>").get(0).selectedIndex = 0
        $("#<%=drpNameOfCertification.ClientID %>").get(0).selectedIndex = 0
        $("#<%=txtCertifiedDate.ClientID %>").val("");
        $("#<%=txtUntilDate.ClientID %>").val("");
        $("#<%= txtCertificationID.ClientID %>").val("");
        $("#<%=txtCertifiedDate.ClientID %>").attr('readonly', true);
        $("#<%=txtUntilDate.ClientID %>").attr('readonly', true);
        $("#CertificationDiv").fadeIn(300);
    }
    function HideDialogProgram() {
        $("#CertificationDiv").fadeOut(300);
        $("#<%=hdnEditId.ClientID %>").val("")[0].value;


    }
    function AddNewCertificate() {
        //debugger;
        $("#btnCertificate").click(function (e) {
            $("#<%=hdnTechnology.ClientID%>").val("");
            $("#<%=hdnNameOfCertification.ClientID%>").val("");
            $("#<%=hdnCertificationID.ClientID%>").val("");
            $("#<%=hdnStartDate.ClientID%>").val("");
            $("#<%=hdnEndDate.ClientID%>").val("");
            $("#<%=hdnAttachment.ClientID%>").val("");
            ShowDialogProgram(true);
            e.preventDefault();
        });

        $(".editCertificates").click(function (e) {
            //debugger;
            var iRecordId = $(this).attr("id");
            $("#<%=txtCerificateEdit.ClientID %>").val(iRecordId);
            $("#<%=btnhiddenCertificateEdit.ClientID %>").click();
        });

        $(".deleteCertificate").click(function (e) {
            // debugger;
            var record_id = $(this).attr("id");
            $("#<%=txtCertificateDelete.ClientID %>").val(record_id);
            if (confirm("Do you want to delete this record?")) {
                $("#<%= btnhiddenCertifiDelete.ClientID %>").click();
            }

        });

        $("#btnProgramClose").click(function (e) {
            HideDialogProgram();
            e.preventDefault();

        });

        $("#btnClear").click(function (e) {
            $("#<%=drpTechnology.ClientID %>").get(0).selectedIndex = 0
            $("#<%=drpNameOfCertification.ClientID %>").get(0).selectedIndex = 0
            $("#<%=txtCertifiedDate.ClientID %>").val("");
            $("#<%=txtCertificationID.ClientID %>").val("");
            $("#<%=txtUntilDate.ClientID %>").val("");
            $("#<%=HlnCertificate.ClientID%>").hide();
        });

        $("#btnClearDetails").click(function (e) {
            $("#<%=txtFirstName.ClientID %>").val("");
            $("#<%=txtLastName.ClientID %>").val("");
            $("#<%=txtResPhNo.ClientID %>").val("");
            $("#<%=txtMobNo.ClientID %>").val("");
            $("#<%=txtICQNo.ClientID %>").val("");
            $("#<%=txtExtNo.ClientID %>").val("");
            $("#<%=drpCountry.ClientID %>").get(0).selectedIndex = 0
            $("#<%=txtOnePageReportStartDate.ClientID %>").val("");
            $("#<%=drpDept.ClientID %>").get(0).selectedIndex = 0
            $("#<%=drpDesignation.ClientID %>").get(0).selectedIndex = 0
            $("#<%=txtOverView.ClientID %>").val("");
            $("#<%=txtForte.ClientID %>").val("");
            $("#<%=txtMySpouse.ClientID %>").val("");
            $("#<%=txtMyHobbies.ClientID %>").val("");
            $("#<%=txtBestBooks.ClientID %>").val("");
            $("#<%=txtAboutJob.ClientID %>").val("");
            $("#<%=txtMakesMeTick.ClientID %>").val("");
            $("#<%=txtFavFods.ClientID %>").val("");
            $("#<%=txtBestReat.ClientID %>").val("");
            $("#<%=txtFavTV.ClientID %>").val("");
            $("#<%=txtmusIListen.ClientID %>").val("");
            $("#<%=txtProudOf.ClientID %>").val("");
            $("#<%=txtSptTmIFoll.ClientID %>").val("");
            $("#<%=txtLazyNon.ClientID %>").val("");
            $("#<%=txtICudChgWorld.ClientID %>").val("");
            $("#<%=txtInspiredMe.ClientID %>").val("");
            $("#<%=txtInterstingThings.ClientID %>").val("");
            $("#<%=ImgUserPic.ClientID%>").hide();
            $("#<%=FuploadUserPic.ClientID%>").val('');
        });
    }


    function clearCertificates() {
        $("#<%=drpTechnology.ClientID %>").get(0).selectedIndex = 0
        $("#<%=drpNameOfCertification.ClientID %>").get(0).selectedIndex = 0
        $("#<%=txtCertificationID.ClientID %>").val("");
        $("#<%=txtCertifiedDate.ClientID %>").val("");
        $("#<%=txtUntilDate.ClientID %>").val("");
        return false;

    }

    function updateCertification() {
        // debugger;
        var id = $("#<%=txtCerificateEdit.ClientID %>").val();
        var emptyId = "";
        $("#<%=txtCerificateEdit1.ClientID %>").val(id);
        $("#<%=txtCerificateEdit.ClientID %>").val(emptyId);
        if (id != "") {
            $("#<%= btnSubmit.ClientID %>").hide();
            $("#<%= btnUpdate.ClientID %>").show();
            $("#CertificationDiv").fadeIn(300);

        }
        <%--else {
            $("#<%=drpTechnology.ClientID %>").get(0).selectedIndex = 0
            $("#<%=drpNameOfCertification.ClientID %>").get(0).selectedIndex = 0
            $("#<%=txtCertifiedDate.ClientID %>").val("");
            $("#<%=txtUntilDate.ClientID %>").val("");
            $("#<%=txtCertificationID.ClientID %>").val("");
            $("#<%= btnSubmit.ClientID %>").show();
            $("#<%= btnUpdate.ClientID %>").hide();
        }--%>


    }
    function compareDate() {
        // debugger;
        // In JQuery
        var dateEntered = $("txtOnePageReportStartDate").val();
        var dateToCompare = dateEntered;
        var currentDate = new Date();

        if (dateToCompare == currentDate) {
            alert("Date should not be Current Date ");
            $("#<%=txtOnePageReportStartDate.ClientID %>").focus();
            return false;
        }

    }
    function validateEmpForm() {

        var strFirstName = "#" + "<%= txtFirstName.ClientID %>";
        if (jQuery.trim($(strFirstName).val()) == "") {
            alert('Please enter First Name ');
            $(strFirstName).focus();
            return false
        }

        var strLastName = "#" + "<%= txtLastName.ClientID %>";
        if (jQuery.trim($(strLastName).val()) == "") {
            alert('Please enter Last Name ');
            $(strLastName).focus();
            return false
        }

        var strMobNo = "#" + "<%= txtMobNo.ClientID %>";
        if (jQuery.trim($(strMobNo).val()) == "") {
            alert('Please enter Mobile number ');
            $(strMobNo).focus();
            return false
        }



        var strIcq = "#" + "<%= txtICQNo.ClientID %>";
        if (jQuery.trim($(strIcq).val()) == "") {
            alert('Please enter ICQ number ');
            $(strIcq).focus();
            return false
        }



        var strDesig = "#" + "<%= drpDesignation.ClientID %>";
        if ($(strDesig).get(0).selectedIndex == 0) {
            alert("Please select Designation");
            $(strDesig).focus();
            return false;
        }
        var strDoB = "#" + "<%= txtOnePageReportStartDate.ClientID %>";


        if (jQuery.trim($(strDoB).val()) == "") {

            alert('Please enter Date f Birth');
            $(strDoB).focus();
            return false;
        }
        var CurrentDate = new Date();
        var SelectedDate = new Date($('[id$=txtOnePageReportStartDate]').val());

        if (CurrentDate > SelectedDate) {
            //CurrentDate is more than SelectedDate
        }
        else {
            alert("Date of birth should  be less than current date");
            $(strDoB).focus();
            return false;
        }




        var strdept = "#" + "<% =drpDept.ClientID %>";
        if ($(strdept).get(0).selectedIndex == 0) {
            alert('please enter Department');
            $(strdept).focus();
            return false;
        }
        var strcountry = "#" + "<% = drpCountry.ClientID %>";
        if ($(strcountry).get(0).selectedIndex == 0) {
            alert('please enter Country');
            $(strcountry).focus();
            return false;
        }


        var strOverView = RTE_GetRichEditTextOnly("<%= txtOverView.ClientID %>");

        if (strOverView == "") {

            alert('Please enter OverView');

            //set focus back to the rich text editor.
            RTE_GiveEditorFocus("<%= txtOverView.ClientID %>");
            return false;
        }



        var strForte = RTE_GetRichEditTextOnly("<%= txtForte.ClientID %>");

        if (strForte == "") {
            alert('Please enter Skills');

            //set focus back to the rich text editor.
            RTE_GiveEditorFocus("<%= txtForte.ClientID %>");
            return false;
        }




        return true;
    }


    // validating certifications
    function validateCertification() {

        var strTechnology = "#" + "<%=drpTechnology.ClientID%>";
        if ($(strTechnology).get(0).selectedIndex == 0) {
            alert('please enter Technology');
            $(strTechnology).focus();
            return false;
        }
        var strName = "#" + "<%=drpNameOfCertification.ClientID%>";
        if ($(strName).get(0).selectedIndex == 0) {
            alert('please enter Name of certification');
            $(strName).focus();
            return false;
        }

        return true;
    }


</script>

<style type="text/css">
    .chweb_dialog {
        display: none;
        position: fixed;
        width: 550px;
        top: 40%;
        left: 40%;
        margin-left: -190px;
        margin-top: -100px;
        background-color: #ffffff;
        border: 2px solid #336699;
        padding: 0px;
        z-index: 102;
        font-family: Verdana;
        font-size: 10pt;
    }

    .chweb_dialog_title {
        border-bottom: solid 2px #84a0c7;
        background-color: #84a0c7;
        padding: 4px;
        color: White;
        font-weight: bold;
        text-align: center;
    }

        .chweb_dialog_title a:hover {
            color: White;
            text-decoration: none;
        }

        .chweb_dialog_title a {
            color: White;
            text-decoration: none;
        }

            .chweb_dialog_title a:link {
                color: White;
                text-decoration: none;
            }

    .auto-style1 {
        background-color: #CCC;
        font-size: 13px;
        font-weight: bold;
        color: #133d8c;
        text-transform: uppercase;
        height: 30px;
        cursor: pointer;
    }
</style>

<%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>

<div style="padding-left: 190px">

    <table style="width: 835px; border: 0; cellspacing: 0px; cellpadding: 10px; align: center;">
        <tr>
            <td id="tdbasic" class="auto-style1">-Employee Basic Information</td>
        </tr>
        <tr id="trBasic">
            <td style="vertical-align: top; align-content: center" class="empform-ctr">

                <table style="border: 0" cellspacing="0" cellpadding="5">
                    <tr>
                        <asp:TextBox ID="txtHiddenBasicInfo" runat="server" Visible="false"></asp:TextBox>
                    </tr>
                    <tr>
                        <asp:Image ID="ImgUserPic" runat="server" Height="100px" Width="100px" />

                    </tr>
                    <tr>
                        <td align="right">First Name :  </td>
                        <td align="left">
                            <label for="txtFirstName"></label>
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="emp-textbox"></asp:TextBox>&nbsp;<span
                                style="color: Red">*</span>
                        </td>
                        <td width="30" align="right">&nbsp;</td>
                        <td align="right">Last Name : </td>

                        <td>
                            <label for="txtLastName"></label>

                            <asp:TextBox ID="txtLastName" runat="server" CssClass="emp-textbox"></asp:TextBox>&nbsp;<span
                                style="color: Red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Mobile&nbsp;Number :
                        </td>
                        <td align="left">
                            <label for="txtMobNo"></label>
                            <asp:TextBox ID="txtMobNo" runat="server" CssClass="emp-textbox" MaxLength="12"></asp:TextBox>&nbsp;<span
                                style="color: Red">*</span>
                        </td>
                        <td width="30" align="right">&nbsp;</td>
                        <td align="right">Home&nbsp;Phone&nbsp;Number :
                        </td>
                        <td>
                            <label for="txtResPhNo"></label>
                            <asp:TextBox ID="txtResPhNo" CssClass="emp-textbox" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">ICQ Number:
                        </td>
                        <td align="left">
                            <label for="txtICQNo"></label>
                            <asp:TextBox ID="txtICQNo" runat="server" CssClass="emp-textbox" MaxLength="9"></asp:TextBox>&nbsp;<span
                                style="color: Red">*</span>
                        </td>
                        <td width="30" align="right">&nbsp;</td>

                        <%--<td align="right">Vertex Email ID
                        </td>
                        <td>
                            <label for="txtEmailID"></label>
                            <asp:TextBox ID="txtEmailID" runat="server" class="emp-textbox"></asp:TextBox>
                        </td>--%>
                        <td align="right">Extension&nbsp;Number :
                        </td>
                        <td>
                            <label for="txtExtNo"></label>
                            <asp:TextBox ID="txtExtNo" runat="server" CssClass="emp-textbox" MaxLength="4"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Designation :
                        </td>
                        <td align="left">
                            <label for="drpDesignation"></label>
                            <label for="select"></label>
                            <asp:DropDownList ID="drpDesignation" runat="server" CssClass="emp-Dropdown">
                            </asp:DropDownList>&nbsp;<span
                                style="color: Red">*</span>
                        </td>
                        <td width="30" align="right">&nbsp;</td>
                        <td align="right">DOB :</td>
                        <td>
                            <label for="txtOnePageReportStartDate"></label>
                            <asp:TextBox ID="txtOnePageReportStartDate" CssClass="emp-textbox" runat="server"></asp:TextBox>&nbsp;<span
                                style="color: Red">*</span>
                            <cc1:CalendarExtender ID="CalendarExtender1" TargetControlID="txtOnePageReportStartDate" runat="server" FirstDayOfWeek="Default" OnClientDateSelectionChanged="checkCurrentDate">
                            </cc1:CalendarExtender>
                            <%--<script>$("#<%=txtOnePageReportStartDate.ClientID %>").attr('readonly', true);</script>--%>

                        </td>


                    </tr>
                    <tr>
                        <td align="right">Department :<br />
                        </td>
                        <td align="left">
                            <label for="drpDept"></label>
                            <label for="select2"></label>
                            <asp:DropDownList ID="drpDept" CssClass="emp-Dropdown" runat="server">
                            </asp:DropDownList>&nbsp;<span
                                style="color: Red">*</span>
                        </td>
                        <td width="30" align="right">&nbsp;</td>
                        <td align="right">Country :</td>
                        <td>
                            <label for="drpCountry"></label>
                            <label for="select2"></label>
                            <asp:DropDownList ID="drpCountry" runat="server" CssClass="emp-Dropdown">
                            </asp:DropDownList>
                            &nbsp;<span style="color: Red">*</span>

                        </td>
                    </tr>



                    <tr>
                        <td align="left">Upload&nbsp;Profile&nbsp;Picture :
                        </td>
                        <td align="left" colspan="4">
                            <label for="FuploadUserPic"></label>
                            <asp:FileUpload ID="FuploadUserPic" runat="server" CssClass="emp-Attachment" />
                        </td>

                        <asp:HiddenField ID="hdnPic" runat="server" />

                    </tr>
                    <tr>
                        <td align="left">Profile&nbsp;Tagging:</td>
                        <td colspan="4">
                            <label for="ChkProfilesTags"></label>
                            <%--<label for="select2"></label>--%>
                            <asp:Panel ID="PnlProfileTags" runat="server">
                                <%-- <div id="childDiv" runat="server"></div>--%>
                            </asp:Panel>

                        </td>

                    </tr>

                </table>


            </td>
        </tr>

        <tr>
            <td id="tdEmpAddtionalDeatails" class="auto-style1">+ Employee additional Information</td>
        </tr>
        <tr>
            <asp:TextBox ID="txthiddenAdditionalInfo" runat="server" Visible="false"></asp:TextBox>
        </tr>
        <tr id="trEmpAddtionalDeatails" style="display: none">
            <td class="empform-ctr">
                <table width="0%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                        <td>Overview (DOJ, Experience) :&nbsp;<span
                            style="color: Red">*</span>						      </td>

                        <td width="50">&nbsp;</td>
                        <td>Forte (Skill Set) :<span
                            style="color: Red">*</span></td>

                    </tr>
                    <tr>
                        <td>
                            <label for="txtOverView"></label>
                            <div style="display: none" id="htmlOverview" runat="server"></div>
                            <SharePoint:InputFormTextBox TextMode="MultiLine" runat="server" Rows="6" MaxLength="1530" ID="txtOverView" RichText="true" RichTextMode="Compatible" ValidationGroup="btnSave" />
                            <SharePoint:InputFormRequiredFieldValidator ID="reqOverView" Display="Dynamic" runat="server" ControlToValidate="txtOverView" BreakBefore="true" SetFocusOnError="true" ErrorMessage="please enter Overview" ValidationGroup="btnSave"></SharePoint:InputFormRequiredFieldValidator>


                            <%--<asp:TextBox ID="txtOverView" runat="server" TextMode="MultiLine" cols="45" Rows="5" class="emp-messagebox"></asp:TextBox>--%>
                           
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <SharePoint:InputFormTextBox TextMode="MultiLine" runat="server" Rows="6" MaxLength="1530" ID="txtForte" RichText="true" RichTextMode="Compatible" ValidationGroup="btnSave" /></td>
                        <SharePoint:InputFormRequiredFieldValidator ID="reqForte" Display="Dynamic" runat="server" ControlToValidate="txtForte" BreakBefore="true" SetFocusOnError="true" ErrorMessage="please enter Skills" ValidationGroup="btnSave"></SharePoint:InputFormRequiredFieldValidator>
                    </tr>
                    <tr>
                        <td>About My Spouse/Significant Other &amp; Children :</td>
                        <td>&nbsp;</td>
                        <td>What I like to do when I kick Back-My Hobbies :</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtMySpouse" runat="server" TextMode="MultiLine" CssClass="emp-messagebox"></asp:TextBox></td>
                        <td>&nbsp;</td>
                        <td>
                            <label for="txtMyHobbies"></label>
                            <asp:TextBox ID="txtMyHobbies" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>What am I reading now? What's the Best Book I've read? :</td>
                        <td>&nbsp;</td>
                        <td>Who inspired me the most &amp; Why? :</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtBestBooks"></label>

                            <asp:TextBox ID="txtBestBooks" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <label for="txtInspiredMe"></label>
                            <asp:TextBox ID="txtInspiredMe" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Things I love about the jobs that I've had :</td>
                        <td>&nbsp;</td>
                        <td>What makes me tick :</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtAboutJob"></label>
                            <asp:TextBox ID="txtAboutJob" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <label for="txtMakesMeTick"></label>
                            <asp:TextBox ID="txtMakesMeTick" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>How I spend a Lazy Afternoon :</td>
                        <td>&nbsp;</td>
                        <td>My Favorite Foods :</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtLazyNon"></label>
                            <asp:TextBox ID="txtLazyNon" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <label for="txtFavFods"></label>
                            <asp:TextBox ID="txtFavFods" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>The Best Restaurant That I've ever eaten at :</td>
                        <td>&nbsp;</td>
                        <td>I am Most Proud of :</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtBestReat"></label>
                            <asp:TextBox ID="txtBestReat" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <label for="txtProudOf"></label>
                            <asp:TextBox ID="txtProudOf" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>The Most intresting thing/place that I have seen :</td>
                        <td>&nbsp;</td>
                        <td>If I could change anything about the world :</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtInterstingThings"></label>
                            <asp:TextBox ID="txtInterstingThings" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <label for="txtICudChgWorld"></label>
                            <asp:TextBox ID="txtICudChgWorld" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>The sports team that I follow are :</td>
                        <td>&nbsp;</td>
                        <td>The Music I Listen to :</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtSptTmIFoll"></label>
                            <asp:TextBox ID="txtSptTmIFoll" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <label for="txtmusIListen"></label>
                            <asp:TextBox ID="txtmusIListen" runat="server" TextMode="MultiLine" cols="45" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>My Favorite TV Show :</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <label for="txtFavTV"></label>
                            <asp:TextBox ID="txtFavTV" runat="server" TextMode="MultiLine" cols="50" Rows="5" CssClass="emp-messagebox"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td class="auto-style1" id="tdcertifications">+ Employee Certification Details</td>
        </tr>
        <tr id="trcertifications" align="left" valign="top" class="empform-ctr" style="display: none;">
            <td align="left" valign="top" class="empform-ctr" style="padding: 0px">
                <asp:UpdatePanel ID="upnlCertifications" runat="server">
                    <ContentTemplate>
                        <span style="display: none">

                            <asp:HiddenField ID="hdnEditId" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="hdnAssignUtil" runat="server" Value="0"></asp:HiddenField>
                            <asp:HiddenField ID="hdnTechnology" runat="server" Value="0"></asp:HiddenField>
                            <asp:HiddenField ID="hdnNameOfCertification" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="hdnCertificationID" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="hdnEndDate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="hdnStartDate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="hdnAttachment" runat="server"></asp:HiddenField>

                            <asp:TextBox ID="txtCerificateEdit" runat="server"></asp:TextBox>
                            <asp:TextBox ID="txtCerificateEdit1" runat="server"></asp:TextBox>
                            <asp:TextBox ID="txtCertificateDelete" runat="server"></asp:TextBox>
                            <asp:Button ID="btnhiddenCertificateEdit" runat="server" Text="Button" OnClick="btnhiddenCertificateEdit_Click1" />
                            <asp:Button ID="btnhiddenCertifiDelete" runat="server" Text="Button" OnClick="btnhiddenCertifiDelete_Click" />

                        </span>

                        <div id="CertificationDiv" class="chweb_dialog" width="550px">
                            <table width="550px" border="0" cellspacing="0" cellpadding="5">
                                <tr>
                                    <td width="556" class="empform-main-header">Employee Certification Details</td>
                                    <td width="24" class="empform-main-header">
                                        <img id="btnProgramClose" src="/_layouts/15/VrtxIntranetStyles/Images/Close_Box_Red.png" width="24" height="24" /></td>
                                </tr>
                                <tr style="display: none">
                                    <td>
                                        <asp:Label ID="lblCertificateId" runat="server" Text="CertificateId"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="txtCertificateId" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center" valign="top" class="empform-ctr">
                                        <table border="0" cellspacing="0" cellpadding="5">

                                            <tr>
                                                <td align="right">Technology :
                                                </td>
                                                <td>
                                                    <label for="drpTechnology"></label>
                                                    <asp:DropDownList ID="drpTechnology" runat="server" CssClass="emp-Dropdown" AutoPostBack="true" OnSelectedIndexChanged="drpTechnology_SelectedIndexChanged1"></asp:DropDownList>&nbsp;<span
                                                        style="color: Red">*</span></td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="right">Name of Certificate :
                                                </td>
                                                <td>
                                                    <label for="drpNameOfCertification"></label>
                                                    <asp:DropDownList ID="drpNameOfCertification" runat="server" CssClass="emp-Dropdown"></asp:DropDownList>&nbsp;<span
                                                        style="color: Red">*</span></td>
                                                <td>&nbsp;</td>
                                            </tr>

                                            <tr>
                                                <td align="right">Certification ID :
                                                </td>
                                                <td>
                                                    <label for="txtCertificationID"></label>
                                                    <asp:TextBox ID="txtCertificationID" CssClass="emp-textbox" runat="server"></asp:TextBox>


                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">Certified Date :
                                                </td>
                                                <td>
                                                    <label for="txtCertifiedDate"></label>
                                                    <asp:TextBox ID="txtCertifiedDate" CssClass="emp-textbox" runat="server">

                                                    </asp:TextBox><cc1:CalendarExtender
                                                        ID="CalendarExtender2" TargetControlID="txtCertifiedDate" runat="server" OnClientDateSelectionChanged="checkDate">
                                                    </cc1:CalendarExtender>
                                                    <%-- <script>$("#<%=txtCertifiedDate.ClientID %>").attr('readonly', true);</script>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">Valid Until Date :
                                                </td>

                                                <td>
                                                    <label for="txtUntilDate"></label>
                                                    <asp:TextBox ID="txtUntilDate" CssClass="emp-textbox" runat="server"></asp:TextBox>
                                                    <cc1:CalendarExtender
                                                        ID="CalendarExtender3" TargetControlID="txtUntilDate" runat="server" OnClientDateSelectionChanged="checkDate">
                                                    </cc1:CalendarExtender>
                                                    <%--<script>$("#<%=txtUntilDate.ClientID %>").attr('readonly', true);</script>--%>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td align="right">Upload Certificate :</td>
                                                <td>
                                                    <label for="FulCerificate"></label>
                                                    <asp:FileUpload ID="FulCerificates" runat="server" CssClass="emp-Attachment" ClientIDMode="Static" />
                                                </td>
                                                <td>
                                                    <asp:HyperLink ID="HlnCertificate" runat="server"></asp:HyperLink></td>
                                            </tr>

                                            <tr>
                                                <td colspan="3" align="center">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="emp-button" />
                                                    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="emp-button" />
                                                    <%-- <asp:Button ID="btnAttachment" runat="server" Visible="false" OnClick="btnAttachment_Click" />--%>
                                                    <input type="button" id="btnClear" value="Clear" class="emp-button" style="background-color: #f16530; cursor: pointer; border: #f16530 solid 1px; color: #FFF; padding: 5px; margin: 0 5px 0 0;" />
                                                    <%-- <asp:Button ID="btnClear" Text="Clear" runat="server" OnClientClick="clearCertificates()" CssClass="emp-button" />--%>
                                                </td>

                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table>
                            <tr>
                                <td>
                                    <p>
                                        <input type="button" id="btnCertificate" value="Add Certification" class="emp-button" style="background-color: #f16530; border: #f16530 solid 1px; color: #FFF; padding: 5px; margin: 0 5px 0 0; cursor: pointer" />
                                    </p>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="5" style="padding-left: 120px">

                                        <asp:GridView ID="GvCertificates" Width="800px" runat="server" AutoGenerateColumns="false" DataKeyNames="ID" CssClass="certification-grid">
                                            <%-- <AlternatingRowStyle CssClass="grid-sub2" BorderWidth="0" />
                        <RowStyle CssClass="grid-sub1" BorderWidth="0" />--%>
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
                                                <asp:TemplateField HeaderText="Name of Certificate" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNameofCertificate" runat="server" Text='<%#Eval("Certificate") %>'></asp:Label>
                                                    </ItemTemplate>

                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Certificate ID" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCertificateID" runat="server" Text='<%#Eval("CertificationID") %>'></asp:Label>
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


                                                <asp:TemplateField HeaderText="Edit" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <a href="javascript:void(0)" class="editCertificates" id='<%# Eval("ID") %>'>
                                                            <img align="middle" border="0" src="/_layouts/images/EDIT.gif" alt="Edit" style="cursor: pointer" /></a>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>

                                                        <a href="javascript:void(0)" id='<%# Eval("ID") %>' class="deleteCertificate">
                                                            <img align="middle" border="0" src="/_layouts/images/DELETE.gif" alt="Delete" style="cursor: pointer" /></a>
                                                    </ItemTemplate>
                                                    <ItemStyle />
                                                </asp:TemplateField>

                                            </Columns>
                                        </asp:GridView>



                                    </table>


                                </td>
                            </tr>
                        </table>

                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="drpTechnology" />
                        <asp:AsyncPostBackTrigger ControlID="drpNameOfCertification" />
                        <asp:PostBackTrigger ControlID="btnSubmit" />
                        <asp:PostBackTrigger ControlID="btnUpdate" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="emp-button" />
                <%--<input type="button" id="btnClearDetails" value="Clear" class="emp-button" style="background-color: #f16530; cursor: hand; border: #f16530 solid 1px; color: #FFF; padding: 5px; margin: 0 5px 0 0;" />--%>
                <asp:Button ID="btnClearDetails" runat="server" Text="Clear" CssClass="emp-button" OnClick="btnClearDetails_Click" />

            </td>

        </tr>
    </table>
</div>



    








