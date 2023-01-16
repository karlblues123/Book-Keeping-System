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
                            <asp:TextBox runat="server" ID="txtSearch" AutoCompleteType="Disabled" placeholder="Search"
                                CssClass="form-control"></asp:TextBox>
                            <div class="btn-group">
                                <asp:LinkButton runat="server" ID="lnkSearch" CssClass="btn btn-success">Search</asp:LinkButton>
                                <asp:LinkButton runat="server" ID="lnkAdd" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">Add</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <%-- TODO List of Suppliers in a GridView --%>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" tabindex="-1" id="addModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">New Supplier</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="input-group mb-2">
                            <span class="input-group-text">
                                Supplier Name
                            </span>
                            <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                AutoCompleteType="Disabled" placeholder="Name"></asp:TextBox>
                        </div>
                        <div class="input-group mb-2">
                            <span class="input-group-text">
                                Supplier Address
                            </span>
                            <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                AutoCompleteType="Disabled" placeholder="Address"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btnClose">Close</button>
                        <button type="button" class="btn btn-primary" id="btnSave">Save</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
