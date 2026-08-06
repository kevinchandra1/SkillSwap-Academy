using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class MyResourcesPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT r.ResourceId, r.Title, r.IsApproved, r.UploadDate, c.CategoryName " +
                    "FROM Resources r JOIN Categories c ON r.CategoryId = c.CategoryId " +
                    "WHERE r.AccountId = @AccountId ORDER BY r.UploadDate DESC", con);
                cmd.Parameters.AddWithValue("@AccountId", AuthCheck.CurrentAccountId(this));
                con.Open();
                gvResources.DataSource = cmd.ExecuteReader();
                gvResources.DataBind();
            }
        }

        protected void gvResources_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteResource")
            {
                int resourceId = int.Parse(e.CommandArgument.ToString());
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Resources WHERE ResourceId = @Id AND AccountId = @AccountId", con);
                    cmd.Parameters.AddWithValue("@Id", resourceId);
                    cmd.Parameters.AddWithValue("@AccountId", AuthCheck.CurrentAccountId(this));
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                BindGrid();
            }
        }
    }
}
