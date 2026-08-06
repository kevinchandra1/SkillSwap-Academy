<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceEditPage.aspx.cs" Inherits="SkillSwapAcademy.ResourceEditPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Resource - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links">
                <a href="MyResourcesPage.aspx"><i class="fas fa-arrow-left"></i> My Resources</a>
                <a href="LogoutPage.aspx"><i class="fas fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px; max-width:640px;">
            <div class="card">
                <div class="auth-title-icon"><i class="fas fa-pen-to-square"></i></div>
                <h2 style="margin-bottom:4px;">Edit Resource</h2>
                <p class="text-muted mb-3">Update the details of your shared resource.</p>

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
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
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
                </div>
                <div class="form-group">
                    <asp:Image ID="imgExisting" runat="server" CssClass="rounded-lg" style="max-height:120px;margin-bottom:10px;display:block;" Visible="false" />
                    <label><i class="fas fa-image"></i>Replace Cover Image (optional)</label>
                    <asp:FileUpload ID="fileImage" runat="server" CssClass="form-control" style="padding-top:10px;" />
                </div>
                <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-primary btn-block"
                    OnClick="btnSave_Click" OnClientClick="this.classList.add('loading');" />
            </div>
        </div>
    </form>
</body>
</html>