using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class AdminPendingResourcesPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireAdmin(this);
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT r.ResourceId, r.Title, r.Description, r.UploadDate, c.CategoryName, a.FirstName " +
                    "FROM Resources r " +
                    "JOIN Categories c ON r.CategoryId = c.CategoryId " +
                    "JOIN Accounts a ON r.AccountId = a.AccountId " +
                    "WHERE r.IsApproved = 0 ORDER BY r.UploadDate", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                bool hasRows = dr.HasRows;
                rptPending.DataSource = dr;
                rptPending.DataBind();
                lblEmpty.Visible = !hasRows;
            }
        }

        protected void rptPending_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int resourceId = int.Parse(e.CommandArgument.ToString());

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                if (e.CommandName == "Approve")
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Resources SET IsApproved = 1 WHERE ResourceId = @Id", con);
                    cmd.Parameters.AddWithValue("@Id", resourceId);
                    cmd.ExecuteNonQuery();
                }
                else if (e.CommandName == "Reject")
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Resources WHERE ResourceId = @Id", con);
                    cmd.Parameters.AddWithValue("@Id", resourceId);
                    cmd.ExecuteNonQuery();
                }
            }

            BindGrid();
        }
    }
}
