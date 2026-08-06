using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class ProfilePage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);
            if (!IsPostBack) LoadProfile();
        }

        private void LoadProfile()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Accounts WHERE AccountId = @Id", con);
                cmd.Parameters.AddWithValue("@Id", AuthCheck.CurrentAccountId(this));
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtFirstName.Text = dr["FirstName"].ToString();
                    txtLastName.Text = dr["LastName"] as string;
                    txtEmail.Text = dr["Email"].ToString();
                    txtBio.Text = dr["Bio"] as string;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE Accounts SET FirstName = @FirstName, LastName = @LastName, Email = @Email, Bio = @Bio " +
                    "WHERE AccountId = @Id", con);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Bio", txtBio.Text.Trim());
                cmd.Parameters.AddWithValue("@Id", AuthCheck.CurrentAccountId(this));
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Session["FirstName"] = txtFirstName.Text.Trim();
            Session["LastName"] = txtLastName.Text.Trim();

            lblMessage.Text = "Profile updated successfully.";
            lblMessage.Visible = true;
        }
    }
}
