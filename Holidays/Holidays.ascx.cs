using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Client;
using Microsoft.SharePoint.Client.ServerRuntime;
using Microsoft.SharePoint.Administration;
using System.Text;
using Microsoft.SharePoint.Utilities;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web;


namespace VrtxIntranetPortal.Holidays
{
    [ToolboxItemAttribute(false)]
    public partial class Holidays : WebPart
    {
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public Holidays()
        {
        }
        int serialNo = 0;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }
        private int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string QurCountry = string.Empty;
                try
                {
                    if (HttpContext.Current.Request.QueryString["Ctype"] != null && HttpContext.Current.Request.QueryString["Ctype"] != string.Empty)
                    {
                        QurCountry = HttpContext.Current.Request.QueryString["Ctype"];
                        if (QurCountry != "pg")
                        {
                            GetHolidays(QurCountry, true);
                        }
                        else if (QurCountry == "pg")
                        {
                            GetHolidays(QurCountry, false);
                        }
                    }
                    else
                    {
                        StringBuilder sb = new StringBuilder();

                        sb.Append("<table style=Width:400px><tr Class=grid-sub1><td Class=grid-header>S.No</td><td  Class=grid-header>Month</td><td  Class=grid-header>Day</td><td Class=grid-header>Date</td><td Class=grid-header>Holidays</td></tr><tr  Class=grid-sub1><td colspan=5><b>Holidays are not available</b></td></tr></table>");
                        lblPGResult.InnerHtml = sb.ToString();
                    }

                }

                catch (Exception ex)
                {
                    SPDiagnosticsService.Local.WriteTrace(0, new SPDiagnosticsCategory("Holidays - PageLoad", TraceSeverity.High, EventSeverity.Error), TraceSeverity.High, ex.Message, ex.StackTrace);

                }
            }
        }

        private void GetHolidays(string country, bool isCtype)
        {
            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {

                using (SPWeb web = site.OpenWeb())
                {
                    SPList list = web.Lists.TryGetList("Holidays");
                    if (list != null)
                    {
                        SPQuery qry = new SPQuery();
                        string stringQuery = "";
                        if (isCtype == true)
                        {
                            string strPG = "0";
                            stringQuery = string.Format(@"<Where><And><And><Eq><FieldRef Name='Country' /><Value Type='Choice'>{0}</Value></Eq><Eq><FieldRef Name='IsPGHoliday' /><Value Type='bit'>{1}</Value></Eq></And><Eq><FieldRef Name='FiscalYear' /><Value Type='Lookup'>{2}</Value></Eq></And></Where>", country, strPG,DateTime.Now.Year);
                        }
                        else
                        {
                            string strPG = "1";
                            stringQuery = string.Format(@"<Where><And><Eq><FieldRef Name='IsPGHoliday' /><Value Type='bit'>{0}</Value></Eq><Eq><FieldRef Name='FiscalYear' /><Value Type='Lookup'>{1}</Value></Eq></And></Where>", strPG, DateTime.Now.Year);
                        }
                        qry.Query = stringQuery;
                        qry.ViewFields = @"<FieldRef Name='HolidayDate' /><FieldRef Name='Title' /><FieldRef Name='Comment' />";
                        SPListItemCollection listcoll = list.GetItems(qry);
                        DataTable dtHoliday = new DataTable();
                        //dtHoliday.Columns.Add("SNo");
                        dtHoliday.Columns.Add("Month");
                        dtHoliday.Columns.Add("Day");
                        dtHoliday.Columns.Add("HolidayDate");
                        dtHoliday.Columns.Add("HolidayName");
                        dtHoliday.Columns.Add("MonthNum");
                        foreach (SPListItem item in listcoll)
                        {
                            DataRow row = dtHoliday.NewRow();
                            string title = item["Title"].ToString();
                            if (title.Contains("*"))
                            {
                               // lblComment.Visible = true;
                                if (item["Comment"]!=null)
                                {
                                    Label lblTextComment = new Label();
                                    lblTextComment.Text = "*"+item["Comment"].ToString();
                                    pnlComment.Controls.Add(lblTextComment);
                                }
                                //lblComment.Text = item["Comment"].ToString();
                            }
                            string HDate = item["HolidayDate"].ToString();
                            DateTime dt = DateTime.Parse(HDate);
                            string HdateName = String.Format("{0:MMMM d, yyyy}", dt);
                            string HolidayMonth = String.Format("{0:MMMM}", dt);
                            string MonthNumber = dt.Month.ToString();
                            string HolidayDay = String.Format("{0:dddd}", dt);
                           // count += 1;
                            //row["SNo"] = count.ToString();
                            row["Month"] = HolidayMonth.ToString();
                            row["Day"] = HolidayDay.ToString();
                            row["HolidayDate"] = HdateName.ToString();
                            row["HolidayName"] = title.ToString();
                            row["MonthNum"] = MonthNumber;
                            dtHoliday.Rows.Add(row);

                        }

                        if (dtHoliday.Rows.Count > 0)
                        {
                            DataView dv = dtHoliday.DefaultView;
                            dv.Sort = "MonthNum";
                            gvHolidays.DataSource = dv;
                            gvHolidays.DataBind();
                        }
                        else {
                            StringBuilder sb = new StringBuilder();

                            sb.Append("<table style=Width:400px><tr Class=grid-sub1><td Class=grid-header>S.No</td><td  Class=grid-header>Month</td><td  Class=grid-header>Day</td><td Class=grid-header>Date</td><td Class=grid-header>Holidays</td></tr><tr  Class=grid-sub1><td colspan=5><b>Holidays are not available</b></td></tr></table>");
                            lblPGResult.InnerHtml = sb.ToString();
                        }

                    }
                }
            }
        }
       

       

    }
}
