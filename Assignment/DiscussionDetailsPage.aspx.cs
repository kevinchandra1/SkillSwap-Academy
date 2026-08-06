using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class DiscussionDetailsPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        private int DiscussionId
        {
            get { return int.Parse(Request.QueryString["id"]); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (AuthCheck.IsLoggedIn(this))
                phReplyForm.Visible = true;
            else
                litLoginPrompt.Visible = true;

            if (!IsPostBack) BindPage();
        }

        private void BindPage()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT d.*, a.FirstName FROM Discussions d JOIN Accounts a ON d.AccountId = a.AccountId " +
                    "WHERE d.DiscussionId = @Id", con);
                cmd.Parameters.AddWithValue("@Id", DiscussionId);
                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.Read())
                {
                    dr.Close();
                    Response.Redirect("DiscussionsPage.aspx");
                    return;
                }

                litTopicTitle.Text = dr["TopicTitle"].ToString();
                litAuthor.Text = dr["FirstName"].ToString();
                litDate.Text = Convert.ToDateTime(dr["DateCreated"]).ToString("dd MMM yyyy HH:mm");
                litContent.Text = dr["Content"].ToString();
                dr.Close();

                SqlCommand repliesCmd = new SqlCommand(
                    "SELECT dr.ReplyContent, dr.DateCreated, a.FirstName " +
                    "FROM DiscussionReplies dr JOIN Accounts a ON dr.AccountId = a.AccountId " +
                    "WHERE dr.DiscussionId = @Id ORDER BY dr.DateCreated", con);
                repliesCmd.Parameters.AddWithValue("@Id", DiscussionId);
                SqlDataReader repliesReader = repliesCmd.ExecuteReader();
                rptReplies.DataSource = repliesReader;
                rptReplies.DataBind();
            }
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            AuthCheck.RequireLogin(this);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO DiscussionReplies (DiscussionId, AccountId, ReplyContent, DateCreated) " +
                    "VALUES (@DiscussionId, @AccountId, @Content, GETDATE())", con);
                cmd.Parameters.AddWithValue("@DiscussionId", DiscussionId);
                cmd.Parameters.AddWithValue("@AccountId", AuthCheck.CurrentAccountId(this));
                cmd.Parameters.AddWithValue("@Content", txtReply.Text.Trim());
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("DiscussionDetailsPage.aspx?id=" + DiscussionId);
        }
    }
}
