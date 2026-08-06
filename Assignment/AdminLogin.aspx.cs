using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string login = txtLogin.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT AccountId, Username, FirstName, LastName, Role FROM Accounts " +
                    "WHERE (Username = @Login OR Email = @Login) AND [Password] = @Password " +
                    "AND Role = 'Admin' AND IsActive = 1", con);
                cmd.Parameters.AddWithValue("@Login", login);
                cmd.Parameters.AddWithValue("@Password", password);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Session["AccountId"] = dr["AccountId"].ToString();
                    Session["Username"] = dr["Username"].ToString();
                    Session["FirstName"] = dr["FirstName"].ToString();
                    Session["LastName"] = dr["LastName"].ToString();
                    Session["Role"] = dr["Role"].ToString();

                    Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid admin login. Please check your credentials.";
                    lblMessage.Visible = true;
                }
            }
        }
    }
}
