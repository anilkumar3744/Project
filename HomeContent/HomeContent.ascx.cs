using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using System.Text;
using Microsoft.SharePoint.Utilities;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.Client;
using Microsoft.SharePoint.Client.ServerRuntime;
using System.Collections.Generic;
using System.Linq;
using Microsoft.SharePoint.Linq;

namespace VrtxIntranetPortal.HomeContent
{
    [ToolboxItemAttribute(false)]
    public partial class HomeContent : WebPart
    {
        string lstHolidays = "Holidays";
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public HomeContent()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                try
                {
                    string username = SPContext.Current.Web.CurrentUser.LoginName;
                    username = username.Substring(username.IndexOf("\\") + 1);
                    string userCountry = GetCountry(username, "EmpBasicInfo");
                    if (userCountry == string.Empty)
                    {
                        hdnCountry.Value = "India";
                    }
                    else
                    hdnCountry.Value = userCountry;

                    if (userCountry == "USA")
                    {
                        GetHolidays("USA");
                        GetWhatsNewListItems("WhatsNew", "USA");
                        GetSmartToolsListItems("Smart Tools", "USA");
                    }
                    else
                    {


                        GetHolidays("India");
                        GetWhatsNewListItems("WhatsNew", "India");
                        GetSmartToolsListItems("Smart Tools", "India");

                    }


                    GetMessageFromCEOListItems("CEOMessage");
                    GetBasicInfoListItem("EmpBasicInfo");
                    // GetuserBasicInfo();
                }
                catch (Exception ex)
                {
                    SPDiagnosticsService.Local.WriteTrace(0, new SPDiagnosticsCategory("Home page content - PageLoad", TraceSeverity.High, EventSeverity.Error), TraceSeverity.High, ex.Message, ex.StackTrace);

                }
            }
        }

        #region Common Methods

        /// <summary>
        /// Gets the list.
        /// </summary>
        /// <param name="listName">Name of the list.</param>
        /// <returns></returns>
        private SPList GetList(string listName)
        {
            SPList list;
            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {
                using (SPWeb web = site.OpenWeb())
                {
                    list = web.Lists.TryGetList(listName);
                    if (list != null)
                    {
                        return list;
                    }
                    else { return null; }
                }
            }

        }
        #endregion

        #region Events
        //protected void button_India(object sender, EventArgs e)
        //{
        //    GetHolidays("India");
        //}
        //protected void button_USA(object sender, EventArgs e)
        //{
        //    GetHolidays("USA");
        //}
        //protected void button_WhatNewIndia(object sender, EventArgs e)
        //{
        //    GetWhatsNewListItems("WhatsNew","India");
        //}
        //protected void button_WhatNewUSA(object sender, EventArgs e)
        //{
        //    GetWhatsNewListItems("WhatsNew", "USA");
        //}
        //protected void btn_SmartToolsIndia(object sender, EventArgs e)
        //{
        //    GetSmartToolsListItems("Smart Tools", "India");
        //}
        // protected void btn_SmartToolsUSA(object sender, EventArgs e)
        //{
        //    GetSmartToolsListItems("Smart Tools", "USA");
        //}
        #endregion

        #region Private Methods
        /// <summary>
        /// Gets the whats new list items.
        /// </summary>
        /// <param name="listName">Name of the list.</param>
        /// <param name="country">The country.</param>
        private void GetWhatsNewListItems(string listName, string country)
        {
            SPList WhatsList = GetList(listName);
            if (WhatsList != null)
            {
                SPListItemCollection whtsListCollection = GetWhatsNewCollection(WhatsList, country);
                StringBuilder sbWhatsNew = new StringBuilder();
                if (whtsListCollection.Count > 0)
                {
                    foreach (SPListItem item in whtsListCollection)
                    {
                        string eventTitle = item["Title"].ToString();
                        string eventDate = item["EventDate"].ToString();
                        string eventDescription = item["EventDescription"].ToString();
                        if (!string.IsNullOrEmpty(eventTitle))
                            sbWhatsNew.Append("<b>" + eventTitle + "</b>");

                        sbWhatsNew.Append("<br/>");

                        if (!string.IsNullOrEmpty(eventDate))
                        {
                            DateTime dt = DateTime.Parse(eventDate);
                            string EveDate = String.Format("{0:MMMM d, yyyy, (dddd)}", dt);

                            sbWhatsNew.Append(EveDate);
                        }

                        if (!string.IsNullOrEmpty(eventDescription))
                        {
                            if (eventDescription.Length > 200)
                            {
                                string eventdesc = eventDescription.Substring(0, 200) + ".....";
                                sbWhatsNew.Append("<p>" + eventdesc + "</p>");
                            }
                            else
                                sbWhatsNew.Append("<p>" + eventDescription + "</p>");
                        }

                    }

                    if (sbWhatsNew.Length > 0)
                    {
                        whatsNew.InnerHtml = sbWhatsNew.ToString();
                    }
                }
                else
                {
                    whatsNew.InnerHtml = "<b>No Events </b>";
                }
            }
        }
        /// <summary>
        /// Gets the holiday list collection.
        /// </summary>
        /// <param name="list">The list.</param>
        /// <param name="country">The country.</param>
        /// <returns></returns>
        private SPListItemCollection GetHolidayListCollection(SPList list, string country)
        {

            SPQuery qry = new SPQuery();
            DateTime firstDay = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            string stringQuery = string.Format(@"<Where><And><And><And><And><Geq><FieldRef Name='HolidayDate' /><Value Type='DateTime'>{0}</Value></Geq><Leq><FieldRef Name='HolidayDate' /><Value Type='DateTime'>{1}</Value></Leq></And><Eq><FieldRef Name='Country' /><Value Type='Choice'>{2}</Value></Eq></And><Eq><FieldRef Name='FiscalYear' /><Value Type='Choice'>{3}</Value></Eq></And><Eq><FieldRef Name='IsPGHoliday' /><Value Type='bit'>0</Value></Eq></And></Where>", SPUtility.CreateISO8601DateTimeFromSystemDateTime(firstDay), SPUtility.CreateISO8601DateTimeFromSystemDateTime(firstDay.AddMonths(1)), country, DateTime.Now.Year);
            qry.Query = stringQuery;
            //qry.Query = @"<Where><Eq><FieldRef Name='Country' /><Value Type='Choice'>" + country + "</Value></Eq></Where>";
            qry.ViewFields = @"<FieldRef Name='HolidayDate' /><FieldRef Name='Title' /><FieldRef Name='Country' />";
            qry.RowLimit = 3;
            SPListItemCollection itemCollection = list.GetItems(qry);

            return itemCollection;
        }
        /// <summary>
        /// Gets the whats new collection.
        /// </summary>
        /// <param name="list">The list.</param>
        /// <param name="country">The country.</param>
        /// <returns></returns>
        private SPListItemCollection GetWhatsNewCollection(SPList list, string country)
        {
            SPQuery qry = new SPQuery();

            string stringQuery = string.Format(@"<Where><And><Eq><FieldRef Name='Country' /><Value Type='Choice'>{0}</Value></Eq><Eq><FieldRef Name='ShowOnHomePage' /><Value Type='bit'>{1}</Value></Leq></And></Where>", country, 1);
            qry.Query = stringQuery;
            //qry.Query = @"<Where><Eq><FieldRef Name='Country' /><Value Type='Choice'>" + country + "</Value></Eq></Where>";
            qry.ViewFields = @"<FieldRef Name='Title' /><FieldRef Name='EventDate' /><FieldRef Name='EventDescription' />";
            qry.RowLimit = 1;

            SPListItemCollection WhatsNewitemCollection = list.GetItems(qry);
            return WhatsNewitemCollection;
        }

        /// <summary>
        /// Gets the smart toos collection.
        /// </summary>
        /// <param name="list">The list.</param>
        /// <param name="country">The country.</param>
        /// <returns></returns>
        private SPListItemCollection GetSmartToosCollection(SPList list, string country)
        {
            SPQuery qry = new SPQuery();

            string stringQuery = string.Format(@"<Where><Eq><FieldRef Name='Country' /><Value Type='LookUp'>{0}</Value></Eq></Where>", country);
            qry.Query = stringQuery;
            //qry.Query = @"<Where><Eq><FieldRef Name='Country' /><Value Type='Choice'>" + country + "</Value></Eq></Where>";
            qry.ViewFields = @"<FieldRef Name='URL' /><FieldRef Name='Tool_x0020_Name' />";
            qry.RowLimit = 4;

            SPListItemCollection WhatsNewitemCollection = list.GetItems(qry);
            return WhatsNewitemCollection;
        }
        /// <summary>
        /// Gets the smart tools list items.
        /// </summary>
        /// <param name="listName">Name of the list.</param>
        /// <param name="country">The country.</param>
        private void GetSmartToolsListItems(string listName, string country)
        {
            SPList SpSmartList = GetList(listName);
            if (SpSmartList != null)
            {
                SPListItemCollection SmartToolListCollection = GetSmartToosCollection(SpSmartList, country);
                StringBuilder sbSmarTools = new StringBuilder();
                sbSmarTools.Append("<ul>");
                if (SmartToolListCollection.Count > 0)
                {
                    foreach (SPListItem item in SmartToolListCollection)
                    {
                        string[] url = item["URL"].ToString().Split(new char[] { ',' });
                        string urlName = string.Empty;
                        if (url != null && url.Length > 1)
                        {
                            urlName = url[0].ToString();
                        }
                        // string[] test=item["URL"].ToString().Split(new  string[]{":#"},StringSplitOptions.RemoveEmptyEntries);

                        string toolName = item["Tool_x0020_Name"].ToString();
                        sbSmarTools.Append("<li><a href=" + urlName + " target='_blank'>" + toolName + "</a></li>");

                    }
                    sbSmarTools.Append("</ul>");
                    if (sbSmarTools.Length > 0)
                    {
                        divSmart.InnerHtml = sbSmarTools.ToString();
                    }
                }
                else
                {
                    divSmart.InnerHtml = "No Smart Tools available";
                }
            }
        }

        /// <summary>
        /// Gets the holidays.
        /// </summary>
        /// <param name="country">The country.</param>
        private void GetHolidays(string country)
        {
            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {

                using (SPWeb web = site.OpenWeb())
                {
                    SPList list = web.Lists.TryGetList(lstHolidays);
                    if (list != null)
                    {
                        SPListItemCollection listCollection = GetHolidayListCollection(list, country);
                        StringBuilder sbHoliday = new StringBuilder();
                        if (listCollection.Count > 0)
                        {
                            sbHoliday.Append("<UL>");
                            foreach (SPListItem item in listCollection)
                            {


                                string holidayName = item["Title"].ToString();
                                sbHoliday.Append("<li>");
                                if (country == "India")
                                {
                                    sbHoliday.Append(@"<img src='/_layouts/15/VrtxIntranetStyles/Images/indian-flag.jpg' width='30' height='19' />");
                                }
                                else
                                    sbHoliday.Append(@"<img src='/_layouts/15/VrtxIntranetStyles/Images/usa-flag.jpg'  width='30' height='19'  />");

                                string Holidate = item["HolidayDate"].ToString();
                                if (!string.IsNullOrEmpty(Holidate))
                                {
                                    DateTime dt = DateTime.Parse(Holidate);
                                    string HDate = String.Format("{0:MMMM d, yyyy, (dddd) }", dt);
                                    sbHoliday.Append("<p>" + HDate + holidayName + "</p>");
                                }
                                else
                                {
                                    sbHoliday.Append("<p>" + holidayName + "</p>");
                                }

                                sbHoliday.Append("</li>");


                            }
                            sbHoliday.Append("</UL>");
                            if (sbHoliday.Length > 0)
                                Holidays.InnerHtml = sbHoliday.ToString();
                        }
                        else
                            Holidays.InnerHtml = "No Holidays";
                    }
                    // 
                }

            }
        }

        private SPListItemCollection GetMessagefromCE0ItemCollection(SPList list)
        {
            SPQuery qry = new SPQuery();

            qry.ViewFields = @"<FieldRef Name='Title' /><FieldRef Name='Message' /><FieldRef Name='Attachments' />";
            qry.RowLimit = 3;

            SPListItemCollection MessagefromCEOitemCollection = list.GetItems(qry);
            return MessagefromCEOitemCollection;
        }


        private void GetMessageFromCEOListItems(string listName)
        {
            SPList SpMessageList = GetList(listName);
            if (SpMessageList != null)
            {
                SPListItemCollection MessageListCollection = GetMessagefromCE0ItemCollection(SpMessageList);
                
                int ceocount = 0;
                if (MessageListCollection.Count > 0)
                {
                    foreach (SPListItem item in MessageListCollection)
                    {
                        StringBuilder sbMessage = new StringBuilder();
                        //string message = item["Message"].ToString();
                        SPFieldMultiLineText multilineField = item.Fields.GetField("Message") as SPFieldMultiLineText;
                       // string message = multilineField.GetFieldValueAsHtml(item["Message"], item);
                       string message = multilineField.GetFieldValueAsText(item["Message"]);
                       

                       
                        if (!string.IsNullOrEmpty(message))
                        {
                            if (message.Length > 400)
                            {
                                string messageDesc = message.Substring(0, 400) + ".....";
                                sbMessage.Append(messageDesc);
                            }
                            else
                                sbMessage.Append(message);
                        }

                        if (ceocount == 0)
                        {
                            if(item.Attachments.Count >0)
                            picture1.Src = SPUrlUtility.CombineUrl(item.Attachments.UrlPrefix, item.Attachments[0]);
                             else
                            {
                                picture3.Src="/_layouts/15/VrtxIntranetStyles/Images/NoImage.jpg";
                            }
                            if (sbMessage.Length > 0)
                            {
                                content1.InnerHtml = sbMessage.ToString();
                            }

                            ceocount += 1;
                        }
                        else if (ceocount == 1)
                        {
                            if(item.Attachments.Count>0)
                            picture2.Src = SPUrlUtility.CombineUrl(item.Attachments.UrlPrefix, item.Attachments[0]);
                            else
                            {
                                picture3.Src="/_layouts/15/VrtxIntranetStyles/Images/NoImage.jpg";
                            }
                            if (sbMessage.Length > 0)
                            {
                                content2.InnerHtml = sbMessage.ToString();
                            }
                            ceocount += 1;
                        }
                        else if (ceocount == 2)
                        {
                            if (item.Attachments.Count > 0)
                                picture3.Src = SPUrlUtility.CombineUrl(item.Attachments.UrlPrefix, item.Attachments[0]);
                            else
                            {
                                picture3.Src = "/_layouts/15/VrtxIntranetStyles/Images/NoImage.jpg";
                            }

                            if (sbMessage.Length > 0)
                            {
                                content3.InnerHtml = sbMessage.ToString();
                            }
                            ceocount += 1;
                        }
                        //processImage.ImageUrl  = SPUrlUtility.CombineUrl(item.Attachments.UrlPrefix, item.Attachments[0]);

                    }

                   
                }
                else
                {
                    //divmessage.InnerHtml = "No Message available";
                }
            }
        }

        private SPListItemCollection GetEmpBasicinfo(SPList list)
        {
            SPQuery qry = new SPQuery();

            qry.ViewFields = @"<FieldRef Name='Title' /><FieldRef Name='UserName' /><FieldRef Name='First_x0020_Name' /><FieldRef Name='Last_x0020_Name' /><FieldRef Name='Attachments' />";
            qry.RowLimit = 1;
            string stringQuery = string.Format(@"<Where><Eq><FieldRef Name='Dt_ShowOnHome' /><Value Type='DateTime'>{0}</Value></Eq></Where>", SPUtility.CreateISO8601DateTimeFromSystemDateTime(DateTime.Today));
            qry.Query = stringQuery;
            SPListItemCollection empBasicInfo = list.GetItems(qry);
            return empBasicInfo;

        }
        private void GetBasicInfoListItem(string listName)
        {
            SPList spBasicInfo = GetList(listName);
            if (spBasicInfo != null)
            {
                SPListItemCollection empCllection = GetEmpBasicinfo(spBasicInfo);
                string userName = string.Empty;
                string attachmentUrl = string.Empty;
                string firstName = string.Empty;
                string lastName = string.Empty;
                if (empCllection != null && empCllection.Count > 0)
                {
                    foreach (SPListItem item in empCllection)
                    {
                        if (item["Title"].ToString() != string.Empty)
                            userName = item["Title"].ToString();

                        if (item.Attachments[0].ToString() != string.Empty)
                            attachmentUrl = SPUrlUtility.CombineUrl(item.Attachments.UrlPrefix, item.Attachments[0]);

                        if (item["First_x0020_Name"].ToString() != string.Empty)
                            firstName = item["First_x0020_Name"].ToString();

                        if (item["Last_x0020_Name"].ToString() != string.Empty)
                            lastName = item["Last_x0020_Name"].ToString();

                        string fullName = firstName + " " + lastName;

                        GetAdditionalinfo(userName, fullName, attachmentUrl);
                    }
                }
                else
                {

                    ProfileTxt.InnerText = "No Profile available";
                    imgProfile.Visible = false;
                    btnProfile.Visible = false;
                }


            }
        }



        private void GetAdditionalinfo(string usrName, string fullName, string imagepath)
        {
            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {

                using (SPWeb web = site.OpenWeb())
                {
                    SPList list = web.Lists.TryGetList("EmpAdditionalDetails");
                    if (list != null)
                    {
                        SPQuery Qry = new SPQuery();
                        // qry.ViewFields = @"<FieldRef Name='Title' /><FieldRef Name='UserName' /><FieldRef Name='Attachments' />";
                        Qry.RowLimit = 1;
                        string stringQuery = string.Format(@"<Where><Eq><FieldRef Name='UserName' /><Value Type='Text'>{0}</Value></Eq></Where>", usrName);
                        Qry.Query = stringQuery;

                        SPListItemCollection BasicInfoListCollection = list.GetItems(Qry);
                        if (BasicInfoListCollection != null && BasicInfoListCollection.Count > 0)
                        {
                            StringBuilder sbOverview = new StringBuilder();
                            foreach (SPListItem item in BasicInfoListCollection)
                            {
                                if (item["Overview"].ToString() != string.Empty)
                                {
                                    //string message = item["Overview"].ToString();
                                    SPFieldMultiLineText multilineField = item.Fields.GetField("Overview") as SPFieldMultiLineText;
                                    //string message = multilineField.GetFieldValueAsHtml(item["Overview"], item);
                                    string message = multilineField.GetFieldValueAsText(item["Overview"]);
                                    if (message.Length > 450)
                                    {
                                        string messageDesc = message.Substring(0, 450) + ".....";
                                        sbOverview.Append(messageDesc);
                                    }
                                    else
                                        sbOverview.Append(message);

                                    ProfileTxt.InnerHtml = sbOverview.ToString();
                                }


                            }

                            if (fullName != string.Empty)
                            {
                                ProfileHeading.InnerText = fullName;
                            }

                            if (imagepath != string.Empty)
                            {
                                imgProfile.ImageUrl = imagepath;
                            }

                        }



                    }

                }
            }

        }

        private string GetCountry(string userName, string listname)
        {
            string country = string.Empty;
            SPList spBasicInfo = GetList(listname);
            if (spBasicInfo != null)
            {
                SPListItemCollection empCllection = GetEmpBasicCollection(spBasicInfo, userName);
                if (empCllection.Count > 0)
                {
                    if (empCllection[0]["Country"] != null)
                        country = empCllection[0]["Country"].ToString();
                    else
                        country = string.Empty;
                }

            }

            return country;

        }
        private SPListItemCollection GetEmpBasicCollection(SPList spBasicInfo, string usrename)
        {
            SPQuery qry = new SPQuery();

            qry.ViewFields = @"<FieldRef Name='Title' /><FieldRef Name='UserName' /><FieldRef Name='First_x0020_Name' /><FieldRef Name='Last_x0020_Name' /><FieldRef Name='Country' />";
            qry.RowLimit = 1;
            string stringQuery = string.Format(@"<Where><Eq><FieldRef Name='Title' /><Value Type='Text'>{0}</Value></Eq></Where>", usrename);
            qry.Query = stringQuery;
            SPListItemCollection empBasicInfo = spBasicInfo.GetItems(qry);
            return empBasicInfo;
        }
        #endregion




    }


}
