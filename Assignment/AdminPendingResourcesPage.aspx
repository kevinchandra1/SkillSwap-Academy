<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPendingResourcesPage.aspx.cs" Inherits="SkillSwapAcademy.AdminPendingResourcesPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pending Resources - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy <span class="badge badge-role-admin" style="margin-left:8px;">Admin</span></div>
            <div class="nav-links">
                <a href="AdminDashboard.aspx">Dashboard</a>
                <a href="LogoutPage.aspx"><i class="fas fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px;">
            <h2 class="mb-3"><i class="fas fa-hourglass-half" style="color:var(--color-warning); margin-right:8px;"></i>Pending Resource Approvals</h2>

            <asp:Repeater ID="rptPending" runat="server" OnItemCommand="rptPending_ItemCommand">
                <ItemTemplate>
                    <div class="card mb-2">
                        <div class="flex-between" style="flex-wrap:wrap; gap:12px;">
                            <div>
                                <h4 style="margin-bottom:4px;"><%# Eval("Title") %></h4>
                                <p class="text-muted" style="margin-bottom:8px;"><%# Eval("CategoryName") %> &middot; <i class="fas fa-user"></i> <%# Eval("FirstName") %> &middot; <%# ((DateTime)Eval("UploadDate")).ToString("dd MMM yyyy") %></p>
                                <p style="margin:0;"><%# Eval("Description") %></p>
                            </div>
                            <div class="flex gap-1" style="flex-shrink:0;">
                                <asp:Button runat="server" Text="Approve" CssClass="btn btn-sm btn-success"
                                    CommandName="Approve" CommandArgument='<%# Eval("ResourceId") %>' />
                                <asp:Button runat="server" Text="Reject" CssClass="btn btn-sm btn-danger"
                                    CommandName="Reject" CommandArgument='<%# Eval("ResourceId") %>'
                                    OnClientClick="return confirm('Reject and delete this resource?');" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="empty-state">
                <div class="icon"><i class="fas fa-circle-check"></i></div>
                <asp:Label ID="lblEmpty" runat="server" Text="No pending resources. All caught up!" Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>