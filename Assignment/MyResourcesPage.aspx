<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyResourcesPage.aspx.cs" Inherits="SkillSwapAcademy.MyResourcesPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Resources - SkillSwap Academy</title>
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

        <div class="container" style="padding-top:32px; padding-bottom:48px;">
            <div class="flex-between mb-3" style="flex-wrap:wrap; gap:12px;">
                <h2 style="margin:0;"><i class="fas fa-folder-open" style="color:var(--color-primary); margin-right:8px;"></i>My Shared Resources</h2>
                <a class="btn btn-primary" href="ResourceCreatePage.aspx"><i class="fas fa-plus"></i> Share New Resource</a>
            </div>

            <asp:GridView ID="gvResources" runat="server" CssClass="data-table" AutoGenerateColumns="false"
                DataKeyNames="ResourceId" OnRowCommand="gvResources_RowCommand" EmptyDataText="You haven't shared any resources yet.">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Category" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <%# (bool)Eval("IsApproved") ? "<span class='badge badge-success'><i class=\"fas fa-check\"></i> Published</span>" : "<span class='badge badge-secondary'><i class=\"fas fa-clock\"></i> Pending</span>" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UploadDate" HeaderText="Uploaded" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <a class="btn btn-sm btn-outline" href='<%# "ResourceEditPage.aspx?id=" + Eval("ResourceId") %>'><i class="fas fa-pen"></i> Edit</a>
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger"
                                CommandName="DeleteResource" CommandArgument='<%# Eval("ResourceId") %>'
                                OnClientClick="return confirm('Delete this resource?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>