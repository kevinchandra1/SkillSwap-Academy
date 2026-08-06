using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class DiscussionsPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (AuthCheck.IsLoggedIn(this))
            {
                litAuthLinks.Text = "<a href='MemberDashboard.aspx'>Dashboard</a><a href='LogoutPage.aspx'>Logout</a>";
                lnkNewDiscussion.Visible = true;
            }
            else
            {
                litAuthLinks.Text = "<a href='MemberLogin.aspx'>Login</a><a href='MemberRegister.aspx' class='btn-light'>Register</a>";
            }

            if (!IsPostBack)
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT d.DiscussionId, d.TopicTitle, d.DateCreated, a.FirstName, " +
                        "(SELECT COUNT(*) FROM DiscussionReplies dr WHERE dr.DiscussionId = d.DiscussionId) AS ReplyCount " +
                        "FROM Discussions d JOIN Accounts a ON d.AccountId = a.AccountId " +
                        "ORDER BY d.DateCreated DESC", con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    bool hasRows = dr.HasRows;
                    rptDiscussions.DataSource = dr;
                    rptDiscussions.DataBind();
                    lblEmpty.Visible = !hasRows;
                }
            }
        }
    }
}
