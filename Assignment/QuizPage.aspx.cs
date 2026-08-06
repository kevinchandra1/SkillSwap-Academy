using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class QuizPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (AuthCheck.IsLoggedIn(this))
            {
                litAuthLinks.Text = "<a href='MemberDashboard.aspx'>Dashboard</a><a href='LogoutPage.aspx'>Logout</a>";

                string role = AuthCheck.CurrentRole(this);
                if (role == "Instructor") lnkCreateQuiz.Visible = true;
            }
            else
            {
                litAuthLinks.Text = "<a href='MemberLogin.aspx'>Login</a><a href='MemberRegister.aspx' class='btn-light'>Register</a>";
            }

            if (!IsPostBack) BindQuizzes();
        }

        private void BindQuizzes()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT q.QuizId, q.Title, c.CategoryName, " +
                    "(SELECT COUNT(*) FROM QuizQuestions qq WHERE qq.QuizId = q.QuizId) AS QuestionCount " +
                    "FROM Quizzes q JOIN Categories c ON q.CategoryId = c.CategoryId " +
                    "ORDER BY q.CreatedDate DESC", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                bool hasRows = dr.HasRows;
                rptQuizzes.DataSource = dr;
                rptQuizzes.DataBind();
                lblEmpty.Visible = !hasRows;
            }
        }

        protected void rptQuizzes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteQuiz" && AuthCheck.IsLoggedIn(this) && AuthCheck.CurrentRole(this) == "Admin")
            {
                int quizId = int.Parse(e.CommandArgument.ToString());
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Quizzes WHERE QuizId = @Id", con);
                    cmd.Parameters.AddWithValue("@Id", quizId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                BindQuizzes();
            }
        }
    }
}