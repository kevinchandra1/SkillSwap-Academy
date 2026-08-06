using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class DiscussionCreatePage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int newId;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Discussions (TopicTitle, Content, AccountId, DateCreated) " +
                    "OUTPUT INSERTED.DiscussionId " +
                    "VALUES (@Title, @Content, @AccountId, GETDATE())", con);
                cmd.Parameters.AddWithValue("@Title", txtTopicTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Content", txtContent.Text.Trim());
                cmd.Parameters.AddWithValue("@AccountId", AuthCheck.CurrentAccountId(this));
                con.Open();
                newId = (int)cmd.ExecuteScalar();
            }

            Response.Redirect("DiscussionDetailsPage.aspx?id=" + newId);
        }
    }
}
