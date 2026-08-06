<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="SkillSwapAcademy.LandingPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SkillSwap Academy</title>
    <link href="StyleSheet.css" rel="stylesheet" /><link rel="icon" type="image/svg+xml" href="Images/logo-icon.svg" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="topnav">
            <div class="brand"><img src="Images/logo-icon.svg" style="width:28px;height:28px;border-radius:8px;vertical-align:middle;margin-right:6px;" alt="Logo" />SkillSwap Academy</div>
            <div class="nav-links">
                <a href="LandingPage.aspx" class="active">Home</a>
                <a href="ResourcesPage.aspx">Learning Resources</a>
                <a href="DiscussionsPage.aspx">Discussions</a>
                <a href="QuizPage.aspx">Self-Assessment</a>
                <a href="MemberLogin.aspx">Login</a>
                <a href="MemberRegister.aspx" class="btn-light">Register</a>
            </div>
        </div>

        <div class="hero-illustration">
            <div class="illustration-overlay"></div>
            <div class="hero-illustration-content">
                <h1>Learn Together. Grow Together.</h1>
                <p>SkillSwap Academy is a peer-to-peer platform where students share knowledge and learn new skills.</p>
                <div class="hero-cta">
                    <a href="ResourcesPage.aspx" class="btn" style="background-color:#FFFFFF; color:var(--color-primary);"><i class="fas fa-compass"></i> Browse Resources</a>
                    <a href="MemberRegister.aspx" class="btn btn-outline" style="color:#FFFFFF; border-color:rgba(255,255,255,0.6);"><i class="fas fa-user-plus"></i> Join Now</a>
                </div>
            </div>
        </div>

        <div class="landing-textured-bg">

            <div class="container" style="padding-top:56px; padding-bottom:56px;">
                <div class="section-label"><i class="fas fa-layer-group"></i> Explore</div>
                <h3 class="mb-3">Browse by Category</h3>
                <div class="grid-3">
                    <asp:Repeater ID="rptCategories" runat="server">
                        <ItemTemplate>
                            <a class="category-tile" href='<%# "ResourcesPage.aspx?categoryId=" + Eval("CategoryId") %>'>
                                <div class="category-tile-icon"><i class="fas fa-tag"></i></div>
                                <%# Eval("CategoryName") %>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="container" style="padding-top:0; padding-bottom:56px;">
                <div class="section-label"><i class="fas fa-star"></i> Why SkillSwap Academy</div>
                <h3 class="mb-4">Built for peer-to-peer learning</h3>
                <div class="grid-3">
                    <div class="feature-tile">
                        <div class="feature-tile-icon"><i class="fas fa-chalkboard-user"></i></div>
                        <h4>Learn From Peers</h4>
                        <p>Get real, practical skills shared by students who've already mastered them.</p>
                    </div>
                    <div class="feature-tile">
                        <div class="feature-tile-icon"><i class="fas fa-comments"></i></div>
                        <h4>Join Discussions</h4>
                        <p>Ask questions, share insights, and connect with the SkillSwap community.</p>
                    </div>
                    <div class="feature-tile">
                        <div class="feature-tile-icon"><i class="fas fa-clipboard-check"></i></div>
                        <h4>Test Yourself</h4>
                        <p>Take quick self-assessment quizzes to check your understanding as you go.</p>
                    </div>
                </div>
            </div>

            <div class="container" style="padding-top:0; padding-bottom:64px;">
                <div class="section-label"><i class="fas fa-fire"></i> Fresh Content</div>
                <h3 class="mb-3">Latest Learning Resources</h3>
                <div class="grid">
                    <asp:Repeater ID="rptResources" runat="server">
                        <ItemTemplate>
                            <div class="card card-resource">
                                <span class="badge"><%# Eval("CategoryName") %></span>
                                <h4 style="margin-top:12px;"><%# Eval("Title") %></h4>
                                <p class="text-muted"><i class="fas fa-user"></i> by <%# Eval("FirstName") %></p>
                                <a class="btn btn-primary btn-block" href='<%# "ResourceDetailsPage.aspx?id=" + Eval("ResourceId") %>'>View <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="empty-state">
                    <div class="icon"><i class="fas fa-box-open"></i></div>
                    <h4>Nothing here yet</h4>
                    <asp:Label ID="lblEmpty" runat="server" CssClass="text-muted" Text="No resources published yet. Be the first to share one!" Visible="false" />
                    <div style="margin-top:12px;">
                        <a class="btn btn-primary" href="MemberRegister.aspx"><i class="fas fa-plus"></i> Share the First Resource</a>
                    </div>
                </div>
            </div>

        </div>

        <footer class="site-footer">
            <div class="footer-inner">
                <div class="footer-brand">
                    <h3><i class="fas fa-seedling"></i> SkillSwap Academy</h3>
                    <p>A peer-to-peer learning platform where students share knowledge, upload resources, and grow together.</p>
                    <div class="footer-social">
                        <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                <div class="footer-links">
                    <h4>Quick Links</h4>
                    <a href="LandingPage.aspx">Home</a>
                    <a href="ResourcesPage.aspx">Learning Resources</a>
                    <a href="DiscussionsPage.aspx">Discussions</a>
                    <a href="QuizPage.aspx">Self-Assessment</a>
                </div>
                <div class="footer-links">
                    <h4>Account</h4>
                    <a href="MemberLogin.aspx">Member Login</a>
                    <a href="MemberRegister.aspx">Register</a>
                    <a href="AdminLogin.aspx">Admin Login</a>
                </div>
            </div>
            <div class="footer-bottom">
                &copy; <%= DateTime.Now.Year %> SkillSwap Academy &middot; CT050-3-2-WAPP Group Assignment
            </div>
        </footer>
    </form>
</body>
</html>