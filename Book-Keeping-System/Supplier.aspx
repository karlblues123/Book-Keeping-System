<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Supplier.aspx.cs" Inherits="Book_Keeping_System.Supplier" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="card m-2">
            <div class="card-header">
                Suppliers
            </div>
            <div class="card-body">
                <asp:UpdatePanel runat="server" ID="upMain" UpdateMode="Conditional" ChildrenAsTriggers="false">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="lnkNewSupplier" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="lnkBack" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Panel runat="server" ID="pList">
                            <div class="card">
                                <div class="card-header">
                                    <div class="input-group">
                                        <%-- Search Textbox --%>
                                        <input type="text" placeholder="Search" class="form-control" />
                                        <%-- Add button --%>
                                        <asp:LinkButton runat="server" ID="lnkNewSupplier" CssClass="btn btn-primary" OnClick="lnkNewSupplier_Click">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus-circle"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="16"></line><line x1="8" y1="12" x2="16" y2="12"></line></svg>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <%-- Supplier List GridView --%>
                                    <asp:GridView runat="server" ID="gvSupplierList" CssClass="table table-hover" AutoGenerateColumns="false" 
                                        ShowHeader="true" GridLines="Horizontal" OnRowDataBound="gvSupplierList_RowDataBound">
                                        <Columns>
                                            <asp:BoundField DataField="SupplierName" HeaderText="Name" />
                                            <asp:BoundField DataField="TIN" HeaderText="TIN" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="lnkEdit" 
                                                        CssClass="btn btn-sm btn-outline-primary" OnClick="lnkEdit_Click">
                                                        Edit
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="pForm" Visible="false">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <h5>New Supplier</h5>
                                    </div>
                                    <%-- Supplier Name --%>
                                    <div class="input-group m-2">
                                        <span class="input-group-text">
                                            <object type="image/svg+xml" data="css/feather/edit-2.svg"></object>
                                        </span>
                                        <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                            AutoCompleteType="Disabled" placeholder="Name"></asp:TextBox>
                                    </div>
                                    <%-- Supplier Address --%>
                                    <div class="input-group m-2">
                                        <span class="input-group-text">
                                            <object type="image/svg+xml" data="css/feather/home.svg"></object>  
                                        </span>
                                        <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                            AutoCompleteType="Disabled" placeholder="Address"></asp:TextBox>
                                    </div>
                                    <%-- Supplier TIN --%>
                                    <div class="input-group m-2">
                                        <span class="input-group-text">TIN</span>
                                        <asp:TextBox runat="server" ID="txtSupplierTIN" CssClass="form-control" 
                                            AutoCompleteType="Disabled" placeholder="TIN"></asp:TextBox>
                                        <div class="input-group-text d-flex align-items-center">
                                            VAT
                                            <asp:CheckBox runat="server" ID="cbVAT" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-1">
                                            <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn btn-warning" 
                                                OnClick="lnkBack_Click">
                                                Back
                                            </asp:LinkButton>
                                        </div>
                                        <div class="col-1">
                                            <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-primary" 
                                                OnClick="lnkSave_Click">
                                                Save
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
