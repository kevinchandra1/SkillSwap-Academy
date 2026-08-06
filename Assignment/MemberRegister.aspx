<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberRegister.aspx.cs" Inherits="SkillSwapAcademy.MemberRegister" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register - SkillSwap Academy</title>
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
                    <div class="auth-title-icon"><i class="fas fa-user-graduate"></i></div>
                    <h2 class="auth-title">Create Member Account</h2>
                    <p class="auth-subtitle">Join thousands of students learning together.</p>
                    <asp:Label ID="lblMessage" runat="server" Visible="false" />

                    <div class="form-group">
                        <div class="form-floating input-icon">
                            <i class="fas fa-user icon"></i>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder=" " />
                            <label class="floating-label">Username</label>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                            ErrorMessage="Username is required." CssClass="message-error" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <div class="form-floating input-icon">
                            <i class="fas fa-envelope icon"></i>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder=" " />
                            <label class="floating-label">Email</label>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email is required." CssClass="message-error" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Enter a valid email address."
                            CssClass="message-error" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <div class="form-floating input-icon">
                            <i class="fas fa-id-card icon"></i>
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder=" " />
                            <label class="floating-label">First Name</label>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                            ErrorMessage="First name is required." CssClass="message-error" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <div class="form-floating input-icon">
                            <i class="fas fa-id-card icon"></i>
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder=" " />
                            <label class="floating-label">Last Name</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-floating input-icon password-field">
                            <i class="fas fa-lock icon"></i>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder=" " />
                            <label class="floating-label">Password</label>
                            <button type="button" class="password-toggle" onclick="skillswapTogglePassword('<%= txtPassword.ClientID %>', this)"><i class="fas fa-eye"></i></button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Password is required." CssClass="message-error" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                            ValidationExpression=".{6,}" ErrorMessage="Password must be at least 6 characters."
                            CssClass="message-error" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <div class="form-floating input-icon password-field">
                            <i class="fas fa-lock icon"></i>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder=" " />
                            <label class="floating-label">Confirm Password</label>
                            <button type="button" class="password-toggle" onclick="skillswapTogglePassword('<%= txtConfirmPassword.ClientID %>', this)"><i class="fas fa-eye"></i></button>
                        </div>
                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword" ErrorMessage="Passwords do not match."
                            CssClass="message-error" Display="Dynamic" />
                    </div>
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary btn-block"
                        OnClick="btnRegister_Click" OnClientClick="this.classList.add('loading');" />
                    <p class="auth-switch-link">Already have an account? <a href="MemberLogin.aspx">Login</a></p>
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