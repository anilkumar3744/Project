using Microsoft.SharePoint;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Text;
using System.Web.UI.WebControls.WebParts;
using System.Linq;
using Microsoft.SharePoint.Utilities;
using System.Web.UI.WebControls;
using System.Web;

namespace VrtxIntranetPortal.EmployeeAchievements
{
    [ToolboxItemAttribute(false)]
    public partial class EmployeeAchievements : WebPart
    {
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public EmployeeAchievements()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }
        SPList EmployeeAchievmentslist = null;
        SPList EmpBasicInfolist = null;
        SPQuery LatesrQuery = new SPQuery();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {

                BindTechnologies();
                GeEmployeDetails();
            }

        }



        private void GeEmployeDetails()
        {
            using (SPSite osite = new SPSite(SPContext.Current.Web.Url))
            {
                using (SPWeb oweb = osite.OpenWeb())
                {
                    EmployeeAchievmentslist = oweb.Lists.TryGetList("EmpCertifications");
                    EmpBasicInfolist = oweb.Lists.TryGetList("EmpBasicInfo");

                    string queryResult = Page.Request.QueryString["ctype"];//["kqry"];

                    if (queryResult == "Latest")
                    {
                        DateTime Today = DateTime.Today;
                        DateTime value = Today.AddDays(-90);
                        string dtvalue = value.Date.ToString();

                        string lstQry = string.Format(@"<Where><And><Gt><FieldRef Name='CertifiedDate' /><Value IncludeTimeValue='FALSE' Type='DateTime'>{0}</Value></Gt><Lt><FieldRef Name='CertifiedDate' /><Value IncludeTimeValue='FALSE' Type='DateTime'>{1}</Value></Lt></And></Where>", SPUtility.CreateISO8601DateTimeFromSystemDateTime(value), SPUtility.CreateISO8601DateTimeFromSystemDateTime(Today));
                        LatesrQuery.Query = lstQry;                                      
                        GetAchivements(LatesrQuery, EmployeeAchievmentslist, EmpBasicInfolist);

                    }
                    else if (queryResult == "Certificate")
                    {
                        peoplepickerByCertification.Visible = true;
                        //BindTechnologies();

                    }
                    else if (queryResult == "user")
                    {
                        peoplePicker.Visible = true;
                    }
                    else
                    {
                        DateTime Today = DateTime.Today;
                        DateTime value = Today.AddDays(-365);
                        string dtvalue = value.Date.ToString();

                        string lstQry = string.Format(@"<Where><And><Gt><FieldRef Name='CertifiedDate' /><Value IncludeTimeValue='FALSE' Type='DateTime'>{0}</Value></Gt><Lt><FieldRef Name='Created' /><Value IncludeTimeValue='FALSE' Type='DateTime'>{1}</Value></Lt></And></Where>", SPUtility.CreateISO8601DateTimeFromSystemDateTime(value), SPUtility.CreateISO8601DateTimeFromSystemDateTime(Today));
                        LatesrQuery.Query = lstQry;
                        GetAchivements(LatesrQuery, EmployeeAchievmentslist, EmpBasicInfolist);
                    }
                }
            }
        }



        protected void peoplePickerbutton_Click(object sender, EventArgs e)
        {
            using (SPSite osite = new SPSite(SPContext.Current.Web.Url))
            {
                using (SPWeb oweb = osite.OpenWeb())
                {
                    EmployeeAchievmentslist = oweb.Lists.TryGetList("EmpCertifications");
                    EmpBasicInfolist = oweb.Lists.TryGetList("EmpBasicInfo");
                }
            }
            string vari = pplContarctEmp.CommaSeparatedAccounts.ToString().Split('\\')[1];
            SPQuery LatesrQuery = new SPQuery();
            string Loguser = vari.ToString();//loggedinuser.ToString().Split('\\')[1];
            string stringQuery = string.Format(@"<Where><Eq><FieldRef Name='UserName' /><Value Type='Text'>{0}</Value></Eq></Where>", Loguser);
            LatesrQuery.Query = stringQuery;
            GetAchivements(LatesrQuery, EmployeeAchievmentslist, EmpBasicInfolist);
            //pplContarctEmp.CommaSeparatedAccounts = "";
            pplContarctEmp.Entities.Clear();
            pplContarctEmp.ResolvedEntities.Clear();
        }

        private void BindTechnologies()
        {
            try
            {
                SPSecurity.RunWithElevatedPrivileges(delegate()
                {
                    using (SPSite site = new SPSite(SPContext.Current.Site.Url))
                    {
                        using (SPWeb web = site.OpenWeb())
                        {
                            SPList list = web.Lists["Technologies"];
                            SPListItemCollection ocol = list.GetItems();
                            ddlTechnologies.DataSource = ocol;
                            ddlTechnologies.DataTextField = "Title"; //List field holding name
                            //ddlTechnologies.DataValueField = "Title"; //List field holding value
                            ddlTechnologies.DataBind();
                            ddlTechnologies.Items.Insert(0, new ListItem("Select", "0"));
                            //ViewState["ddlvalue"] = ddlTechnologies.SelectedItem.Text;

                        }
                    }
                });
            }
            catch (Exception ex)
            {
                //Page.ClientScript.RegisterClientScriptBlock(typeof(SPAlert), "alert", "<script language=\"javascript\">alert('" + ex.Message + "')</script>"); 
            }
        }

        protected void ddlTechnologies_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCertifications.Items.Clear();
            gvEmpAchievements.Visible = false;

            try
            {
                SPSecurity.RunWithElevatedPrivileges(delegate()
                {
                    using (SPSite site = new SPSite(SPContext.Current.Site.Url))
                    {
                        using (SPWeb web = site.OpenWeb())
                        {
                            SPList list = web.Lists["Certifications"];
                            SPQuery ddlquery = new SPQuery();
                            string quervalue = ddlTechnologies.SelectedItem.Text;
                            string quey = string.Format(@"<Where><Eq><FieldRef Name='Technology' /><Value Type='Lookup'>{0}</Value></Eq></Where>", quervalue);
                            ddlquery.Query = quey;
                            SPListItemCollection ocol = list.GetItems(ddlquery);
                            ddlCertifications.DataSource = ocol;
                            ddlCertifications.DataTextField = "Title"; //List field holding name
                            //ddlCertifications.DataValueField = "Title"; //List field holding value
                            ddlCertifications.DataBind();
                            ddlCertifications.Items.Insert(0, new ListItem("Select", "0"));

                        }
                    }
                });
            }
            catch (Exception ex)
            {
                //Page.ClientScript.RegisterClientScriptBlock(typeof(SPAlert), "alert", "<script language=\"javascript\">alert('" + ex.Message + "')</script>");
            }

        }

        private void GetAchivements(SPQuery query, SPList EmployeeAchievmentslist, SPList EmpBasicInfolist)
        {
            SPListItemCollection collListItems = EmployeeAchievmentslist.GetItems(query);


            DataTable dt = new DataTable();
            dt.Columns.Add("Attachments", typeof(string));
            dt.Columns.Add("Title", typeof(string));
            dt.Columns.Add("Designation", typeof(string));
            dt.Columns.Add("htmlable");
            StringBuilder sb = new StringBuilder();
            if (collListItems.Count > 0)
            {
                List<string> strlist = new List<string>();
                foreach (SPListItem item in collListItems)
                {
                    strlist.Add(item["UserName"] != null ? item["UserName"].ToString().Split('#')[1] : string.Empty);
                    string strVal = string.Join(",", strlist.ToArray());
                }
                var result = (from m in strlist select m).Distinct().ToList();//it  is used to remove duplicates

                sb.Append("<table style='width:100%;' cellspacing='0' >");
                sb.Append("<tr Style=background-color:#c3d9eb;height:20px;font-size:14px;font-weight:bold;>");
                sb.Append("<td style='width:5%' ></td>");
                sb.Append("<td style='width:5%'>S No</td>");
                sb.Append("<td style='width:15%'>Technologies</td>");
                sb.Append("<td style='width:19%' >Certifications</td>");
                sb.Append("<td style='width:19%'>Certification ID</td>");
                sb.Append("<td style='width:19%'>Certified Date</td>");
                sb.Append("<td style='width:19%'>Expiry Date</td>");
                sb.Append("</tr>");
                foreach (string user in result)
                {
                    DataRow dr = dt.NewRow();
                    SPQuery q = new SPQuery();
                    string stringQuery = string.Format(@"<Where><Eq><FieldRef Name='Title' /><Value Type='Text'>{0}</Value></Eq></Where>", user);
                    q.Query = stringQuery;
                    SPListItemCollection ocollListItems = EmpBasicInfolist.GetItems(q);

                    foreach (SPListItem items in ocollListItems)
                    {

                        string attachmentAbsoluteURL = string.Empty;
                        if (items.Attachments.Count > 0)
                        {
                            foreach (String attachmentname in items.Attachments)
                            {
                                attachmentAbsoluteURL = items.Attachments.UrlPrefix + attachmentname;
                                dr["Attachments"] = attachmentAbsoluteURL.ToString();
                            }
                        }
                        else
                        {
                            dr["Attachments"] = "/_layouts/15/VrtxIntranetStyles/Images/NoImage.jpg";
                        }
                        dr["Title"] = items["Title"] != null ? items["Title"].ToString() : string.Empty;
                        dr["Designation"] = items["Designation"] != null ? items["Designation"].ToString().Split('#')[1] : string.Empty;

                        SPQuery qry = new SPQuery();
                        if (query != null)
                        {
                            collListItems = EmployeeAchievmentslist.GetItems(query);
                        }
                        else
                        {

                            qry.Query = "<Where><Eq><FieldRef Name='UserName' /><Value Type='User'>" + user + "</Value></Eq></Where>";
                            collListItems = EmployeeAchievmentslist.GetItems(qry);
                        }


                        string filepath = "/_layouts/15/VrtxIntranetStyles/Images/achievement-icon.jpg";
                        int i = 1;
                        dr["htmlable"] = sb.Append("<table cellspacing='0' style='width:100%'>");
                        foreach (SPListItem item in collListItems)
                        {
                            if (item["UserName"].ToString().Split('#')[1] == user)
                            {
                                string Technologies = item["Technology"].ToString().Split('#')[1];
                                string Certifications = item["Certificate"].ToString().Split('#')[1];
                                string CertificationID = item["CertificationID"].ToString();
                                                               
                                string CertifiedDate = item["CertifiedDate"].ToString().Split(' ')[0];
                                string UntillDate = item["UntilDate"].ToString().Split(' ')[0];

                                sb.Append("<tr>");

                                sb.AppendFormat("<td style='width:5%' >{0}</td>", "<img src='" + filepath + "'/>");
                                sb.AppendFormat("<td style='width:5%'>{0}</td>", i);
                                sb.AppendFormat("<td style='width:15%'>{0}</td>", Technologies);
                                sb.AppendFormat("<td style='width:19%'>{0}</td>", Certifications);
                                sb.AppendFormat("<td style='width:19%'>{0}</td>", CertificationID);
                                sb.AppendFormat("<td style='width:19%'>{0}</td>", CertifiedDate);
                                sb.AppendFormat("<td style='width:19%'>{0}</td>", UntillDate);
                                sb.Append("<tr/>");
                                i++;
                           }
                        }
                        dr["htmlable"] = sb.Append("</table>");
                        sb.Clear();
                        dt.Rows.Add(dr);
                    }

                    gvEmpAchievements.Visible = true;
                    errorMsg.Visible = false;
                    gvEmpAchievements.DataSource = dt;
                    gvEmpAchievements.DataBind();

                }
            }

            else
            {
                gvEmpAchievements.Visible = false;
                errorMsg.Visible = true;
                errorMsg.Text = "No Data Found ";
            }
        }

        protected void btnpeoplepickerByCertification_Click(object sender, EventArgs e)
        {


            using (SPSite osite = new SPSite(SPContext.Current.Web.Url))
            {
                using (SPWeb oweb = osite.OpenWeb())
                {
                    EmployeeAchievmentslist = oweb.Lists.TryGetList("EmpCertifications");
                    EmpBasicInfolist = oweb.Lists.TryGetList("EmpBasicInfo");

                    if (ddlTechnologies.SelectedIndex > 0 && ddlCertifications.SelectedIndex > 0)
                    {
                        string lstQry = string.Format("@<Where><And><Eq><FieldRef Name='Technology' /><Value Type='Lookup'>{0}</Value></Eq><Eq><FieldRef Name='Certificate' /><Value Type='Lookup'>{1}</Value></Eq></And></Where>", ddlTechnologies.SelectedItem.Text, ddlCertifications.SelectedItem.Text);//("@<Where><And><Eq><FieldRef Name='Technologies' /><Value Type='Lookup'>{0}</Value></Eq><Eq><FieldRef Name='Certifications' /><Value Type='Lookup'>{1}</Value></Eq></And></Where>", ddlTechnologies.SelectedItem.Text, ddlCertifications.SelectedItem.Text);

                        LatesrQuery.Query = lstQry;
                        GetAchivements(LatesrQuery, EmployeeAchievmentslist, EmpBasicInfolist);
                    }
                    else if (ddlTechnologies.SelectedIndex > 0)
                    {
                        string lstQry = string.Format("@<Where><Eq><FieldRef Name='Technology' /><Value Type='Lookup'>{0}</Value></Eq></Where>", ddlTechnologies.SelectedItem.Text);
                        LatesrQuery.Query = lstQry;
                        GetAchivements(LatesrQuery, EmployeeAchievmentslist, EmpBasicInfolist);
                    }


                }
            }
        }
    }
}
