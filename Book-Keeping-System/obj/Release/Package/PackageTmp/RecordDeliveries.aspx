<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RecordDeliveries.aspx.cs" Inherits="Book_Keeping_System.RecordDeliveries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <b class="fa fa-truck"></b> Deliveries
            </div>
            <div class="card-body">
                <%-- Form Card --%>
                <div class="card">
                    <%-- Form Card Header --%>
                    <div class="card-header">
                        <div class="row">
                            <%-- Tabs --%>
                            <div class="col-8">
                                <ul class="nav nav-pills" id="form-pills" role="tablist">
                                    <li class="nav-item">
                                        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-out" 
                                         type="button" role="tab" aria-controls="tab-out" aria-selected="false">Out</button>
                                    </li>
                                    <li class="nav-item">
                                        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-in" 
                                          type="button" role="tab" aria-controls="tab-in" aria-selected="false">In</button>
                                    </li>
                                </ul>
                            </div>
                            <%-- Date Textbox --%>
                            <div class="col-4">
                                <asp:UpdatePanel runat="server" ID="upDate" ChildrenAsTriggers="false" UpdateMode="Conditional">
                                    <Triggers></Triggers>
                                    <ContentTemplate>
                                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <%-- Form Card Body --%>
                    <div class="card-body tab-content">
                        <div class="tab-pane fade" id="tab-out" role="tabpanel">
                            <asp:UpdatePanel runat="server" ID="upOut" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                <Triggers></Triggers>
                                <ContentTemplate>
                                    <div class="row mt-2">
                                        <div class="col-6">
                                            <%-- Branch Dropdown --%>
                                            <div class="form-floating">
                                                <asp:DropDownList runat="server" ID="ddBranchList" CssClass="form-control"></asp:DropDownList>
                                                <label for="<%=ddBranchList.ClientID%>">Branch</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row m-2"> 
                                        <div class="col-6">
                                            <%-- Branch Company Label --%>
                                            Company: <asp:Label runat="server" ID="lblBranchCompany"></asp:Label>
                                        </div>
                                        <div class="col-6">
                                            <%-- Branch Contact Number Label --%>
                                            Contanct Number: <asp:Label runat="server" ID="lblBranchNumber"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row m-2">
                                        <div class="col-6">
                                            <%-- Branch Contact Number --%>
                                            Stock: <asp:Label runat="server" ID="lblBranchStock"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row m-2">
                                        <div class="col-4">
                                            <%-- Fresh Stock Textbox --%>
                                            <div class="input-group">
                                                <span class="input-group-text">Fresh</span>
                                                <asp:TextBox runat="server" ID="txtOutFreshStock" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <%-- Frozen Stock Textbox --%>
                                            <div class="input-group">
                                                <span class="input-group-text">Frozen</span>
                                                <asp:TextBox runat="server" ID="txtOutFrozenStock" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row m-2">
                                        <div class="col-2">
                                            <%-- Issue Delivery Button --%>
                                            <asp:LinkButton runat="server" ID="lnkIssueDelivery" 
                                                CssClass="btn btn-success">Record</asp:LinkButton>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div class="tab-pane fade" id="tab-in" role="tabpanel">
                            <asp:UpdatePanel runat="server" ID="upIn" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                <Triggers></Triggers>
                                <ContentTemplate>
                                    <div class="row m-2">
                                        <%-- Supplier --%>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:DropDownList runat="server" ID="ddSupplier" CssClass="form-control"></asp:DropDownList>
                                                <label for="<%=ddSupplier.ClientID%>">Supplier</label>
                                            </div>
                                        </div>
                                        <%-- TIN --%>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtSupplierTIN" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=txtSupplierTIN.ClientID%>">TIN</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row m-2">
                                        <%-- Company --%>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:DropDownList runat="server" ID="txtCompany" CssClass="form-control"></asp:DropDownList>
                                                <label for="<%=txtCompany.ClientID%>">Company</label>
                                            </div>
                                        </div>
                                        <%-- PO Number --%>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtPO" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=txtPO.ClientID%>">PO Number</label>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Fresh --%>
                                    <div class="row m-2">
                                        <div class="col-6">
                                            <%-- Stock --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtInFreshStock" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                <label for="<%=txtInFreshStock.ClientID %>">Fresh</label>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <%-- Price --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtInFreshPrice" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                <label for="<%=txtInFreshPrice.ClientID %>">Price</label>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Frozen --%>
                                    <div class="row m-2">
                                        <div class="col-6">
                                            <%-- Stock --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtInFrozenStock" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                <label for="<%=txtInFrozenStock.ClientID %>">Frozen</span>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <%-- Price --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtInFrozenPrice" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                <label for="<%=txtInFrozenPrice.ClientID %>">Price</label>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Amount & Check Number --%>
                                    <div class="row m-2">
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtAmount" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=txtAmount.ClientID %>">Amount</label>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtCheckNumber" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=txtCheckNumber.ClientID %>">Check Number</>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Record Button --%>
                                    <div class="row m-2">
                                        <div class="col-1">
                                            <asp:LinkButton runat="server" ID="lnkRecord" CssClass="btn btn-success">Record</asp:LinkButton>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
