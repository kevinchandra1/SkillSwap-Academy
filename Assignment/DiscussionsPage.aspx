<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DiscussionsPage.aspx.cs" Inherits="SkillSwapAcademy.DiscussionsPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Discussions - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links">
                <a href="LandingPage.aspx">Home</a>
                <a href="ResourcesPage.aspx">Learning Resources</a>
                <a href="DiscussionsPage.aspx" class="active">Discussions</a>
                <a href="QuizPage.aspx">Self-Assessment</a>
                <asp:Literal ID="litAuthLinks" runat="server" />
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:820px;">
            <div class="flex-between mb-3" style="flex-wrap:wrap; gap:12px;">
                <div>
                    <h2 style="margin-bottom:4px;"><i class="fas fa-comments" style="color:var(--color-primary); margin-right:8px;"></i>Discussion Forum</h2>
                    <p class="text-muted" style="margin:0;">Ask questions and share insights with the community.</p>
                </div>
                <asp:HyperLink ID="lnkNewDiscussion" runat="server" NavigateUrl="DiscussionCreatePage.aspx"
                    CssClass="btn btn-primary" Visible="false"><i class="fas fa-plus"></i> New Discussion</asp:HyperLink>
            </div>

            <asp:Repeater ID="rptDiscussions" runat="server">
                <ItemTemplate>
                    <div class="card mb-2">
                        <div class="flex-between" style="flex-wrap:wrap; gap:8px;">
                            <h4 style="margin:0;"><a href='<%# "DiscussionDetailsPage.aspx?id=" + Eval("DiscussionId") %>'><%# Eval("TopicTitle") %></a></h4>
                            <span class="badge badge-secondary"><i class="fas fa-reply"></i> <%# Eval("ReplyCount") %> replies</span>
                        </div>
                        <p class="text-muted" style="margin:6px 0 0;"><i class="fas fa-user"></i> by <%# Eval("FirstName") %> &middot; <%# ((DateTime)Eval("DateCreated")).ToString("dd MMM yyyy") %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="empty-state">
                <div class="icon"><i class="fas fa-comment-slash"></i></div>
                <asp:Label ID="lblEmpty" runat="server" Text="No discussions yet. Start the conversation!" Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>