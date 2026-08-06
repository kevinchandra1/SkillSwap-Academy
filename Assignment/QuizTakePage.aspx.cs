using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class QuizTakePage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        private int QuizId
        {
            get { return int.Parse(Request.QueryString["id"]); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);

            if (!IsPostBack)
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    SqlCommand titleCmd = new SqlCommand("SELECT Title FROM Quizzes WHERE QuizId = @Id", con);
                    titleCmd.Parameters.AddWithValue("@Id", QuizId);
                    object title = titleCmd.ExecuteScalar();
                    if (title == null) { Response.Redirect("QuizPage.aspx"); return; }
                    litQuizTitle.Text = title.ToString();

                    SqlCommand qCmd = new SqlCommand("SELECT * FROM QuizQuestions WHERE QuizId = @Id", con);
                    qCmd.Parameters.AddWithValue("@Id", QuizId);
                    SqlDataReader dr = qCmd.ExecuteReader();
                    bool hasRows = dr.HasRows;
                    rptQuestions.DataSource = dr;
                    rptQuestions.DataBind();

                    if (!hasRows)
                    {
                        Response.Redirect("QuizPage.aspx");
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Dictionary<int, string> correctAnswers = new Dictionary<int, string>();
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT QuestionId, CorrectOption FROM QuizQuestions WHERE QuizId = @Id", con);
                cmd.Parameters.AddWithValue("@Id", QuizId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                    correctAnswers[Convert.ToInt32(dr["QuestionId"])] = dr["CorrectOption"].ToString();
            }

            int score = 0;
            int total = 0;
            foreach (RepeaterItem item in rptQuestions.Items)
            {
                HiddenField hdnQuestionId = item.FindControl("hdnQuestionId") as HiddenField;
                if (hdnQuestionId == null) continue;

                total++;
                int questionId = int.Parse(hdnQuestionId.Value);

                // Selected radio value is read from the posted form data, since the
                // options are rendered as plain HTML radio inputs (grouped by
                // "q{questionId}") rather than an asp:RadioButtonList - ASP.NET
                // ListItem controls do not support inline <%# Eval() %> databinding.
                string selected = Request.Form["q" + questionId];

                if (!string.IsNullOrEmpty(selected) && correctAnswers.ContainsKey(questionId) &&
                    string.Equals(selected, correctAnswers[questionId], StringComparison.OrdinalIgnoreCase))
                {
                    score++;
                }
            }

            int attemptId;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO QuizAttempts (QuizId, AccountId, Score, TotalQuestions, DateTaken) " +
                    "OUTPUT INSERTED.AttemptId " +
                    "VALUES (@QuizId, @AccountId, @Score, @Total, GETDATE())", con);
                cmd.Parameters.AddWithValue("@QuizId", QuizId);
                cmd.Parameters.AddWithValue("@AccountId", AuthCheck.CurrentAccountId(this));
                cmd.Parameters.AddWithValue("@Score", score);
                cmd.Parameters.AddWithValue("@Total", total);
                con.Open();
                attemptId = (int)cmd.ExecuteScalar();
            }

            Response.Redirect("QuizResultPage.aspx?attemptId=" + attemptId);
        }
    }
}