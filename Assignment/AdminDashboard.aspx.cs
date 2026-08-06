using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SkillSwapAcademy
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SkillSwapDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthCheck.RequireAdmin(this);

            if (!IsPostBack)
            {
                litName.Text = Session["Username"] as string;
                BindStats();
                BindRecentActivity();
            }
        }

        private void BindStats()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                litUsers.Text = new SqlCommand("SELECT COUNT(*) FROM Accounts", con).ExecuteScalar().ToString();
                litResources.Text = new SqlCommand("SELECT COUNT(*) FROM Resources", con).ExecuteScalar().ToString();
                litPending.Text = new SqlCommand("SELECT COUNT(*) FROM Resources WHERE IsApproved = 0", con).ExecuteScalar().ToString();
                litCategories.Text = new SqlCommand("SELECT COUNT(*) FROM Categories", con).ExecuteScalar().ToString();
                litDiscussions.Text = new SqlCommand("SELECT COUNT(*) FROM Discussions", con).ExecuteScalar().ToString();
            }

            int pendingCount = int.Parse(litPending.Text);
            litPendingBadge.Text = pendingCount > 0
                ? " <span class=\"badge badge-warning\" style=\"margin-left:6px;\">" + pendingCount + "</span>"
                : "";
        }

        private void BindRecentActivity()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT TOP 8 * FROM ( " +
                    "  SELECT 'New Member' AS ActivityType, Username AS Detail, CreatedDate AS ActivityDate " +
                    "  FROM Accounts WHERE Role IN ('Member','Instructor') " +
                    "  UNION ALL " +
                    "  SELECT 'New Resource', Title, UploadDate FROM Resources " +
                    "  UNION ALL " +
                    "  SELECT 'New Discussion', TopicTitle, DateCreated FROM Discussions " +
                    ") AS Activity " +
                    "ORDER BY ActivityDate DESC", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                bool hasRows = dr.HasRows;
                rptActivity.DataSource = dr;
                rptActivity.DataBind();
                lblNoActivity.Visible = !hasRows;
            }
        }

        protected string GetActivityIcon(object activityType)
        {
            switch (activityType.ToString())
            {
                case "New Member": return "fa-user-plus";
                case "New Resource": return "fa-book";
                case "New Discussion": return "fa-comments";
                default: return "fa-circle";
            }
        }

        // NEW: converts a raw timestamp into a friendly relative label ("2h ago", "3d ago", etc.)
        protected string GetTimeAgo(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "";

            DateTime date = Convert.ToDateTime(dateObj);
            TimeSpan span = DateTime.Now - date;

            if (span.TotalMinutes < 1) return "Just now";
            if (span.TotalMinutes < 60) return (int)span.TotalMinutes + "m ago";
            if (span.TotalHours < 24) return (int)span.TotalHours + "h ago";
            if (span.TotalDays < 7) return (int)span.TotalDays + "d ago";
            return date.ToString("dd MMM");
        }
    }
}