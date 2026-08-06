<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SkillSwapAcademy.AdminLogin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="illustration-page">
            <div class="illustration-overlay"></div>

            <div class="illustration-content">
                <a href="LandingPage.aspx" class="illustration-brand"><img src="Images/logo-icon.svg" style="width:24px;height:24px;border-radius:6px;vertical-align:middle;margin-right:4px;" alt="Logo" />SkillSwap Academy</a>

                <div class="illustration-card">
                    <div class="auth-title-icon" style="background: linear-gradient(135deg, #6D28D9, #3D2E7C);"><i class="fas fa-shield-halved"></i></div>
                    <h2 class="auth-title">Admin Login</h2>
                    <p class="auth-subtitle">Restricted access &mdash; administrators only.</p>
                    <asp:Label ID="lblMessage" runat="server" CssClass="message-error" Visible="false" />

                    <div class="form-group">
                        <div class="form-floating input-icon">
                            <i class="fas fa-user-shield icon"></i>
                            <asp:TextBox ID="txtLogin" runat="server" CssClass="form-control" placeholder=" " />
                            <label class="floating-label">Username or Email</label>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvLogin" runat="server" ControlToValidate="txtLogin"
                            ErrorMessage="Please enter your username or email." CssClass="message-error" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <div class="form-floating input-icon password-field">
                            <i class="fas fa-lock icon"></i>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder=" " />
                            <label class="floating-label">Password</label>
                            <button type="button" class="password-toggle" onclick="skillswapTogglePassword('<%= txtPassword.ClientID %>', this)"><i class="fas fa-eye"></i></button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Please enter your password." CssClass="message-error" Display="Dynamic" />
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login as Admin" CssClass="btn btn-primary btn-block"
                        OnClick="btnLogin_Click" OnClientClick="this.classList.add('loading');" />
                    <p class="auth-switch-link">Not an admin? <a href="MemberLogin.aspx">Member login</a></p>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            function skillswapTogglePassword(fieldId, btn) {
                var field = document.getElementById(fieldId);
                if (!field) return;
                var icon = btn.querySelector("i");
                if (field.type === "password") {
                    field.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    field.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }
        </script>
    </form>
</body>
</html>