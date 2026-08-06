using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class QuizResultPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);

            int attemptId = int.Parse(Request.QueryString["attemptId"]);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT a.Score, a.TotalQuestions, a.DateTaken, q.Title " +
                    "FROM QuizAttempts a JOIN Quizzes q ON a.QuizId = q.QuizId " +
                    "WHERE a.AttemptId = @Id AND a.AccountId = @AccountId", con);
                cmd.Parameters.AddWithValue("@Id", attemptId);
                cmd.Parameters.AddWithValue("@AccountId", AuthCheck.CurrentAccountId(this));
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.Read())
                {
                    Response.Redirect("QuizPage.aspx");
                    return;
                }

                litQuizTitle.Text = dr["Title"].ToString();
                litScore.Text = dr["Score"] + " / " + dr["TotalQuestions"];
                litDate.Text = Convert.ToDateTime(dr["DateTaken"]).ToString("dd MMM yyyy HH:mm");
            }
        }
    }
}
