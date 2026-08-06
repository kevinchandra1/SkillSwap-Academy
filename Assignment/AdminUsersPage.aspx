<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminUsersPage.aspx.cs" Inherits="SkillSwapAcademy.AdminUsersPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Users - SkillSwap Academy</title>
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
            <h2 class="mb-3"><i class="fas fa-users-gear" style="color:var(--color-primary); margin-right:8px;"></i>Manage Users</h2>
            <asp:GridView ID="gvUsers" runat="server" CssClass="data-table" AutoGenerateColumns="false"
                DataKeyNames="AccountId" OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:TemplateField HeaderText="Role">
                        <ItemTemplate>
                            <asp:DropDownList runat="server" ID="ddlRole" CssClass="form-control">
                                <asp:ListItem Text="Member" Value="Member" />
                                <asp:ListItem Text="Instructor" Value="Instructor" />
                                <asp:ListItem Text="Admin" Value="Admin" />
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control">
                                <asp:ListItem Text="Active" Value="true" />
                                <asp:ListItem Text="Suspended" Value="false" />
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Update" CssClass="btn btn-sm btn-outline"
                                CommandName="UpdateUser" CommandArgument='<%# Eval("AccountId") %>' />
                            <asp:Button runat="server" Text="Delete" CssClass="btn btn-sm btn-danger"
                                CommandName="DeleteUser" CommandArgument='<%# Eval("AccountId") %>'
                                OnClientClick="return confirm('Delete this user?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>