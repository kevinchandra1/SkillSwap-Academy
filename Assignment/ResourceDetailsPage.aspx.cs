using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class ResourceDetailsPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        private int ResourceId
        {
            get { return int.Parse(Request.QueryString["id"]); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindResource();
            }
        }

        private void BindResource()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT r.*, c.CategoryName, a.FirstName, a.LastName " +
                    "FROM Resources r " +
                    "JOIN Categories c ON r.CategoryId = c.CategoryId " +
                    "JOIN Accounts a ON r.AccountId = a.AccountId " +
                    "WHERE r.ResourceId = @Id", con);
                cmd.Parameters.AddWithValue("@Id", ResourceId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.Read())
                {
                    Response.Redirect("ResourcesPage.aspx");
                    return;
                }

                litTitle.Text = dr["Title"].ToString();
                litCategory.Text = dr["CategoryName"].ToString();
                litUploader.Text = dr["FirstName"] + " " + dr["LastName"];
                litDate.Text = Convert.ToDateTime(dr["UploadDate"]).ToString("dd MMM yyyy");
                litDescription.Text = dr["Description"].ToString();

                string imagePath = dr["ImagePath"] as string;
                if (!string.IsNullOrEmpty(imagePath))
                {
                    imgResource.ImageUrl = imagePath;
                    imgResource.Visible = true;
                }

                string contentUrl = dr["ContentUrl"] as string;
                if (!string.IsNullOrEmpty(contentUrl))
                {
                    lnkContentUrl.NavigateUrl = contentUrl;
                    lnkContentUrl.Visible = true;
                }
                dr.Close();
            }

            if (AuthCheck.IsLoggedIn(this))
            {
                int accountId = AuthCheck.CurrentAccountId(this);
                bool isSaved = IsSaved(accountId, ResourceId);
                btnToggleSave.Text = isSaved ? "\u2605 Remove from Saved" : "\u2606 Save Resource";
                btnToggleSave.Visible = true;
            }
            else
            {
                litLoginPrompt.Visible = true;
            }
        }

        private bool IsSaved(int accountId, int resourceId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM SavedResources WHERE AccountId = @AccountId AND ResourceId = @ResourceId", con);
                cmd.Parameters.AddWithValue("@AccountId", accountId);
                cmd.Parameters.AddWithValue("@ResourceId", resourceId);
                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        protected void btnToggleSave_Click(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);
            int accountId = AuthCheck.CurrentAccountId(this);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                if (IsSaved(accountId, ResourceId))
                {
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM SavedResources WHERE AccountId = @AccountId AND ResourceId = @ResourceId", con);
                    cmd.Parameters.AddWithValue("@AccountId", accountId);
                    cmd.Parameters.AddWithValue("@ResourceId", ResourceId);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand cmd = new SqlCommand(
                        "INSERT INTO SavedResources (AccountId, ResourceId, DateSaved) VALUES (@AccountId, @ResourceId, GETDATE())", con);
                    cmd.Parameters.AddWithValue("@AccountId", accountId);
                    cmd.Parameters.AddWithValue("@ResourceId", ResourceId);
                    cmd.ExecuteNonQuery();
                }
            }

            BindResource();
        }
    }
}
