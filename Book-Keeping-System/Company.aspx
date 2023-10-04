<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="Book_Keeping_System.Company" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid" style="padding-left:0;padding-right:0;">
        <asp:UpdatePanel runat="server" ID="upMain">
            <ContentTemplate>
                <asp:Panel runat="server" ID="pList" CssClass="card" style="border:0;">
                    <%-- Main Header --%>
                    <div class="card-header bg-success-subtle" style="height:57px;">
                        <div class="row d-flex align-items-center">
                            <div class="col-8">
                                <b class="fa fa-briefcase"></b><b> Company</b>
                            </div>
                            <div class="col-4">
                                <div class="input-group">
                                    <input type="text" class="form-control form-control-sm" id="search-bar" 
                                        role="search" placeholder="Search"/>
                                    <button class="btn btn-outline-primary btn-sm">
                                        <b class="fa fa-plus-circle"></b>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Body --%>
                    <div class="card-body ms-5 me-5" style="height:550px;overflow-y:scroll">
                        <%-- GridView List --%>
                        <asp:GridView runat="server" ID="gvCompanyList" AutoGenerateColumns="false" CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="Company_Name" HeaderText="Name" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkView" CssClass="btn btn-outline-primary" OnClick="lnkView_Click"><b class="fa fa-search"></b> View</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div> 
                </asp:Panel>
                <asp:Panel runat="server" ID="pDetails" CssClass="card" Visible="false" style="border:0;">
                    <div class="card-header bg-success-subtle" style="height:57px;">
                        <%-- Tabs --%>
                        <ul class="nav nav-pills" id="form-pills" role="tablist">
                            <%-- Basic Tab --%>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-basic"
                                    type="button" role="tab" aria-controls="tab-basic" aria-selected="true">
                                    Basic
                                </button>
                            </li>
                            <%-- Expense Tab --%>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-expense"
                                    type="button" role="tab" aria-controls="tab-expense" aria-selected="false">
                                    Expense
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="card-body ms-5 me-5">
                        <div class="row mt-2 tab-content">
                            <%-- Basic Pane--%>
                            <div class="tab-pane fade show active" id="tab-basic">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtCompanyName" CssClass="form-control"></asp:TextBox>
                                            <label for="<%=txtCompanyName.ClientID%>">Name</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- Company Expenses Pane--%>
                            <div class="tab-pane fade" id="tab-expense">
                                <div class="row mt-2">
                                    <div class="col">
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="txtExpenseSearch" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <asp:GridView runat="server" ID="gvCompanyExpenses" CssClass="table table-responsive" AutoGenerateColumns="false">
                                            <Columns>
                                                <%-- Date of Expense --%>
                                                <asp:BoundField DataField="SupplierName" />
                                                <%-- Expense Total --%>
                                                <%-- TODO Insert Expense List --%>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-1">
                                <%-- Back Button --%>
                                <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn btn-outline-warning" OnClick="lnkBack_Click">Back</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div> 
</asp:Content>
