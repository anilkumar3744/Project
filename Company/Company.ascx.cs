using Microsoft.SharePoint;
using System;
using System.ComponentModel;
using System.Data;
using System.Text;
using System.Web.UI.WebControls.WebParts;

namespace VrtxIntranetPortal.Company
{
    [ToolboxItemAttribute(false)]
    public partial class Company : WebPart
    {
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public Company()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            using (SPSite site = new SPSite(SPContext.Current.Site.Url))
            {
                using (SPWeb web = site.OpenWeb())
                {
                    SPList profiletaglist = web.Lists["ProfileTags"];
                    StringBuilder sb = new StringBuilder();
                    SPQuery profiletagquery = new SPQuery();
                    string quey = string.Format(@"<Where><Neq><FieldRef Name='Title' /><Value Type='Text'>{0}</Value></Neq></Where>", "");
                    profiletagquery.Query = quey;
                    SPListItemCollection collListItems = profiletaglist.GetItems(profiletagquery);
                    sb.Append("<ul>");
                    foreach (SPListItem item in collListItems)
                    {
                       
                        string Profiletag = item["Title"].ToString();
                        sb.AppendFormat("<li><a href=\"/SitePages/OdcProfile.aspx?ProfileTags={0}\">{0}</a></li>", Profiletag);
                                            
                    }
                    sb.Append("</ul>");
                    //sb.Clear();
                    htmlable.InnerHtml = sb.ToString();

                   
                }
            }
        }
    }
}
