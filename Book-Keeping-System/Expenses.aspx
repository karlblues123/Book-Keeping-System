<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Expenses.aspx.cs" Inherits="Book_Keeping_System.Expenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <%-- Main Card --%>
        <div class="card m-2">
            <%-- Main Card Header --%>
            <div class="card-header">
                Expenses
            </div>
            <%-- Main Card Body --%>
            <div class="card-body">
                <div class="row">
                    <%-- Expenses Type Card --%>
                    <div class="col-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="input-group">
                                    <span class="input-group-text">Type</span>
                                    <asp:DropDownList runat="server" ID="ddExpenseType" CssClass="form-control"></asp:DropDownList>
                                    <asp:LinkButton runat="server" ID="btnTypeSelect" CssClass="btn btn-success">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Expenses List Card --%>
                    <div class="col-8">
                        <div class="card">
                            <%-- Search Bar --%>
                            <div class="card-header">
                                <div class="input-group">
                                    <asp:TextBox runat="server" ID="txtSearch" CssClass="form-control"></asp:TextBox>
                                    <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-success">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <%-- Expenses List --%>
                            <div class="card-body">
                                <asp:UpdatePanel runat="server" ID="upExpensesList">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnTypeSelect" EventName="Click" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <asp:GridView runat="server" ID="gvExpensesList" CssClass="table table-hover" 
                                            AutoGenerateColumns="false"></asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
