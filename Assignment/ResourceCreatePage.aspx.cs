using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class ResourceCreatePage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            ddlCategory.Items.Add(new ListItem("-- Select Category --", ""));
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                    ddlCategory.Items.Add(new ListItem(dr["CategoryName"].ToString(), dr["CategoryId"].ToString()));
            }
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string imagePath = null;
            if (fileImage.HasFile)
            {
                string uploadsFolder = Server.MapPath("~/Uploads");
                if (!Directory.Exists(uploadsFolder)) Directory.CreateDirectory(uploadsFolder);
                string fileName = Guid.NewGuid() + Path.GetExtension(fileImage.FileName);
                fileImage.SaveAs(Path.Combine(uploadsFolder, fileName));
                imagePath = "~/Uploads/" + fileName;
            }

            int accountId = AuthCheck.CurrentAccountId(this);
            bool isAdmin = AuthCheck.CurrentRole(this) == "Admin";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Resources (Title, Description, ContentUrl, ImagePath, CategoryId, AccountId, UploadDate, IsApproved) " +
                    "VALUES (@Title, @Description, @ContentUrl, @ImagePath, @CategoryId, @AccountId, GETDATE(), @IsApproved)", con);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@ContentUrl", (object)txtContentUrl.Text.Trim() ?? "");
                cmd.Parameters.AddWithValue("@ImagePath", (object)imagePath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@CategoryId", int.Parse(ddlCategory.SelectedValue));
                cmd.Parameters.AddWithValue("@AccountId", accountId);
                cmd.Parameters.AddWithValue("@IsApproved", isAdmin);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("MyResourcesPage.aspx");
        }
    }
}
