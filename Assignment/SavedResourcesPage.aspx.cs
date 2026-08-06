using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class SavedResourcesPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);
            if (!IsPostBack)
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT s.DateSaved, r.ResourceId, r.Title, c.CategoryName " +
                        "FROM SavedResources s " +
                        "JOIN Resources r ON s.ResourceId = r.ResourceId " +
                        "JOIN Categories c ON r.CategoryId = c.CategoryId " +
                        "WHERE s.AccountId = @AccountId ORDER BY s.DateSaved DESC", con);
                    cmd.Parameters.AddWithValue("@AccountId", AuthCheck.CurrentAccountId(this));
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    bool hasRows = dr.HasRows;
                    rptSaved.DataSource = dr;
                    rptSaved.DataBind();
                    lblEmpty.Visible = !hasRows;
                }
            }
        }
    }
}
