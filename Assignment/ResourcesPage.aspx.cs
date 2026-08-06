using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class ResourcesPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (AuthCheck.IsLoggedIn(this))
            {
                litAuthLinks.Text = "<a href='MemberDashboard.aspx'>Dashboard</a><a href='LogoutPage.aspx'>Logout</a>";
                phShareLink.Visible = true;
            }
            else
            {
                litAuthLinks.Text = "<a href='MemberLogin.aspx'>Login</a><a href='MemberRegister.aspx' class='btn-light'>Register</a>";
            }

            if (!IsPostBack)
            {
                LoadCategories();

                int? categoryId = null;
                int catId;
                if (int.TryParse(Request.QueryString["categoryId"], out catId))
                {
                    categoryId = catId;
                    ddlCategory.SelectedValue = catId.ToString();
                }

                LoadResources(categoryId, null);
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    ddlCategory.Items.Add(new ListItem(dr["CategoryName"].ToString(), dr["CategoryId"].ToString()));
                }
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int? categoryId = string.IsNullOrEmpty(ddlCategory.SelectedValue) ? (int?)null : int.Parse(ddlCategory.SelectedValue);
            LoadResources(categoryId, txtSearch.Text.Trim());
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int? categoryId = string.IsNullOrEmpty(ddlCategory.SelectedValue) ? (int?)null : int.Parse(ddlCategory.SelectedValue);
            LoadResources(categoryId, txtSearch.Text.Trim());
        }

        private void LoadResources(int? categoryId, string search)
        {
            StringBuilder sql = new StringBuilder(
                "SELECT r.ResourceId, r.Title, c.CategoryName, a.FirstName " +
                "FROM Resources r " +
                "JOIN Categories c ON r.CategoryId = c.CategoryId " +
                "JOIN Accounts a ON r.AccountId = a.AccountId " +
                "WHERE r.IsApproved = 1");
            if (categoryId.HasValue) sql.Append(" AND r.CategoryId = @CategoryId");
            if (!string.IsNullOrWhiteSpace(search)) sql.Append(" AND r.Title LIKE @Search");
            sql.Append(" ORDER BY r.UploadDate DESC");

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql.ToString(), con))
            {
                if (categoryId.HasValue) cmd.Parameters.AddWithValue("@CategoryId", categoryId.Value);
                if (!string.IsNullOrWhiteSpace(search)) cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                bool hasRows = dr.HasRows;
                rptResources.DataSource = dr;
                rptResources.DataBind();
                lblNoResults.Visible = !hasRows;
            }
        }
    }
}
