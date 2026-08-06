<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DiscussionCreatePage.aspx.cs" Inherits="SkillSwapAcademy.DiscussionCreatePage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Discussion - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links"><a href="DiscussionsPage.aspx"><i class="fas fa-arrow-left"></i> Back to Discussions</a></div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:640px;">
            <div class="card">
                <div class="auth-title-icon"><i class="fas fa-comment-medical"></i></div>
                <h2 style="margin-bottom:4px;">Start a New Discussion</h2>
                <p class="text-muted mb-3">Ask a question or share something with the community.</p>

                <div class="form-group">
                    <div class="form-floating">
                        <asp:TextBox ID="txtTopicTitle" runat="server" CssClass="form-control" placeholder=" " />
                        <label class="floating-label">Topic Title</label>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTopicTitle"
                        ErrorMessage="Topic title is required." CssClass="message-error" Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label><i class="fas fa-align-left"></i>Content</label>
                    <asp:TextBox ID="txtContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="What's on your mind?" />
                    <asp:RequiredFieldValidator ID="rfvContent" runat="server" ControlToValidate="txtContent"
                        ErrorMessage="Content is required." CssClass="message-error" Display="Dynamic" />
                </div>
                <asp:Button ID="btnPost" runat="server" Text="Post Discussion" CssClass="btn btn-primary btn-block"
                    OnClick="btnPost_Click" OnClientClick="this.classList.add('loading');" />
            </div>
        </div>
    </form>
</body>
</html>