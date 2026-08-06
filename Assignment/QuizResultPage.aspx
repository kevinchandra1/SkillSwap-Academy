<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizResultPage.aspx.cs" Inherits="SkillSwapAcademy.QuizResultPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quiz Result - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links"><a href="QuizPage.aspx"><i class="fas fa-arrow-left"></i> Back to Quizzes</a></div>
        </div>

        <div class="container" style="padding-top:64px; padding-bottom:48px; max-width:480px; text-align:center;">
            <div class="card">
                <div class="auth-title-icon" style="margin:0 auto var(--space-2);"><i class="fas fa-trophy"></i></div>
                <h3>Quiz Result: <asp:Literal ID="litQuizTitle" runat="server" /></h3>
                <h1 class="gradient-text" style="font-size:48px;"><asp:Literal ID="litScore" runat="server" /></h1>
                <p class="text-muted"><i class="fas fa-calendar"></i> Taken on <asp:Literal ID="litDate" runat="server" /></p>
                <div class="flex gap-2" style="justify-content:center; flex-wrap:wrap;">
                    <a class="btn btn-primary" href="QuizPage.aspx"><i class="fas fa-list"></i> Back to Quizzes</a>
                    <a class="btn btn-outline" href="QuizHistoryPage.aspx"><i class="fas fa-clock-rotate-left"></i> My Quiz History</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>