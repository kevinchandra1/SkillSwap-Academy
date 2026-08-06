using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class QuizHistoryPage : System.Web.UI.Page
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
                        "SELECT q.Title, a.Score, a.TotalQuestions, a.DateTaken " +
                        "FROM QuizAttempts a JOIN Quizzes q ON a.QuizId = q.QuizId " +
                        "WHERE a.AccountId = @AccountId ORDER BY a.DateTaken DESC", con);
                    cmd.Parameters.AddWithValue("@AccountId", AuthCheck.CurrentAccountId(this));
                    con.Open();
                    gvHistory.DataSource = cmd.ExecuteReader();
                    gvHistory.DataBind();
                }
            }
        }
    }
}
