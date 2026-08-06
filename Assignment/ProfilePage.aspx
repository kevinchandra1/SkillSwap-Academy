<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="SkillSwapAcademy.ProfilePage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Profile - SkillSwap Academy</title>
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

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:560px;">
            <div class="card">
                <div class="auth-title-icon"><i class="fas fa-user-gear"></i></div>
                <h2 style="margin-bottom:4px;">My Profile</h2>
                <p class="text-muted mb-3">Update your personal information.</p>
                <asp:Label ID="lblMessage" runat="server" CssClass="message-success" Visible="false" />

                <div class="form-group">
                    <div class="form-floating">
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder=" " />
                        <label class="floating-label">First Name</label>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                        ErrorMessage="First name is required." CssClass="message-error" Display="Dynamic" />
                </div>
                <div class="form-group">
                    <div class="form-floating">
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder=" " />
                        <label class="floating-label">Last Name</label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="form-floating input-icon">
                        <i class="fas fa-envelope icon"></i>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder=" " />
                        <label class="floating-label">Email</label>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="Email is required." CssClass="message-error" Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label><i class="fas fa-quote-left"></i>Bio</label>
                    <asp:TextBox ID="txtBio" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Tell the community about yourself..." />
                </div>
                <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-primary btn-block"
                    OnClick="btnSave_Click" OnClientClick="this.classList.add('loading');" />
            </div>
        </div>
    </form>
</body>
</html>