using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using System.Web;
using Microsoft.SharePoint;
using System.Text;
using System.Web.UI;
using System.Collections.Generic;
using System.Linq;

namespace VrtxIntranetPortal.HRManualContent
{
    [ToolboxItemAttribute(false)]
    public partial class HRManualContent : WebPart
    {
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public HRManualContent()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }
        string CategoryValue;

        string CountryValue;
        string policyvalue;
        string subcategoryvalue;
        string newquey;
        string nquey;
        List<string> strlist = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
            }

            if (hdchangecolur.Value != string.Empty)
            {
                Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "changecolour", "Changecolour();", true);
            }
            //btnsubmit.Visible = false;
            if (HttpContext.Current.Request.QueryString["SubCategory"] == null)
            {
                if (HttpContext.Current.Request.QueryString["Category"] != null && HttpContext.Current.Request.QueryString["Country"] != null)
                {
                    CategoryValue = HttpContext.Current.Request.QueryString["Category"];
                    CountryValue = HttpContext.Current.Request.QueryString["Country"];
                    GetPolicy(CategoryValue, CountryValue, "");
                    if (strlist.Count>0)
                    {
                        getdescription(strlist[0], CategoryValue, CountryValue, "");
                    }
                    else
                    {
                        Label1.Visible = true;
                        Label1.Text = "<b>NO Data Found</b>";
                    }
                }
            }
            else
            {
                CategoryValue = HttpContext.Current.Request.QueryString["Category"];
                CountryValue = HttpContext.Current.Request.QueryString["Country"];
                subcategoryvalue = HttpContext.Current.Request.QueryString["SubCategory"];
                GetPolicy(CategoryValue, CountryValue, subcategoryvalue);
                if (strlist.Count > 0)
                {
                    getdescription(strlist[0], CategoryValue, CountryValue, subcategoryvalue);
                }
                else
                {
                    Label1.Visible = true;
                    Label1.Text = "<b>NO Data Found</b>";
                }
            }

        }
        protected void GetPolicy(string policy, string country, string subcategory)
        {
            using (SPSite osite = new SPSite(SPContext.Current.Web.Url))
            {
                using (SPWeb web = osite.OpenWeb())
                {

                    SPList profiletaglist = web.Lists["EmpManual"];
                    StringBuilder sb = new StringBuilder();
                    SPQuery profiletagquery = new SPQuery();

                    if (subcategory == "")
                    {
                        newquey = string.Format(@"<Where><And><Eq><FieldRef Name='Country' /><Value Type='Lookup'>{0}</Value></Eq><And><Eq><FieldRef Name='Category' /><Value Type='Lookup'>{1}</Value></Eq><And><IsNull><FieldRef Name='SubCategory' /></IsNull><Eq><FieldRef Name='Publish' /><Value Type='Choice'>{2}</Value></Eq></And></And></And></Where>", country, policy, "Publish");

                    }
                    else
                    {
                        newquey = string.Format(@"<Where><And><Eq><FieldRef Name='Country' /><Value Type='Lookup'>{0}</Value></Eq><And><Eq><FieldRef Name='Category' /><Value Type='Lookup'>{1}</Value></Eq><Eq><FieldRef Name='SubCategory' /><Value Type='Lookup'>{2}</Value></Eq></And></And></Where>", country, policy, subcategory);
                    }

                    profiletagquery.Query = newquey;
                    SPListItemCollection collListItems = profiletaglist.GetItems(profiletagquery);

                    if (collListItems.Count > 0)
                    {
                        foreach (SPListItem item in collListItems)
                        {
                            strlist.Add(item["Title"].ToString());// != null );

                        }

                        sb.Append("<table style='width: 100%'>");
                        string Category;
                        foreach (SPListItem item in collListItems)
                        {
                            Category = item["Title"].ToString();
                            var noSpaceString = Category.Replace(" ", "");
                            sb.Append("<tr>");
                            sb.AppendFormat("<td style=' background-color: #e4eef6; padding: 10px 130px 10px 10px;' id=" + noSpaceString + "><a href='#' onclick='GetDiscriptions(this)'>{0}</a></td>", Category);
                            sb.Append("</tr>");
                        }
                        sb.Append("</table>");
                        policyHtml.InnerHtml = sb.ToString();
                    }
                    else
                    {
                        Label1.Visible = true;
                        Label1.Text = "<b>NO Data Found</b>";
                    }

                }
            }

        }

        private void getdescription(string value, string policy, string country, string subcategory)
        {
            if (hdnDummyDescription.Value != string.Empty)
            {
                value = hdnDummyDescription.Value;
            }

            using (SPSite osite = new SPSite(SPContext.Current.Web.Url))
            {
                using (SPWeb web = osite.OpenWeb())
                {
                    SPList profiletaglist = web.Lists["EmpManual"];
                    StringBuilder sb1 = new StringBuilder();
                    SPQuery query = new SPQuery();
                    if (subcategoryvalue == null)
                    {
                        nquey = string.Format(@"<Where><And><Eq><FieldRef Name='Country' /><Value Type='Lookup'>{0}</Value></Eq><And><Eq><FieldRef Name='Category' /><Value Type='Lookup'>{1}</Value></Eq><Eq><FieldRef Name='Title' /><Value Type='Text'>{2}</Value></Eq></And></And></Where>", country, policy, value);
                    }
                    else
                    {
                        nquey = string.Format(@"<Where><And><Eq><FieldRef Name='Country' /><Value Type='Lookup'>{0}</Value></Eq><And><Eq><FieldRef Name='Category' /><Value Type='Lookup'>{1}</Value></Eq><And><Eq><FieldRef Name='SubCategory' /><Value Type='Lookup'>{2}</Value></Eq><Eq><FieldRef Name='LinkTitle' /><Value Type='Computed'>{3}</Value></Eq></And></And></And></Where>", country, policy, subcategory, value);
                    }
                    query.Query = nquey;
                    SPListItemCollection ncollListItems = profiletaglist.GetItems(query);
                    sb1.Append("<table>");
                    foreach (SPListItem item in ncollListItems)
                    {
                        string Descrioption = item["Description"].ToString();
                        sb1.Append("<tr>");
                        sb1.AppendFormat("<td style='background-color: #f7f7f7; padding: 10px 10px 10px 10px;'>{0}</td>", Descrioption);
                        sb1.Append("</tr>");
                    }
                    sb1.Append("</table>");
                    descriptionHtml.InnerHtml = sb1.ToString();
                }
            }
        }



        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            getdescription(policyvalue, CategoryValue, CountryValue, subcategoryvalue);
           
        }
    }
}
