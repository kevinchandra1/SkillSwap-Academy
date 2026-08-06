<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DiscussionDetailsPage.aspx.cs" Inherits="SkillSwapAcademy.DiscussionDetailsPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Discussion - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links"><a href="DiscussionsPage.aspx"><i class="fas fa-arrow-left"></i> Back to Discussions</a></div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:720px;">
            <div class="card mb-3">
                <h3><asp:Literal ID="litTopicTitle" runat="server" /></h3>
                <p class="text-muted"><i class="fas fa-user"></i> by <asp:Literal ID="litAuthor" runat="server" /> &middot; <asp:Literal ID="litDate" runat="server" /></p>
                <hr />
                <p><asp:Literal ID="litContent" runat="server" /></p>
            </div>

            <h4 class="mb-2"><i class="fas fa-reply" style="color:var(--color-primary);"></i> Replies</h4>
            <asp:Repeater ID="rptReplies" runat="server">
                <ItemTemplate>
                    <div class="card mb-2">
                        <p style="margin-bottom:6px;"><%# Eval("ReplyContent") %></p>
                        <small class="text-muted"><i class="fas fa-user"></i> <%# Eval("FirstName") %> &middot; <%# ((DateTime)Eval("DateCreated")).ToString("dd MMM yyyy HH:mm") %></small>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:PlaceHolder ID="phReplyForm" runat="server" Visible="false">
                <div class="card mt-3">
                    <div class="form-group">
                        <label><i class="fas fa-pen"></i>Your Reply</label>
                        <asp:TextBox ID="txtReply" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Write a reply..." />
                        <asp:RequiredFieldValidator ID="rfvReply" runat="server" ControlToValidate="txtReply"
                            ErrorMessage="Reply cannot be empty." CssClass="message-error" Display="Dynamic" />
                    </div>
                    <asp:Button ID="btnReply" runat="server" Text="Post Reply" CssClass="btn btn-primary" OnClick="btnReply_Click" />
                </div>
            </asp:PlaceHolder>
            <asp:Literal ID="litLoginPrompt" runat="server" Visible="false" Text="<div class='alert alert-info'><i class='fas fa-circle-info'></i> <a href='MemberLogin.aspx'>Login</a> to join the discussion.</div>" />
        </div>
    </form>
</body>
</html>