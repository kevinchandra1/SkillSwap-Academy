using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class QuizCreatePage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireInstructor(this);

            if (!IsPostBack)
            {
                BindCategoryDropdown();
                BindResourceDropdown();

                rptQuestionSlots.DataSource = new int[10];
                rptQuestionSlots.DataBind();
            }
        }

        private void BindCategoryDropdown()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName", con);
                con.Open();
                ddlCategory.DataSource = cmd.ExecuteReader();
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataBind();
            }
        }

        private void BindResourceDropdown()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT ResourceId, Title FROM Resources WHERE IsApproved = 1 ORDER BY Title", con);
                con.Open();
                ddlResource.DataSource = cmd.ExecuteReader();
                ddlResource.DataTextField = "Title";
                ddlResource.DataValueField = "ResourceId";
                ddlResource.DataBind();
                ddlResource.Items.Insert(0, new ListItem("-- Not based on a specific resource --", ""));
            }
        }

        protected void btnCreateQuiz_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTitle.Text))
            {
                lblError.Text = "Quiz title is required.";
                lblError.Visible = true;
                return;
            }

            int quizId;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Quizzes (Title, CategoryId, ResourceId, CreatedBy, CreatedDate) " +
                    "OUTPUT INSERTED.QuizId " +
                    "VALUES (@Title, @CategoryId, @ResourceId, @CreatedBy, GETDATE())", con);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@CategoryId", int.Parse(ddlCategory.SelectedValue));
                cmd.Parameters.AddWithValue("@ResourceId",
                    string.IsNullOrEmpty(ddlResource.SelectedValue) ? (object)DBNull.Value : int.Parse(ddlResource.SelectedValue));
                cmd.Parameters.AddWithValue("@CreatedBy", AuthCheck.CurrentAccountId(this));
                con.Open();
                quizId = (int)cmd.ExecuteScalar();
            }

            int savedQuestions = 0;
            foreach (RepeaterItem item in rptQuestionSlots.Items)
            {
                TextBox txtQuestionText = item.FindControl("txtQuestionText") as TextBox;
                TextBox txtOptionA = item.FindControl("txtOptionA") as TextBox;
                TextBox txtOptionB = item.FindControl("txtOptionB") as TextBox;
                TextBox txtOptionC = item.FindControl("txtOptionC") as TextBox;
                TextBox txtOptionD = item.FindControl("txtOptionD") as TextBox;
                DropDownList ddlCorrectOption = item.FindControl("ddlCorrectOption") as DropDownList;

                if (txtQuestionText == null || string.IsNullOrWhiteSpace(txtQuestionText.Text))
                    continue;

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "INSERT INTO QuizQuestions (QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption) " +
                        "VALUES (@QuizId, @QuestionText, @A, @B, @C, @D, @Correct)", con);
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@QuestionText", txtQuestionText.Text.Trim());
                    cmd.Parameters.AddWithValue("@A", txtOptionA.Text.Trim());
                    cmd.Parameters.AddWithValue("@B", txtOptionB.Text.Trim());
                    cmd.Parameters.AddWithValue("@C", txtOptionC.Text.Trim());
                    cmd.Parameters.AddWithValue("@D", txtOptionD.Text.Trim());
                    cmd.Parameters.AddWithValue("@Correct", ddlCorrectOption.SelectedValue);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                savedQuestions++;
            }

            if (savedQuestions == 0)
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Quizzes WHERE QuizId = @Id", con);
                    cmd.Parameters.AddWithValue("@Id", quizId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                lblError.Text = "Please fill in at least one question.";
                lblError.Visible = true;
                return;
            }

            Response.Redirect("QuizPage.aspx");
        }
    }
}