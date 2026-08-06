<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizCreatePage.aspx.cs" Inherits="SkillSwapAcademy.QuizCreatePage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Quiz - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy <span class="badge badge-role-admin" style="margin-left:8px;">Instructor / Admin</span></div>
            <div class="nav-links"><a href="QuizPage.aspx"><i class="fas fa-arrow-left"></i> Back to Quizzes</a></div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:760px;">
            <div class="card mb-3">
                <div class="auth-title-icon"><i class="fas fa-clipboard-list"></i></div>
                <h2 style="margin-bottom:4px;">Create a Self-Assessment Quiz</h2>
                <p class="text-muted mb-3">Every quiz should be based on a specific learning resource, so questions have a clear content source.</p>
                <asp:Label ID="lblError" runat="server" CssClass="message-error" Visible="false" />

                <div class="form-group">
                    <div class="form-floating">
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder=" " />
                        <label class="floating-label">Quiz Title</label>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                        ErrorMessage="Quiz title is required." CssClass="message-error" Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label><i class="fas fa-layer-group"></i>Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label><i class="fas fa-link"></i>Based on Resource <span class="text-muted" style="font-weight:400;">(optional, but recommended)</span></label>
                    <asp:DropDownList ID="ddlResource" runat="server" CssClass="form-control" />
                </div>
            </div>

            <h4 class="mb-1"><i class="fas fa-list-check" style="color:var(--color-primary);"></i> Questions</h4>
            <p class="text-muted mb-3">Fill in up to 10 questions. Leave a question blank to skip it.</p>

            <asp:Repeater ID="rptQuestionSlots" runat="server">
                <ItemTemplate>
                    <div class="card card-quiz mb-2">
                        <label>Question <%# Container.ItemIndex + 1 %></label>
                        <asp:TextBox runat="server" ID="txtQuestionText" CssClass="form-control mb-2" placeholder="Question text (leave blank to skip)" />
                        <div class="grid-2">
                            <asp:TextBox runat="server" ID="txtOptionA" CssClass="form-control" placeholder="Option A" />
                            <asp:TextBox runat="server" ID="txtOptionB" CssClass="form-control" placeholder="Option B" />
                            <asp:TextBox runat="server" ID="txtOptionC" CssClass="form-control" placeholder="Option C" />
                            <asp:TextBox runat="server" ID="txtOptionD" CssClass="form-control" placeholder="Option D" />
                        </div>
                        <div class="mt-2">
                            <label>Correct Option</label>
                            <asp:DropDownList runat="server" ID="ddlCorrectOption" CssClass="form-control" style="max-width:110px;">
                                <asp:ListItem Text="A" Value="A" />
                                <asp:ListItem Text="B" Value="B" />
                                <asp:ListItem Text="C" Value="C" />
                                <asp:ListItem Text="D" Value="D" />
                            </asp:DropDownList>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Button ID="btnCreateQuiz" runat="server" Text="Create Quiz" CssClass="btn btn-primary btn-block mt-2"
                OnClick="btnCreateQuiz_Click" OnClientClick="this.classList.add('loading');" />
        </div>
    </form>
</body>
</html>