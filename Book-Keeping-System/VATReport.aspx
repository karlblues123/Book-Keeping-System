<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VATReport.aspx.cs" Inherits="Book_Keeping_System.VATReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="card mt-2">
            <div class="card-header" style="background-color:powderblue">
                VAT Report
            </div>
            <div class="card-body">
                <div class="card">
                    <div class="card-header">
                        <div class="input-group">
                            <asp:TextBox runat="server" ID="txtSearch" AutoCompleteType="Disabled" placeholder="Search"
                                CssClass="form-control"></asp:TextBox>
                            <div class="btn-group">
                                <asp:LinkButton runat="server" ID="lnkSearch" CssClass="btn btn-success">Search</asp:LinkButton>
                                <asp:LinkButton runat="server" ID="lnkAdd" CssClass="btn btn-primary">Add</asp:LinkButton>
                            </div> 
                        </div>
                    </div>
                    <div class="card-body">
                        <%-- TODO List of Suppliers in a GridView --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
