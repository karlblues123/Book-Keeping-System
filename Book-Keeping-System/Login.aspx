<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Book_Keeping_System.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book Keeping System</title>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <script src="js/bootstrap.js"></script>
    <style>
        #logincard {
            position: absolute;
            width: 600px;
            top: 25%;
            left: 25%;
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

        .feather {
            width: 24px;
              height: 24px;
              stroke: blue;
              stroke-width: 2;
              stroke-linecap: round;
              stroke-linejoin: round;
              fill: none;
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
            <div class="card-header" style="background-color:powderblue">Login</div>
            <%-- Body --%>
            <div class="card-body">
                <%-- Username Textbox --%>
                <div class="input-group mb-2">
                    <span class="input-group-text">
                        <object type="image/svg+xml" data="css/feather/user.svg"></object>
                    </span>
                    <asp:TextBox runat="server" ID="txtUsername" CssClass="form-control" 
                        AutoCompleteType="Disabled" placeholder="Username"></asp:TextBox>
                </div>
                <%-- Password Textbox --%>
                <div class="input-group mb-2">
                    <span class="input-group-text">
                        <object type="image/svg+xml" data="css/feather/key.svg"></object>
                    </span>
                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" 
                        AutoCompleteType="Disabled" TextMode="Password" placeholder="Password"></asp:TextBox>
                </div>
                <%-- Login Button --%>
                <div class="clearfix">
                    <asp:LinkButton runat="server" ID="btnLogin" CssClass="btn btn-success float-end" 
                        OnClick="btnLogin_Click">Login</asp:LinkButton>
                </div>
            </div>
            <%-- Footer --%>
            <div class="card-footer">Book Keeping System version 1.0</div>
        </div>
    </div>
    </form>
</body>
</html>
