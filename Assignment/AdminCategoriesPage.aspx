<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminCategoriesPage.aspx.cs" Inherits="SkillSwapAcademy.AdminCategoriesPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Categories - SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy <span class="badge badge-role-admin" style="margin-left:8px;">Admin</span></div>
            <div class="nav-links">
                <a href="AdminDashboard.aspx">Dashboard</a>
                <a href="LogoutPage.aspx"><i class="fas fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>

        <div class="container" style="padding-top:32px; padding-bottom:48px;">
            <h2 class="mb-3"><i class="fas fa-layer-group" style="color:var(--color-primary); margin-right:8px;"></i>Manage Categories</h2>

            <div class="card mb-3" style="max-width:520px;">
                <h4><asp:Literal ID="litFormTitle" runat="server" Text="Add Category" /></h4>
                <asp:HiddenField ID="hdnCategoryId" runat="server" Value="0" />
                <div class="form-group">
                    <div class="form-floating">
                        <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder=" " />
                        <label class="floating-label">Category Name</label>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtCategoryName"
                        ErrorMessage="Category name is required." CssClass="message-error" Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label><i class="fas fa-align-left"></i>Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                </div>
                <div class="flex gap-2">
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel Edit" CssClass="btn btn-ghost" OnClick="btnCancel_Click" CausesValidation="false" />
                </div>
            </div>

            <asp:GridView ID="gvCategories" runat="server" CssClass="data-table" AutoGenerateColumns="false"
                DataKeyNames="CategoryId" OnRowCommand="gvCategories_RowCommand">
                <Columns>
                    <asp:BoundField DataField="CategoryName" HeaderText="Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Edit" CssClass="btn btn-sm btn-outline"
                                CommandName="EditCategory" CommandArgument='<%# Eval("CategoryId") %>' CausesValidation="false" />
                            <asp:Button runat="server" Text="Delete" CssClass="btn btn-sm btn-danger"
                                CommandName="DeleteCategory" CommandArgument='<%# Eval("CategoryId") %>'
                                OnClientClick="return confirm('Delete this category?');" CausesValidation="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>