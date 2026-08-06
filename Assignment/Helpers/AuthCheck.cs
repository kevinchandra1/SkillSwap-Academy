using System;
using System.Web.UI;

namespace SkillSwapAcademy
{
    public static class AuthCheck
    {
        public static bool IsLoggedIn(Page page)
        {
            return page.Session["AccountId"] != null;
        }

        public static string CurrentRole(Page page)
        {
            return page.Session["Role"] as string;
        }

        public static int CurrentAccountId(Page page)
        {
            return page.Session["AccountId"] != null ? int.Parse(page.Session["AccountId"].ToString()) : 0;
        }

        public static void RequireLogin(Page page)
        {
            if (!IsLoggedIn(page))
            {
                page.Response.Redirect("MemberLogin.aspx");
            }
        }

        public static void RequireAdmin(Page page)
        {
            if (!IsLoggedIn(page) || CurrentRole(page) != "Admin")
            {
                page.Response.Redirect("AdminLogin.aspx");
            }
        }

        // Only Instructor accounts may create quizzes — Admin's role is
        // moderation (delete), not content creation, since Admin creating quiz
        // content isn't logically consistent with their oversight role.
        public static void RequireInstructor(Page page)
        {
            if (!IsLoggedIn(page) || CurrentRole(page) != "Instructor")
            {
                page.Response.Redirect("QuizPage.aspx");
            }
        }
    }
}