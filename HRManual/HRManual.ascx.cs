using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using System.Text;

namespace VrtxIntranetPortal.HRManual
{
    [ToolboxItemAttribute(false)]
    public partial class HRManual : WebPart
    {
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public HRManual()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Page.IsPostBack==false)
            { 
            GeEmployeDetails();
                }
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            GeEmployeDetails();
        }

        private void GeEmployeDetails()
        {
            using (SPSite osite = new SPSite(SPContext.Current.Web.Url))
            {
                using (SPWeb web = osite.OpenWeb())
                {
                    string value = ddlCountry.SelectedItem.Text.ToString();
                    SPList profiletaglist = web.Lists["EmpManualMaster"];
                    StringBuilder sb = new StringBuilder();
                    SPQuery profiletagquery = new SPQuery();
                    string quey = string.Format(@"<Where><Eq><FieldRef Name='Country' /><Value Type='Lookup'>USA</Value></Eq></Where>", value);
                    profiletagquery.Query = quey;
                    SPListItemCollection collListItems = profiletaglist.GetItems(profiletagquery);
                    sb.Append("<table>");
                    foreach (SPListItem item in collListItems)
                    {
                        string Profiletag = item["Title"].ToString();
                        sb.Append("<tr>");
                        sb.AppendFormat("<td><a href=\"/SitePages/HRManual.aspx?GetPolicy={0}&&country={1}\">{0}</a></td>", Profiletag, value);
                        sb.Append("</tr>");
                    }
                    sb.Append("</table>");
                    htmlable.InnerHtml = sb.ToString();
                }
            }
        }

        
    }
}
