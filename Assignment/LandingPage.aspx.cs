using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class LandingPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadResources();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                rptCategories.DataSource = dr;
                rptCategories.DataBind();
            }
        }

        private void LoadResources()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT TOP 8 r.ResourceId, r.Title, c.CategoryName, a.FirstName " +
                    "FROM Resources r " +
                    "JOIN Categories c ON r.CategoryId = c.CategoryId " +
                    "JOIN Accounts a ON r.AccountId = a.AccountId " +
                    "WHERE r.IsApproved = 1 " +
                    "ORDER BY r.UploadDate DESC", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                bool hasRows = dr.HasRows;
                rptResources.DataSource = dr;
                rptResources.DataBind();
                lblEmpty.Visible = !hasRows;
            }
        }
    }
}
