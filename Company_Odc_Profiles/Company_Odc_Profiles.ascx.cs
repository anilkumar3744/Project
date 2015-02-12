using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Text;

namespace vrtxIntranetSol.Company_Odc_Profiles
{
    [ToolboxItemAttribute(false)]
    public partial class Company_Odc_Profiles : WebPart
    {
        // Uncomment the following SecurityPermission attribute only when doing Performance Profiling on a farm solution
        // using the Instrumentation method, and then remove the SecurityPermission attribute when the code is ready
        // for production. Because the SecurityPermission attribute bypasses the security check for callers of
        // your constructor, it's not recommended for production purposes.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public Company_Odc_Profiles()
        {
        }
        string FIRSTNAME = "First_x0020_Name";
        string LASTNAME = "Last_x0020_Name";
        string FORTE = "Forte_x0028_Skill_x0020_set_x002";
        string BESTBOOK = "Best_x0020_Book";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string QurUserName = string.Empty;
            QurUserName = HttpContext.Current.Request.QueryString["UserName"];
            if (QurUserName != null)
            {
                if (!Page.IsPostBack)
                {
                    GetEMPDetails(QurUserName);
                    BindCertificates(QurUserName);

                }
            }
           

        }


        protected void BindCertificates(string UserName)
        {

            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {

                using (SPWeb web = site.OpenWeb())
                {
                    SPList list = web.Lists.TryGetList("EmpCertifications");
                    if (list != null)
                    {
                        SPQuery qry = new SPQuery();
                        string stringQuery = "";

                        stringQuery = string.Format(@"<Where><Eq><FieldRef Name='UserName' /><Value Type='Lookup'>{0}</Value></Eq></Where>", UserName);

                        qry.Query = stringQuery;
                        // qry.ViewFields = @"<FieldRef Name='Technology' /><FieldRef Name='Certificate' /><FieldRef Name='CertifiedDate' /><FieldRef Name='UntilDate' /><FieldRef Name='UserName' />";
                        SPListItemCollection listcoll = list.GetItems(qry);
                        GvCertificates.DataSource = listcoll.GetDataTable();
                        GvCertificates.DataBind();


                    }
                }
            }
        }

        protected void GetEMPDetails(string UserName)
        {
            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {
                using (SPWeb web = site.OpenWeb())
                {
                    SPList listBasic = web.Lists.TryGetList("EmpBasicInfo");
                    SPList listAdditonal = web.Lists.TryGetList("EmpAdditionalDetails");
                    SPList listProfileTags = web.Lists.TryGetList("ProfileTags");


                    if (listBasic != null)
                    {
                        SPQuery qry = new SPQuery();
                        string strQuery;
                        strQuery = string.Format(@"<Where><Eq><FieldRef Name='Title' /><Value Type='Text'>{0}</Value></Eq></Where>", UserName);
                        qry.Query = strQuery;
                        SPListItemCollection itmcoll = listBasic.GetItems(qry);

                        foreach (SPListItem item in itmcoll)
                        {
                            if (item.Attachments.Count > 0)
                            {
                                foreach (string filesName in item.Attachments)
                                {
                                    string attachment = item.Attachments.UrlPrefix + filesName;
                                    imgOdcPic.ImageUrl = attachment;
                                }
                            }
                            else
                            {
                                imgOdcPic.ImageUrl = "/_layouts/15/VrtxIntranetStyles/Images/NoImage.jpg";
                            }
                            lblFirstName.Text = item[FIRSTNAME].ToString();
                            lblLastName.Text = item[LASTNAME].ToString();

                            string strDesignation = item["Designation"].ToString();
                            string[] strVal = strDesignation.Split('#');
                            lblDesignation.Text = strVal[1].ToString();

                            // lblDesignation.Text = item["Designation"].ToString();
                            if (item["ResidencePhoneNumber"] != null)
                            {
                                lblhomePhNo.Text = item["ResidencePhoneNumber"].ToString();
                            }
                            else
                            {
                                lblhomePhNo.Text = " - ";
                            }
                            if (item["MobileNumber"] != null)
                            {
                                lblMobNum.Text = item["MobileNumber"].ToString();
                            }
                            else
                            {
                                lblMobNum.Text = " - ";
                            }

                            string strEmail = item["VertexEmailID"].ToString();
                            string[] strEmailID = strEmail.Split('#');
                            lblEmailID.Text = strEmailID[1].ToString();
                            string strDept = item["Department"].ToString();
                            string[] strDepartment = strDept.Split('#');
                            lblDept.Text = strDepartment[1].ToString();
                            string strDOB = item["DOB"].ToString();
                            string[] strDate = strDOB.Split(' ');
                            string str = strDate[0].ToString();
                            DateTime dt = DateTime.Parse(str);
                            string DOBMonth = String.Format("{0:MMM dd}", dt);
                            lblDOB.Text = DOBMonth.ToString();
                            lblICQNo.Text = item["ICQNumber"].ToString();
                            if (item["ExtensionNumber"] != null)
                            {
                                lblExtNo.Text = item["ExtensionNumber"].ToString();
                            }
                            else
                            {
                                lblExtNo.Text = " - ";
                            }

                            if (item["ProfileTag"] != null)
                            {
                                SPFieldLookupValue fieldvalue = new SPFieldLookupValue(item["ProfileTag"].ToString());

                                string[] delimit = new string[] { ";#" };
                                string[] TagNumber = item["ProfileTag"].ToString().Split((delimit), StringSplitOptions.RemoveEmptyEntries);
                                StringBuilder sb = new StringBuilder();
                                for (var i = 0; i < TagNumber.Length; i++)
                                {
                                    if (i % 2 != 0)
                                    {
                                        //sb.AppendLine(TagNumber[i].ToString());
                                        sb.AppendLine(TagNumber[i].ToString() + ',');
                                    }

                                    //sb.Remove((sb.Length - 1), 1);
                                }
                                string RemoveLastChar = sb.ToString();
                                divProfile.InnerHtml = RemoveLastChar.Remove((RemoveLastChar.Length - 3), 3); ;
                            }
                        }
                    }


                    if (listAdditonal != null)
                    {
                        SPQuery qury = new SPQuery();
                        string strQuery;
                        strQuery = string.Format(@"<Where><Eq><FieldRef Name='UserName' /><Value Type='Lookup'>{0}</Value></Eq></Where>", UserName);
                        qury.Query = strQuery;
                        SPListItemCollection itemColl = listAdditonal.GetItems(qury);
                        foreach (SPListItem item in itemColl)
                        {
                            SPFieldMultiLineText commentsField = item.Fields.GetField("Overview") as SPFieldMultiLineText;
                            string comments = commentsField.GetFieldValueAsText(item["Overview"]);
                            string commentsAsHtml = commentsField.GetFieldValueAsHtml(item["Overview"]);
                            lblOverView.Text = comments.ToString();
                            EmpDescription.Text = comments.ToString();
                            lblForte.Text = item[FORTE].ToString();

                            SPFieldMultiLineText SpouseField = item.Fields.GetField("AboutSpouse") as SPFieldMultiLineText;
                            string Spouse = SpouseField.GetFieldValueAsText(item["AboutSpouse"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (Spouse != string.Empty)
                            {
                                lblSpouse.Text = Spouse.ToString();
                            }
                            else
                            {
                                lblSpouse.Text = " - ";
                            }

                            SPFieldMultiLineText HobbiesField = item.Fields.GetField("MyHobbies") as SPFieldMultiLineText;
                            string Hobbies = HobbiesField.GetFieldValueAsText(item["MyHobbies"]);
                            //string commentsAsHtml2 = commentsField1.GetFieldValueAsHtml(item["MyHobbies"]);
                            if (Hobbies != string.Empty)
                            {
                                lblHobbies.Text = Hobbies.ToString();
                            }
                            else
                            {
                                lblHobbies.Text = " - ";
                            }
                            SPFieldMultiLineText BookField = item.Fields.GetField(BESTBOOK) as SPFieldMultiLineText;
                            string Book = BookField.GetFieldValueAsText(item[BESTBOOK]);
                            //string commentsAsHtml2 = commentsField1.GetFieldValueAsHtml(item["MyHobbies"]);
                            if (Book != string.Empty)
                            {
                                lblBestBook.Text = Book.ToString();
                            }
                            else
                            {
                                lblBestBook.Text = " - ";
                            }
                            SPFieldMultiLineText InspiredField = item.Fields.GetField("Inspiredme") as SPFieldMultiLineText;
                            string Inspired = InspiredField.GetFieldValueAsText(item["Inspiredme"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (Inspired != string.Empty)
                            {
                                lblInspired.Text = Inspired.ToString();
                            }
                            else
                            {
                                lblInspired.Text = " - ";
                            }

                            SPFieldMultiLineText JobField = item.Fields.GetField("loveaboutjobs") as SPFieldMultiLineText;
                            string job = JobField.GetFieldValueAsText(item["loveaboutjobs"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            lblJob.Text = job.ToString();

                            SPFieldMultiLineText TickField = item.Fields.GetField("Makesmetick") as SPFieldMultiLineText;
                            string Tick = TickField.GetFieldValueAsText(item["Makesmetick"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (Tick != string.Empty)
                            {
                                lblTick.Text = Tick.ToString();
                            }
                            else
                            {
                                lblTick.Text = " -";
                            }

                            SPFieldMultiLineText LazyField = item.Fields.GetField("LazyAfternoon") as SPFieldMultiLineText;
                            string Lazy = LazyField.GetFieldValueAsText(item["LazyAfternoon"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            lblAfternoon.Text = Lazy.ToString();

                            SPFieldMultiLineText FoodField = item.Fields.GetField("FavoriteFoods") as SPFieldMultiLineText;
                            string Food = FoodField.GetFieldValueAsText(item["FavoriteFoods"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (Food != string.Empty)
                            {
                                lblFoods.Text = Food.ToString();
                            }
                            else
                            {
                                lblFoods.Text = " - ";
                            }

                            SPFieldMultiLineText proudField = item.Fields.GetField("MostProudof") as SPFieldMultiLineText;
                            string Proud = proudField.GetFieldValueAsText(item["MostProudof"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (Proud != string.Empty)
                            {
                                lblProud.Text = Proud.ToString();
                            }
                            else
                            {
                                lblProud.Text = " - ";
                            }

                            SPFieldMultiLineText RestField = item.Fields.GetField("BestRestaurant") as SPFieldMultiLineText;
                            string Rest = RestField.GetFieldValueAsText(item["BestRestaurant"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (Rest != string.Empty)
                            {
                                lblRestaurant.Text = Rest.ToString();
                            }
                            else
                            {
                                lblRestaurant.Text = " - ";
                            }



                            SPFieldMultiLineText thingField = item.Fields.GetField("InterestingThing") as SPFieldMultiLineText;
                            string Thing = thingField.GetFieldValueAsText(item["BestRestaurant"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (Thing != string.Empty)
                            {
                                lblIntrestes.Text = Thing.ToString();
                            }
                            else
                            {
                                lblIntrestes.Text = " - ";
                            }


                            SPFieldMultiLineText worldField = item.Fields.GetField("ChangeAnythingAboutWorld") as SPFieldMultiLineText;
                            string world = worldField.GetFieldValueAsText(item["ChangeAnythingAboutWorld"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (world != string.Empty)
                            {
                                lblWorldChange.Text = world.ToString();
                            }
                            else
                            {
                                lblWorldChange.Text = " - ";
                            }


                            SPFieldMultiLineText sportField = item.Fields.GetField("FollowSports") as SPFieldMultiLineText;
                            string sport = sportField.GetFieldValueAsText(item["FollowSports"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (sport != string.Empty)
                            {
                                lblSports.Text = sport.ToString();
                            }
                            else
                            {
                                lblSports.Text = " - ";
                            }


                            SPFieldMultiLineText MusicField = item.Fields.GetField("FavoriteMusic") as SPFieldMultiLineText;
                            string Music = MusicField.GetFieldValueAsText(item["FavoriteMusic"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (Music != string.Empty)
                            {
                                lblMusic.Text = Music.ToString();
                            }
                            else
                            {
                                lblMusic.Text = " - ";
                            }



                            SPFieldMultiLineText TVField = item.Fields.GetField("FavoriteTV") as SPFieldMultiLineText;
                            string TV = TVField.GetFieldValueAsText(item["FavoriteTV"]);
                            //string commentsAsHtml1 = commentsField1.GetFieldValueAsHtml(item["AboutSpouse"]);
                            if (TV != string.Empty)
                            {
                                lblFavoriteTV.Text = TV.ToString();
                            }
                            else
                            {
                                lblFavoriteTV.Text = " - ";
                            }



                        }

                    }

                }
            }
        }
    }
}
