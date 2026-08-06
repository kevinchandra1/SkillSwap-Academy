<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizHistoryPage.aspx.cs" Inherits="SkillSwapAcademy.QuizHistoryPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Quiz History - SkillSwap Academy</title>
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
            <h2 class="mb-3"><i class="fas fa-clock-rotate-left" style="color:var(--color-primary); margin-right:8px;"></i>My Quiz History</h2>
            <asp:GridView ID="gvHistory" runat="server" CssClass="data-table" AutoGenerateColumns="false"
                EmptyDataText="You haven't taken any quizzes yet.">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Quiz" />
                    <asp:TemplateField HeaderText="Score">
                        <ItemTemplate><span class="badge badge-success"><%# Eval("Score") %> / <%# Eval("TotalQuestions") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DateTaken" HeaderText="Date Taken" DataFormatString="{0:dd MMM yyyy HH:mm}" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>