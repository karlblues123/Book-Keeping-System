<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Supplier.aspx.cs" Inherits="Book_Keeping_System.Supplier" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="card mt-2">
            <div class="card-header" style="background-color:powderblue">
                Suppliers
            </div>
            <div class="card-body">
                <div class="card">
                    <div class="card-header">
                        <div class="input-group">
                            <%-- Search Textbox --%>
                            <asp:TextBox runat="server" ID="txtSearch" AutoCompleteType="Disabled" placeholder="Search"
                                CssClass="form-control"></asp:TextBox>
                            <div class="btn-group">
                                <%-- Search button --%>
                                <asp:LinkButton runat="server" ID="lnkSearch" CssClass="btn btn-success">Search</asp:LinkButton>
                                <%-- Add button --%>
                                <asp:LinkButton runat="server" ID="lnkAdd" CssClass="btn btn-primary d-flex justify-content-center" 
                                    data-bs-toggle="modal" data-bs-target="#addModal"><object type="image/svg+xml" data="css/feather/plus-circle.svg"></object></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <%-- Supplier List GridView --%>
                        <asp:GridView runat="server" ID="gvSupplierList" CssClass="table table-hover" AutoGenerateColumns="false" 
                            ShowHeader="true" GridLines="Horizontal">
                            <Columns>
                                <asp:BoundField DataField="SupplierName" HeaderText="Name" />
                                <asp:BoundField DataField="Address" HeaderText="Address" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkEdit" 
                                            CssClass="btn btn-sm btn-outline-primary">
                                            Edit
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        <%-- New Supplier Form Modal --%>
        <div class="modal" tabindex="-1" id="addModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <%-- Modal Header --%>
                    <div class="modal-header">
                        <h5 class="modal-title d-flex justify-content-center">New Supplier <object type="image/svg+xml" data="css/feather/edit.svg"></object></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <%-- Modal Body --%>
                    <div class="modal-body">
                        <%-- Supplier Name --%>
                        <div class="input-group mb-2">
                            <span class="input-group-text">
                                <object type="image/svg+xml" data="css/feather/edit-2.svg"></object>
                            </span>
                            <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                AutoCompleteType="Disabled" placeholder="Name"></asp:TextBox>
                        </div>
                        <%-- Supplier Address --%>
                        <div class="input-group mb-2">
                            <span class="input-group-text">
                                <object type="image/svg+xml" data="css/feather/home.svg"></object>  
                            </span>
                            <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                AutoCompleteType="Disabled" placeholder="Address"></asp:TextBox>
                        </div>
                    </div>
                    <%-- Modal Footer --%>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btnClose">Close</button>
                        <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-primary" OnClick="lnkSave_Click">Save</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
