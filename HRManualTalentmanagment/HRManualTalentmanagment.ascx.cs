using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using System.Text;
using System.Web;
namespace VrtxIntranetPortal.HRManualTalentmanagment
{
    [ToolboxItemAttribute(false)]
    public partial class HRManualTalentmanagment : WebPart
    {
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public HRManualTalentmanagment()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //string Countryvalue = HttpContext.Current.Request.QueryString["country"];
            getvalues();
        }

        private void getvalues()
        {
            using (SPSite site = new SPSite(SPContext.Current.Site.Url))
            {
                using (SPWeb web = site.OpenWeb())
                {
                    SPList employeemanualmasterlist = web.Lists["EmpManualMaster"];
                    StringBuilder sb = new StringBuilder();
                    SPQuery usaquery = new SPQuery();
                    string quey = string.Format(@"<Where><Eq><FieldRef Name='Country' /><Value Type='Lookup'>{0}</Value></Eq></Where>", "USA");
                    usaquery.Query = quey;
                    SPListItemCollection usacollListItems = employeemanualmasterlist.GetItems(usaquery);
                    sb.Append("<ul>");
                    foreach (SPListItem item in usacollListItems)
                    {

                        string Category = item["Title"].ToString();
                        sb.AppendFormat("<li><a href=\"/SitePages/HRPolicy.aspx?Category={0}&&Country={1}\">{0}</a></li>", Category, "usa");

                    }
                    sb.Append("</ul>");
                    //sb.Clear();
                    usahtmlable.InnerHtml = sb.ToString();


                    StringBuilder sb1 = new StringBuilder();
                    SPQuery indiaquery = new SPQuery();
                    string indiaquey = string.Format(@"<Where><Eq><FieldRef Name='Country' /><Value Type='Lookup'>{0}</Value></Eq></Where>", "India");
                    indiaquery.Query = indiaquey;
                    SPListItemCollection indiacollListItems = employeemanualmasterlist.GetItems(indiaquery);
                    sb1.Append("<ul>");
                    foreach (SPListItem item in indiacollListItems)
                    {

                        string Category = item["Title"].ToString();
                        sb1.AppendFormat("<li><a href=\"/SitePages/HRPolicy.aspx?Category={0}&&Country={1}\">{0}</a></li>", Category, "india");

                    }
                    sb1.Append("</ul>");
                    indiahtml.InnerHtml = sb1.ToString();





                }
            }
        }
    }
}
