using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class MemberDashboard : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);
            if (!IsPostBack)
            {
                litName.Text = Session["FirstName"] + " " + Session["LastName"];
                LoadStats();
            }
        }

        private void LoadStats()
        {
            int accountId = AuthCheck.CurrentAccountId(this);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Resources WHERE AccountId = @Id", con);
                cmd1.Parameters.AddWithValue("@Id", accountId);
                litMyResources.Text = cmd1.ExecuteScalar().ToString();

                SqlCommand cmd2 = new SqlCommand("SELECT COUNT(*) FROM SavedResources WHERE AccountId = @Id", con);
                cmd2.Parameters.AddWithValue("@Id", accountId);
                litSaved.Text = cmd2.ExecuteScalar().ToString();

                SqlCommand cmd3 = new SqlCommand("SELECT COUNT(*) FROM QuizAttempts WHERE AccountId = @Id", con);
                cmd3.Parameters.AddWithValue("@Id", accountId);
                litQuizzesTaken.Text = cmd3.ExecuteScalar().ToString();
            }
        }
    }
}
