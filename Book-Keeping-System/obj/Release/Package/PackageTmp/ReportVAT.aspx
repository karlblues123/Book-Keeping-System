<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ReportVAT.aspx.cs" Inherits="Book_Keeping_System.VATReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <%-- Main Card --%>
        <div class="card m-2">
            <%-- Main Card Body --%>
            <div class="card-body">
                <div class="row">
                    <div class="col-4">
                        <%-- Selection Card --%>
                        <div class="card">
                            <%-- Selection Card Body --%>
                            <div class="card-body">
                                <%-- Dropdown --%>
                                <div class="input-group">
                                    <span class="input-group-text">Company</span>
                                    <asp:DropDownList runat="server" ID="ddDropdown" CssClass="form-control"></asp:DropDownList>
                                </div>      
                            </div>
                            <%-- Selection Card Footer --%>
                            <div class="card-footer">
                                <%-- Select Button --%>
                                <asp:LinkButton runat="server" ID="lnkSelect" CssClass="btn btn-success">Select</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <%-- Output Card --%>
                        <div class="card">
                            <%-- Output Card Body --%>
                            <div class="card-body">
                                WIP
                                <%-- Crystal Report goes here --%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
