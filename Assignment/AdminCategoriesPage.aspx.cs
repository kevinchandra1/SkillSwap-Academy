using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class AdminCategoriesPage : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireAdmin(this);
            if (!IsPostBack) BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Categories ORDER BY CategoryName", con);
                con.Open();
                gvCategories.DataSource = cmd.ExecuteReader();
                gvCategories.DataBind();
            }
        }

        private void ResetForm()
        {
            hdnCategoryId.Value = "0";
            txtCategoryName.Text = "";
            txtDescription.Text = "";
            litFormTitle.Text = "Add Category";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int categoryId = int.Parse(hdnCategoryId.Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                if (categoryId == 0)
                {
                    SqlCommand cmd = new SqlCommand(
                        "INSERT INTO Categories (CategoryName, Description) VALUES (@Name, @Desc)", con);
                    cmd.Parameters.AddWithValue("@Name", txtCategoryName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand cmd = new SqlCommand(
                        "UPDATE Categories SET CategoryName = @Name, Description = @Desc WHERE CategoryId = @Id", con);
                    cmd.Parameters.AddWithValue("@Name", txtCategoryName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@Id", categoryId);
                    cmd.ExecuteNonQuery();
                }
            }

            ResetForm();
            BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        protected void gvCategories_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int categoryId = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "EditCategory")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Categories WHERE CategoryId = @Id", con);
                    cmd.Parameters.AddWithValue("@Id", categoryId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hdnCategoryId.Value = dr["CategoryId"].ToString();
                        txtCategoryName.Text = dr["CategoryName"].ToString();
                        txtDescription.Text = dr["Description"] as string;
                        litFormTitle.Text = "Edit Category";
                    }
                }
            }
            else if (e.CommandName == "DeleteCategory")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Categories WHERE CategoryId = @Id", con);
                    cmd.Parameters.AddWithValue("@Id", categoryId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                BindGrid();
            }
        }
    }
}
