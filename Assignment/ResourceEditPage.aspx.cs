using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class ResourceEditPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        private int ResourceId
        {
            get { return int.Parse(Request.QueryString["id"]); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireLogin(this);

            if (!IsPostBack)
            {
                LoadCategories();
                LoadResource();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                    ddlCategory.Items.Add(new ListItem(dr["CategoryName"].ToString(), dr["CategoryId"].ToString()));
            }
        }

        private void LoadResource()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Resources WHERE ResourceId = @Id", con);
                cmd.Parameters.AddWithValue("@Id", ResourceId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.Read())
                {
                    Response.Redirect("MyResourcesPage.aspx");
                    return;
                }

                int ownerId = Convert.ToInt32(dr["AccountId"]);
                bool isAdmin = AuthCheck.CurrentRole(this) == "Admin";
                if (ownerId != AuthCheck.CurrentAccountId(this) && !isAdmin)
                {
                    dr.Close();
                    Response.Redirect("MyResourcesPage.aspx");
                    return;
                }

                txtTitle.Text = dr["Title"].ToString();
                txtDescription.Text = dr["Description"].ToString();
                txtContentUrl.Text = dr["ContentUrl"] as string;
                ddlCategory.SelectedValue = dr["CategoryId"].ToString();

                string imagePath = dr["ImagePath"] as string;
                if (!string.IsNullOrEmpty(imagePath))
                {
                    imgExisting.ImageUrl = imagePath;
                    imgExisting.Visible = true;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
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

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "UPDATE Resources SET Title = @Title, Description = @Description, " +
                             "ContentUrl = @ContentUrl, CategoryId = @CategoryId";
                if (imagePath != null) sql += ", ImagePath = @ImagePath";
                sql += " WHERE ResourceId = @Id";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@ContentUrl", txtContentUrl.Text.Trim());
                cmd.Parameters.AddWithValue("@CategoryId", int.Parse(ddlCategory.SelectedValue));
                if (imagePath != null) cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                cmd.Parameters.AddWithValue("@Id", ResourceId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("MyResourcesPage.aspx");
        }
    }
}
