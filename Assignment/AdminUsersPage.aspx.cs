using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SkillSwapAcademy
{
    public partial class AdminUsersPage : System.Web.UI.Page
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
                SqlCommand cmd = new SqlCommand("SELECT * FROM Accounts ORDER BY CreatedDate DESC", con);
                con.Open();
                gvUsers.DataSource = cmd.ExecuteReader();
                gvUsers.DataBind();
            }

            // Pre-select current role/status for each row after binding
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT AccountId, Role, IsActive FROM Accounts ORDER BY CreatedDate DESC", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                int i = 0;
                while (dr.Read() && i < gvUsers.Rows.Count)
                {
                    DropDownList ddlRole = gvUsers.Rows[i].FindControl("ddlRole") as DropDownList;
                    DropDownList ddlStatus = gvUsers.Rows[i].FindControl("ddlStatus") as DropDownList;
                    if (ddlRole != null) ddlRole.SelectedValue = dr["Role"].ToString();
                    if (ddlStatus != null) ddlStatus.SelectedValue = Convert.ToBoolean(dr["IsActive"]).ToString().ToLower();
                    i++;
                }
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int accountId = int.Parse(e.CommandArgument.ToString());
            int rowIndex = ((GridViewRow)((System.Web.UI.Control)e.CommandSource).NamingContainer).RowIndex;

            if (e.CommandName == "UpdateUser")
            {
                GridViewRow row = gvUsers.Rows[rowIndex];
                DropDownList ddlRole = row.FindControl("ddlRole") as DropDownList;
                DropDownList ddlStatus = row.FindControl("ddlStatus") as DropDownList;
                string role = ddlRole != null ? ddlRole.SelectedValue : "Member";
                bool isActive = ddlStatus != null && bool.Parse(ddlStatus.SelectedValue);

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "UPDATE Accounts SET Role = @Role, IsActive = @IsActive WHERE AccountId = @Id", con);
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.Parameters.AddWithValue("@IsActive", isActive);
                    cmd.Parameters.AddWithValue("@Id", accountId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            else if (e.CommandName == "DeleteUser")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Accounts WHERE AccountId = @Id", con);
                    cmd.Parameters.AddWithValue("@Id", accountId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindGrid();
        }
    }
}
