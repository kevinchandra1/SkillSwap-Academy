<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberDashboard.aspx.cs" Inherits="SkillSwapAcademy.MemberDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Dashboard - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links">
                <a href="MemberDashboard.aspx" class="active">Dashboard</a>
                <a href="ResourcesPage.aspx">Resources</a>
                <a href="DiscussionsPage.aspx">Discussions</a>
                <a href="QuizPage.aspx">Self-Assessment</a>
                <a href="ProfilePage.aspx">Profile</a>
                <a href="LogoutPage.aspx"><i class="fas fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px;">

            <div class="dashboard-hero">
                <div class="dashboard-hero-content">
                    <div class="eyebrow"><i class="fas fa-seedling"></i> Learn &bull; Share &bull; Grow</div>
                    <h2>Welcome back, <asp:Literal ID="litName" runat="server" /> &#128075;</h2>
                    <p>Here's what's happening with your learning journey. Keep the momentum going!</p>
                    <a class="btn" href="ResourcesPage.aspx" style="background-color:#FFFFFF; color:#2E8B57;"><i class="fas fa-compass"></i> Explore Resources</a>
                    <a class="btn" href="ResourceCreatePage.aspx" style="background-color:#FFFFFF; color:#2E8B57;"><i class="fas fa-cloud-arrow-up"></i> Upload Resource</a>
                </div>
            </div>

            <div class="grid-3 mb-4">
                <div class="widget-card">
                    <div class="widget-icon"><i class="fas fa-book"></i></div>
                    <div>
                        <div class="widget-value"><asp:Literal ID="litMyResources" runat="server" /></div>
                        <div class="widget-label">My Resources</div>
                    </div>
                </div>
                <div class="widget-card">
                    <div class="widget-icon" style="background-color:var(--color-teal-soft); color:var(--color-teal);"><i class="fas fa-bookmark"></i></div>
                    <div>
                        <div class="widget-value"><asp:Literal ID="litSaved" runat="server" /></div>
                        <div class="widget-label">Saved Resources</div>
                    </div>
                </div>
                <div class="widget-card">
                    <div class="widget-icon" style="background-color:var(--color-warning-soft); color:var(--color-warning);"><i class="fas fa-clipboard-check"></i></div>
                    <div>
                        <div class="widget-value"><asp:Literal ID="litQuizzesTaken" runat="server" /></div>
                        <div class="widget-label">Quizzes Taken</div>
                    </div>
                </div>
            </div>

            <h3 class="mb-2">Quick Actions</h3>
            <div class="quick-actions">
                <a class="quick-action" href="ResourceCreatePage.aspx">
                    <div class="icon"><i class="fas fa-plus-circle"></i></div>
                    <div>
                        <div>Share a Resource</div>
                        <small class="text-muted" style="font-weight:400;">Publish something new</small>
                    </div>
                </a>
                <a class="quick-action" href="MyResourcesPage.aspx">
                    <div class="icon"><i class="fas fa-folder-open"></i></div>
                    <div>
                        <div>My Resources</div>
                        <small class="text-muted" style="font-weight:400;">Manage what you've shared</small>
                    </div>
                </a>
                <a class="quick-action" href="SavedResourcesPage.aspx">
                    <div class="icon"><i class="fas fa-bookmark"></i></div>
                    <div>
                        <div>Saved Resources</div>
                        <small class="text-muted" style="font-weight:400;">Your saved list</small>
                    </div>
                </a>
                <a class="quick-action" href="QuizHistoryPage.aspx">
                    <div class="icon"><i class="fas fa-clock-rotate-left"></i></div>
                    <div>
                        <div>Quiz History</div>
                        <small class="text-muted" style="font-weight:400;">Review your scores</small>
                    </div>
                </a>
            </div>

        </div>

        <footer class="site-footer">
            <div class="footer-bottom" style="margin-top:0; border-top:none; padding-top:0;">
                &copy; <%= DateTime.Now.Year %> SkillSwap Academy &middot; Learn &bull; Share &bull; Grow
            </div>
        </footer>
    </form>
</body>
</html>