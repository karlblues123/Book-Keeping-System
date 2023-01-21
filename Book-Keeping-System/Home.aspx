<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Book_Keeping_System.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row mt-2">
            <div class="card col-7 me-2">
                <asp:Label runat="server" ID="lblTime"></asp:Label>
            </div>
            <%-- Deadline Card --%>
            <div class="card col-4">
                <div class="card-header">
                Deadlines
                </div>
                <div class="card-body">
                    <asp:GridView runat="server" ID="gvDeadlines" AutoGenerateColumns="false"></asp:GridView>
                </div>
            </div>
        </div>
        
    </div>
</asp:Content>
