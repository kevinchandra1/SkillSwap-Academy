using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    // NOTE: matching the reference project's format, this page allows open
    // self-registration as Admin with no invite code or approval step. This is
    // a real access-control weakness (anyone can make themselves an Admin) -
    // acceptable for a coursework demo, but worth mentioning as a limitation
    // if your report discusses security.
    public partial class AdminRegister : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                SqlCommand checkCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Accounts WHERE Username = @Username OR Email = @Email", con);
                checkCmd.Parameters.AddWithValue("@Username", username);
                checkCmd.Parameters.AddWithValue("@Email", email);

                int existing = Convert.ToInt32(checkCmd.ExecuteScalar());
                if (existing > 0)
                {
                    ShowMessage("This username or email is already registered.", false);
                    return;
                }

                SqlCommand insertCmd = new SqlCommand(
                    "INSERT INTO Accounts (Username, Email, [Password], FirstName, LastName, Role) " +
                    "VALUES (@Username, @Email, @Password, @FirstName, @LastName, 'Admin')", con);
                insertCmd.Parameters.AddWithValue("@Username", username);
                insertCmd.Parameters.AddWithValue("@Email", email);
                insertCmd.Parameters.AddWithValue("@Password", password);
                insertCmd.Parameters.AddWithValue("@FirstName", firstName);
                insertCmd.Parameters.AddWithValue("@LastName", (object)lastName ?? "");

                insertCmd.ExecuteNonQuery();
            }

            ShowMessage("Admin account created successfully. Please login.", true);
        }

        private void ShowMessage(string message, bool success)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = success ? "message-success" : "message-error";
            lblMessage.Visible = true;
        }
    }
}
