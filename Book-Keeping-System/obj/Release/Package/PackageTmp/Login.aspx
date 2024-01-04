<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Book_Keeping_System.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book Keeping System</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/font-awesome.css" rel="stylesheet" />
     <link href="Content/toastr.css" rel="stylesheet" />
    <link href="Content/jquery-ui.css" rel="stylesheet" />

    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.min.js"></script>
     <script src="scripts/toastr.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/bootstrap.bundle.min.js"></script>
    <style>
        #logincard {
            position: absolute;
            width: 600px;
            top: 25%;
            left: 27.5%;
        }

        html {
        height: 100%;
        }

        body {
            height: 100%;
            background-size: auto 100%;
            background-repeat: no-repeat;
            background-image: linear-gradient(to bottom right, white , #5da363);
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="scriptManager" />
    <div class="container">
        <%-- Login --%>
        <div class="card" id="logincard">
            <%-- Header --%>
            <div class="card-header bg-success-subtle">Login</div>
            <%-- Body --%>
            <div class="card-body">
                <%-- Username Textbox --%>
                <div class="row m-2">
                    <div class="form-floating">
                        <asp:TextBox runat="server" ID="txtUsername" CssClass="form-control" 
                            AutoCompleteType="Disabled"></asp:TextBox>
                        <label for="<%=txtUsername.ClientID%>">Username</label>
                    </div>
                    
                </div>
                <%-- Password Textbox --%>
                <div class="row m-2">
                    <div class="form-floating">
                        <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" 
                            AutoCompleteType="Disabled" TextMode="Password"></asp:TextBox>
                        <label for="<%=txtPassword.ClientID%>">Password</label>
                    </div>
                </div>
                <%-- Login Button --%>
                <div class="row m-2">
                    <div class="col-3 offset-9">
                        <asp:LinkButton runat="server" ID="btnLogin" CssClass="btn btn-success float-end" 
                            OnClick="btnLogin_Click">Login</asp:LinkButton>
                    </div>
                </div>
            </div>
            <%-- Footer --%>
            <div class="card-footer">Book Keeping System version 1.0</div>
        </div>
    </div>
    </form>
</body>
</html>
