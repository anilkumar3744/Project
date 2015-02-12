using Microsoft.SharePoint;
using System;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.UI.WebControls.WebParts;

namespace vrtxIntranetSol.ODCServiceProfiles
{
    [ToolboxItemAttribute(false)]
    public partial class ODCServiceProfiles : WebPart
    {
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public ODCServiceProfiles()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }
        string StrTech;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.QueryString["ProfileTags"] != null)
            {
                StrTech = HttpContext.Current.Request.QueryString["ProfileTags"];
                GetProfileDescription(StrTech);
                GetProfilePicture(StrTech);
            }
            else
            {
                StrTech = "Corporate Communication";
                GetProfileDescription(StrTech);
                GetProfilePicture(StrTech);
            }
        }
        protected void GetProfilePicture(string ProfileTag)
        {
            StrTech = HttpContext.Current.Request.QueryString["ProfileTags"];
            SPSecurity.RunWithElevatedPrivileges(delegate
            {
                using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        web.AllowUnsafeUpdates = true;
                        SPList listBasicInfo = web.Lists.TryGetList("EmpBasicInfo");
                        if (listBasicInfo != null)
                        {

                            SPQuery qry = new SPQuery();
                            string stringQuery = "";
                            stringQuery = string.Format(@"<Where><Eq><FieldRef Name='ProfileTag' /><Value Type='LookupMulti'>{0}</Value></Eq></Where>", StrTech);
                            qry.Query = stringQuery;
                            SPListItemCollection listcoll = listBasicInfo.GetItems(qry);
                            DataTable dt = new DataTable();
                            dt.Columns.Add("ProfileTag");
                            dt.Columns.Add("Title");
                            //dt.Columns.Add("FirstName");
                            foreach (SPListItem item in listcoll)
                            {
                                DataRow dr = dt.NewRow();
                                if (item.Attachments.Count > 0)
                                {
                                    foreach (String attachmentname in item.Attachments)
                                    {
                                        String attachmentAbsoluteURL = item.Attachments.UrlPrefix + attachmentname;
                                        dr["ProfileTag"] = attachmentAbsoluteURL;                                        
                                    }
                                }
                                else
                                {
                                    dr["ProfileTag"] = "/_layouts/15/VrtxIntranetStyles/Images/NoImage.jpg";
                                }
                                dr["Title"] = item["Title"];
                                //dr["FirstName"] = item["FirstName"];
                                dt.Rows.Add(dr);
                            }
                            RepeaterImages.DataSource = dt;
                            RepeaterImages.DataBind();
                        }
                    }
                }
            });

        }

        protected void GetProfileDescription(string ProfileTag)
        {
            SPSecurity.RunWithElevatedPrivileges(delegate
            {
                using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        web.AllowUnsafeUpdates = true;
                        SPList listProfileTag = web.Lists.TryGetList("ProfileTags");
                        if (listProfileTag != null)
                        {
                            SPQuery qry = new SPQuery();
                            string StrQuery = "";
                            StrQuery = string.Format(@"<Where><Eq><FieldRef Name='Title' /><Value Type='Text'>{0}</Value></Eq></Where>", StrTech);
                            qry.Query = StrQuery;
                            SPListItemCollection listColl = listProfileTag.GetItems(qry);
                            foreach (SPListItem item in listColl)
                            {
                                if(item["Description"]!=null)
                                {
                                    lblDescription.Text = item["Description"].ToString();
                                }
                                if (item["Title"]!= null)
                                {
                                    lblTitle.Text = item["Title"].ToString();
                                }
                            }
                        }
                    }
                }
            });

        }
    }
}
