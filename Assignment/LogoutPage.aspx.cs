using System;

namespace SkillSwapAcademy
{
    public partial class LogoutPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LandingPage.aspx");
        }
    }
}
