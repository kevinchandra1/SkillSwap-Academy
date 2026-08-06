<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizTakePage.aspx.cs" Inherits="SkillSwapAcademy.QuizTakePage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Take Quiz - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links"><a href="QuizPage.aspx"><i class="fas fa-arrow-left"></i> Back to Quizzes</a></div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:720px;">
            <h2 class="mb-3"><i class="fas fa-pen-nib" style="color:var(--color-primary); margin-right:8px;"></i><asp:Literal ID="litQuizTitle" runat="server" /></h2>

            <asp:Repeater ID="rptQuestions" runat="server">
                <ItemTemplate>
                    <div class="card card-quiz mb-2">
                        <p style="font-weight:700;">Q<%# Container.ItemIndex + 1 %>. <%# Eval("QuestionText") %></p>
                        <asp:HiddenField runat="server" ID="hdnQuestionId" Value='<%# Eval("QuestionId") %>' />
                        <div class="quiz-options">
                            <label class="quiz-option">
                                <input type="radio" name='<%# "q" + Eval("QuestionId") %>' value="A" />
                                <%# Eval("OptionA") %>
                            </label>
                            <label class="quiz-option">
                                <input type="radio" name='<%# "q" + Eval("QuestionId") %>' value="B" />
                                <%# Eval("OptionB") %>
                            </label>
                            <label class="quiz-option">
                                <input type="radio" name='<%# "q" + Eval("QuestionId") %>' value="C" />
                                <%# Eval("OptionC") %>
                            </label>
                            <label class="quiz-option">
                                <input type="radio" name='<%# "q" + Eval("QuestionId") %>' value="D" />
                                <%# Eval("OptionD") %>
                            </label>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Button ID="btnSubmit" runat="server" Text="Submit Answers" CssClass="btn btn-primary btn-block"
                OnClick="btnSubmit_Click" OnClientClick="this.classList.add('loading');" />
        </div>
    </form>
</body>
</html>