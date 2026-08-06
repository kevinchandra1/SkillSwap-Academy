using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class MemberLogin : System.Web.UI.Page
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

                // Check credentials WITHOUT filtering by IsActive, so we can tell the
                // difference between "wrong password" and "account suspended".
                SqlCommand cmd = new SqlCommand(
                    "SELECT AccountId, Username, FirstName, LastName, Role, IsActive FROM Accounts " +
                    "WHERE (Username = @Login OR Email = @Login) AND [Password] = @Password", con);
                cmd.Parameters.AddWithValue("@Login", login);
                cmd.Parameters.AddWithValue("@Password", password);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    bool isActive = Convert.ToBoolean(dr["IsActive"]);

                    if (!isActive)
                    {
                        lblMessage.Text = "Your account has been suspended by an administrator. Please contact support if you believe this is a mistake.";
                        lblMessage.Visible = true;
                        return;
                    }

                    Session["AccountId"] = dr["AccountId"].ToString();
                    Session["Username"] = dr["Username"].ToString();
                    Session["FirstName"] = dr["FirstName"].ToString();
                    Session["LastName"] = dr["LastName"].ToString();
                    Session["Role"] = dr["Role"].ToString();

                    Response.Redirect("MemberDashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid username/email or password.";
                    lblMessage.Visible = true;
                }
            }
        }
    }
}