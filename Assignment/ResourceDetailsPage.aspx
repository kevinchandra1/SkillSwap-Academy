<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceDetailsPage.aspx.cs" Inherits="SkillSwapAcademy.ResourceDetailsPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Resource Details - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links">
                <a href="ResourcesPage.aspx"><i class="fas fa-arrow-left"></i> Back to Resources</a>
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:800px;">
            <div class="card">
                <asp:Image ID="imgResource" runat="server" CssClass="rounded-lg" style="max-width:100%;max-height:340px;width:100%;object-fit:cover;margin-bottom:18px;" Visible="false" />
                <span class="badge"><i class="fas fa-tag"></i> <asp:Literal ID="litCategory" runat="server" /></span>
                <h2 style="margin-top:14px;"><asp:Literal ID="litTitle" runat="server" /></h2>
                <p class="text-muted"><i class="fas fa-user"></i> Shared by <asp:Literal ID="litUploader" runat="server" /> &middot; <i class="fas fa-calendar"></i> <asp:Literal ID="litDate" runat="server" /></p>
                <hr />
                <p><asp:Literal ID="litDescription" runat="server" /></p>
                <asp:HyperLink ID="lnkContentUrl" runat="server" CssClass="btn btn-outline" Target="_blank" Visible="false"><i class="fas fa-up-right-from-square"></i> Open Resource Link</asp:HyperLink>

                <hr />
                <asp:Button ID="btnToggleSave" runat="server" CssClass="btn btn-secondary" OnClick="btnToggleSave_Click" Visible="false" />
                <asp:Literal ID="litLoginPrompt" runat="server" Visible="false" Text="<a href='MemberLogin.aspx'>Login</a> to save this resource or join the discussion." />
            </div>
        </div>
    </form>
</body>
</html>