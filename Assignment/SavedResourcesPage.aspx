<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SavedResourcesPage.aspx.cs" Inherits="SkillSwapAcademy.SavedResourcesPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Saved Resources - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links">
                <a href="MemberDashboard.aspx">Dashboard</a>
                <a href="LogoutPage.aspx"><i class="fas fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px;">
            <h2 class="mb-3"><i class="fas fa-bookmark" style="color:var(--color-primary); margin-right:8px;"></i>My Saved Resources</h2>

            <div class="grid">
                <asp:Repeater ID="rptSaved" runat="server">
                    <ItemTemplate>
                        <div class="card card-resource">
                            <span class="badge"><%# Eval("CategoryName") %></span>
                            <h4 style="margin-top:12px;"><%# Eval("Title") %></h4>
                            <p class="text-muted"><i class="fas fa-clock"></i> Saved on <%# ((DateTime)Eval("DateSaved")).ToString("dd MMM yyyy") %></p>
                            <a class="btn btn-primary btn-block" href='<%# "ResourceDetailsPage.aspx?id=" + Eval("ResourceId") %>'>View <i class="fas fa-arrow-right"></i></a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="empty-state">
                <div class="icon"><i class="fas fa-bookmark"></i></div>
                <asp:Label ID="lblEmpty" runat="server" Text="You haven't saved any resources yet." Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>