<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceCreatePage.aspx.cs" Inherits="SkillSwapAcademy.ResourceCreatePage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Share a Resource - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links">
                <a href="MemberDashboard.aspx">Dashboard</a>
                <a href="LogoutPage.aspx"><i class="fas fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:640px;">
            <div class="card">
                <div class="auth-title-icon"><i class="fas fa-cloud-arrow-up"></i></div>
                <h2 style="margin-bottom:4px;">Share a Learning Resource</h2>
                <p class="text-muted mb-3">Help others learn something new.</p>

                <div class="form-group">
                    <div class="form-floating">
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder=" " />
                        <label class="floating-label">Title</label>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                        ErrorMessage="Title is required." CssClass="message-error" Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label><i class="fas fa-align-left"></i>Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Describe what learners will gain from this resource..." />
                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                        ErrorMessage="Description is required." CssClass="message-error" Display="Dynamic" />
                </div>
                <div class="form-group">
                    <div class="form-floating input-icon">
                        <i class="fas fa-link icon"></i>
                        <asp:TextBox ID="txtContentUrl" runat="server" CssClass="form-control" placeholder=" " />
                        <label class="floating-label">External Link (optional)</label>
                    </div>
                </div>
                <div class="form-group">
                    <label><i class="fas fa-layer-group"></i>Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                        InitialValue="" ErrorMessage="Please select a category." CssClass="message-error" Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label><i class="fas fa-image"></i>Cover Image (optional)</label>
                    <asp:FileUpload ID="fileImage" runat="server" CssClass="form-control" style="padding-top:10px;" />
                </div>
                <asp:Button ID="btnPublish" runat="server" Text="Publish Resource" CssClass="btn btn-primary btn-block"
                    OnClick="btnPublish_Click" OnClientClick="this.classList.add('loading');" />
            </div>
        </div>
    </form>
</body>
</html>