<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="Book_Keeping_System.Company" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
            <div class="card m-2">
                <%-- Main Header --%>
                <div class="card-header">
                    Company
                </div>
                <%-- Body --%>
                <div class="card-body">
                    <div class="card">
                        <div class="card-header">
                            <%-- Search Header --%>
                            <div class="input-group">
                                <input type="text" class="form-control" id="search-bar" />
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus-circle"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="16"></line><line x1="8" y1="12" x2="16" y2="12"></line></svg>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <%-- List --%>
                            <asp:GridView runat="server" ID="gvCompanyList" AutoGenerateColumns="false" CssClass="table">
                                <Columns>
                                    <asp:BoundField DataField="CompanyName" HeaderText="Address" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-primary">Edit</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
    </div> 
    <%-- Modal --%>
    <div class="modal" tabindex="-1" id="addModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <%-- Modal Header --%>
                <div class="modal-header">
                    <asp:Label runat="server" ID="lblModal">New Company</asp:Label>
                </div>
                <%-- Modal Body --%>
                <div class="modal-body">
                    <%-- Address --%>
                    <div class="input-group m-2">
                        <span class="input-group-text">
                            Name
                        </span>
                        <asp:TextBox runat="server" ID="txtName" CssClass="form-control" 
                            placeholder="Name" AutoCompleteType="Disabled"></asp:TextBox>
                    </div>
                    
                </div>
                <%-- Modal Footer --%>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btnClose">Close</button>
                    <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-primary">Save</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
