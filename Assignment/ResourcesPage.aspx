<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourcesPage.aspx.cs" Inherits="SkillSwapAcademy.ResourcesPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Learning Resources - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links">
                <a href="LandingPage.aspx">Home</a>
                <a href="ResourcesPage.aspx" class="active">Learning Resources</a>
                <a href="DiscussionsPage.aspx">Discussions</a>
                <a href="QuizPage.aspx">Self-Assessment</a>
                <asp:Literal ID="litAuthLinks" runat="server" />
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px;">
            <div class="flex-between mb-3" style="flex-wrap:wrap; gap:12px;">
                <div>
                    <h2 style="margin-bottom:4px;"><i class="fas fa-book" style="color:var(--color-primary); margin-right:8px;"></i>Learning Resources</h2>
                    <p class="text-muted" style="margin:0;">Discover skills shared by the SkillSwap community.</p>
                </div>
                <asp:PlaceHolder ID="phShareLink" runat="server" Visible="false">
                    <a class="btn btn-primary" href="ResourceCreatePage.aspx"><i class="fas fa-plus"></i> Share a Resource</a>
                </asp:PlaceHolder>
            </div>

            <div class="filter-panel">
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" style="max-width:220px;">
                    <asp:ListItem Text="All Categories" Value="" />
                </asp:DropDownList>
                <div class="search-box" style="flex:1; min-width:220px;">
                    <i class="fas fa-search search-icon"></i>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search resource title..." />
                </div>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
            </div>

            <div class="grid">
                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="card card-resource">
                            <span class="badge"><%# Eval("CategoryName") %></span>
                            <h4 style="margin-top:12px;"><%# Eval("Title") %></h4>
                            <p class="text-muted"><i class="fas fa-user"></i> by <%# Eval("FirstName") %></p>
                            <a class="btn btn-primary btn-block" href='<%# "ResourceDetailsPage.aspx?id=" + Eval("ResourceId") %>'>View Details <i class="fas fa-arrow-right"></i></a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="empty-state">
                <div class="icon"><i class="fas fa-inbox"></i></div>
                <asp:Label ID="lblNoResults" runat="server" Text="No resources found." Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>