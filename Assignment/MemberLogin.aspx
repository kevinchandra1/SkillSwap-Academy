<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberLogin.aspx.cs" Inherits="SkillSwapAcademy.MemberLogin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - SkillSwap Academy</title>
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
                    <div class="auth-title-icon"><i class="fas fa-right-to-bracket"></i></div>
                    <h2 class="auth-title">Welcome Back</h2>
                    <p class="auth-subtitle">Login to continue your learning journey.</p>
                    <asp:Label ID="lblMessage" runat="server" CssClass="message-error" Visible="false" />

                    <div class="form-group">
                        <div class="form-floating input-icon">
                            <i class="fas fa-user icon"></i>
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
                    <div class="form-group" style="display:flex; align-items:center; gap:8px;">
                        <asp:CheckBox ID="chkRememberMe" runat="server" />
                        <label style="margin:0;">Remember Me</label>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-block"
                        OnClick="btnLogin_Click" OnClientClick="this.classList.add('loading');" />
                    <p class="auth-switch-link">Don't have an account? <a href="MemberRegister.aspx">Register here</a></p>
                    <p style="text-align:center; color:var(--color-text-secondary); font-size:13px; margin-top:8px;">
                        Admin? <a href="AdminLogin.aspx">Login here</a> &middot; Demo: admin / Admin123
                    </p>
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