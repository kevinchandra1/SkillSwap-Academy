<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="SkillSwapAcademy.AdminDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy <span class="badge badge-role-admin" style="margin-left:8px;">Admin</span></div>
            <div class="nav-links">
                <a href="AdminDashboard.aspx" class="active">Dashboard</a>
                <a href="AdminUsersPage.aspx">Users</a>
                <a href="AdminPendingResourcesPage.aspx">Pending Resources</a>
                <a href="AdminCategoriesPage.aspx">Categories</a>
                <a href="QuizPage.aspx">Quizzes</a>
                <a href="LogoutPage.aspx"><i class="fas fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>

        <div class="container" style="padding-top:40px; padding-bottom:48px;">
            <div class="mb-4">
                <h2 style="margin-bottom:4px;">Welcome back, <asp:Literal ID="litName" runat="server" /></h2>
                <p class="text-muted" style="margin:0;">Here's an overview of the SkillSwap Academy platform.</p>
            </div>

            <div class="grid-4 mb-4" style="grid-template-columns:repeat(5,1fr);">
                <div class="widget-card">
                    <div class="widget-icon"><i class="fas fa-users"></i></div>
                    <div>
                        <div class="widget-value"><asp:Literal ID="litUsers" runat="server" /></div>
                        <div class="widget-label">Users</div>
                    </div>
                </div>
                <div class="widget-card">
                    <div class="widget-icon" style="background-color:var(--color-teal-soft); color:var(--color-teal);"><i class="fas fa-book"></i></div>
                    <div>
                        <div class="widget-value"><asp:Literal ID="litResources" runat="server" /></div>
                        <div class="widget-label">Resources</div>
                    </div>
                </div>
                <div class="widget-card">
                    <div class="widget-icon" style="background-color:var(--color-warning-soft); color:var(--color-warning);"><i class="fas fa-hourglass-half"></i></div>
                    <div>
                        <div class="widget-value"><asp:Literal ID="litPending" runat="server" /></div>
                        <div class="widget-label">Pending Approval</div>
                    </div>
                </div>
                <div class="widget-card">
                    <div class="widget-icon" style="background-color:#EDE9FE; color:#6D28D9;"><i class="fas fa-layer-group"></i></div>
                    <div>
                        <div class="widget-value"><asp:Literal ID="litCategories" runat="server" /></div>
                        <div class="widget-label">Categories</div>
                    </div>
                </div>
                <div class="widget-card">
                    <div class="widget-icon" style="background-color:var(--color-danger-soft); color:var(--color-danger);"><i class="fas fa-comments"></i></div>
                    <div>
                        <div class="widget-value"><asp:Literal ID="litDiscussions" runat="server" /></div>
                        <div class="widget-label">Discussions</div>
                    </div>
                </div>
            </div>

            <div style="display:grid; grid-template-columns: 1.2fr 1fr; gap: 24px; align-items:start;">

                <div>
                    <h3 class="mb-2">Quick Actions</h3>
                    <div style="display:grid; grid-template-columns: repeat(2, 1fr); gap: 16px;">
                        <a class="quick-action" href="AdminUsersPage.aspx">
                            <div class="icon"><i class="fas fa-users-gear"></i></div>
                            Manage Users
                        </a>
                        <a class="quick-action" href="AdminPendingResourcesPage.aspx">
                            <div class="icon"><i class="fas fa-clipboard-check"></i></div>
                            Review Pending
                            <asp:Literal ID="litPendingBadge" runat="server" />
                        </a>
                        <a class="quick-action" href="AdminCategoriesPage.aspx">
                            <div class="icon"><i class="fas fa-layer-group"></i></div>
                            Manage Categories
                        </a>
                        <a class="quick-action" href="QuizPage.aspx">
                            <div class="icon"><i class="fas fa-clipboard-list"></i></div>
                            Manage Quizzes
                        </a>
                    </div>
                </div>

                <div>
                    <h3 class="mb-2"><i class="fas fa-clock-rotate-left" style="color:var(--color-primary); margin-right:8px;"></i>Recent Activity</h3>
                    <div class="card" style="padding:6px 16px;">
                        <asp:Repeater ID="rptActivity" runat="server">
                            <ItemTemplate>
                                <div style="display:flex; align-items:flex-start; gap:12px; padding:12px 0; border-bottom:1px solid var(--color-border);">
                                    <div style="width:34px; height:34px; flex-shrink:0; border-radius:50%; background-color:var(--color-primary-soft); color:var(--color-primary); display:flex; align-items:center; justify-content:center; margin-top:2px;">
                                        <i class="fas <%# GetActivityIcon(Eval("ActivityType")) %>"></i>
                                    </div>
                                    <div style="min-width:0; flex:1;">
                                        <div style="display:flex; justify-content:space-between; align-items:baseline; gap:8px;">
                                            <span style="font-size:13px; font-weight:600; color:var(--color-text);"><%# Eval("ActivityType") %></span>
                                            <span style="font-size:11px; color:var(--color-text-secondary); white-space:nowrap;"><%# GetTimeAgo(Eval("ActivityDate")) %></span>
                                        </div>
                                        <div style="font-size:13px; color:var(--color-text-secondary); margin-top:2px;"><%# Eval("Detail") %></div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:Label ID="lblNoActivity" runat="server" CssClass="text-muted" Text="No recent activity yet." Visible="false" style="display:block; padding:16px; text-align:center;" />
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>