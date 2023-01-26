<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Branch.aspx.cs" Inherits="Book_Keeping_System.Branch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="card m-2">
            <div class="card-header">
                <div class="input-group">
                    <%-- Header --%>
                    <asp:TextBox runat="server" ID="txtSearch" placeholder="Search" 
                    AutoCompleteType="Disabled" CssClass="form-control"></asp:TextBox>
                    <div class="btn-group">
                        <asp:LinkButton runat="server" ID="lnkSearch" CssClass="btn btn-success">Search</asp:LinkButton>
                        <asp:LinkButton runat="server" ID="lnkAdd" CssClass="btn btn-primary d-flex justify-content-center" 
                                    data-bs-toggle="modal" data-bs-target="#addModal"><object type="image/svg+xml" data="css/feather/plus-circle.svg"></object></asp:LinkButton>
                    </div>
                </div>
            </div>
            <%-- Body --%>
            <div class="card-body">
                <asp:GridView runat="server" ID="gvBranchList" AutoGenerateColumns="false" CssClass="table">
                    <Columns>
                        <asp:BoundField DataField="BranchAddress" HeaderText="Address" />
                        <asp:BoundField DataField="BranchSupervisor" HeaderText="Supervisor" />
                        <asp:BoundField DataField="BranchStatus" HeaderText="Status" />
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
    <%-- Modal --%>
    <div class="modal" tabindex="-1" id="addModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <%-- Modal Header --%>
                <div class="modal-header">
                    <asp:Label runat="server" ID="lblModal">New Branch</asp:Label>
                </div>
                <%-- Modal Body --%>
                <div class="modal-body">
                    <%-- Address --%>
                    <div class="input-group m-2">
                        <span class="input-group-text">
                            Address
                        </span>
                        <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control" 
                            placeholder="Address" AutoCompleteType="Disabled"></asp:TextBox>
                    </div>
                    <%-- Supervisor --%>
                    <div class="input-group m-2">
                        <span class="input-group-text">
                            Supervisor
                        </span>
                        <asp:TextBox runat="server" ID="txtSupervisor" CssClass="form-control" placeholder="Supervisor"
                            AutoCompleteType="Disabled"></asp:TextBox>
                    </div>
                    <%-- Status --%>
                    <div class="input-group m-2">
                        <span class="input-group-text">
                            Status
                        </span>
                        <div class="form-check form-control">
                            <asp:CheckBox runat="server" ID="cbStatus" />
                            <label class="form-check-label" for="cbStatus">Active</label>
                        </div>
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
