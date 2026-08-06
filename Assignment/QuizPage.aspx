<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizPage.aspx.cs" Inherits="SkillSwapAcademy.QuizPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Self-Assessment - SkillSwap Academy</title>
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
                <a href="DiscussionsPage.aspx">Discussions</a>
                <a href="QuizPage.aspx" class="active">Self-Assessment</a>
                <asp:Literal ID="litAuthLinks" runat="server" />
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px;">
            <div class="flex-between mb-1" style="flex-wrap:wrap; gap:12px;">
                <h2 style="margin:0;"><i class="fas fa-clipboard-check" style="color:var(--color-primary); margin-right:8px;"></i>Online Self-Assessment</h2>
                <asp:HyperLink ID="lnkCreateQuiz" runat="server" NavigateUrl="QuizCreatePage.aspx"
                    CssClass="btn btn-primary" Visible="false"><i class="fas fa-plus"></i> Create Quiz</asp:HyperLink>
            </div>
            <p class="text-muted mb-3">Test your understanding of a topic with a short quiz.</p>

            <div class="grid">
                <asp:Repeater ID="rptQuizzes" runat="server" OnItemCommand="rptQuizzes_ItemCommand">
                    <ItemTemplate>
                        <div class="card card-quiz">
                            <span class="badge"><%# Eval("CategoryName") %></span>
                            <h4 style="margin-top:12px;"><%# Eval("Title") %></h4>
                            <p class="text-muted"><i class="fas fa-list-ol"></i> <%# Eval("QuestionCount") %> question(s)</p>
                            <div class="flex gap-1" style="flex-wrap:wrap;">
                                <asp:HyperLink runat="server" CssClass="btn btn-sm btn-primary"
                                    NavigateUrl='<%# "QuizTakePage.aspx?id=" + Eval("QuizId") %>'
                                    Visible='<%# Page.Session["AccountId"] != null %>'><i class="fas fa-play"></i> Take Quiz</asp:HyperLink>
                                <asp:HyperLink runat="server" CssClass="btn btn-sm btn-outline" NavigateUrl="MemberLogin.aspx"
                                    Text="Login to Take" Visible='<%# Page.Session["AccountId"] == null %>' />
                                <asp:Button runat="server" Text="Delete" CssClass="btn btn-sm btn-danger"
                                    CommandName="DeleteQuiz" CommandArgument='<%# Eval("QuizId") %>'
                                    OnClientClick="return confirm('Delete this quiz?');"
                                    Visible='<%# (Page.Session["Role"] as string) == "Admin" %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="empty-state">
                <div class="icon"><i class="fas fa-clipboard-question"></i></div>
                <asp:Label ID="lblEmpty" runat="server" Text="No quizzes available yet." Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>