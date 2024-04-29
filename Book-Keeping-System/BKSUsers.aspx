<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BKSUsers.aspx.cs" Inherits="Book_Keeping_System.BKSUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="m-2 h6">System Users</div>
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-4">
                                <%-- Search --%>
                                <input type="text" id="user-search" class="form-control" autocomplete="off" placeholder="Search" />
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <%-- User List --%>
                        <asp:GridView runat="server" ID="gvUsers" CssClass="table table-responsive" DataKeyNames="Username" AutoGenerateColumns="false" 
                            OnRowEditing="gvUsers_RowEditing" OnRowCancelingEdit="gvUsers_RowCancelingEdit" OnRowUpdating="gvUsers_RowUpdating">
                            <Columns>
                                <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="true" ItemStyle-Width="40%" />
                                <asp:BoundField DataField="TypeName" HeaderText="Type" ReadOnly="true" ItemStyle-Width="20%" />
                                <asp:TemplateField HeaderText="Active" ItemStyle-Width="30%">
                                    <ItemTemplate>
                                        <%#Eval("IsActive").ToString()%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox runat="server" ID="cbActive" Checked='<%#Eval("IsActive")%>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="10%">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="btnEdit" CommandName="Edit" CssClass="btn btn-primary">
                                            <span class="fa fa-edit"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton runat="server" ID="btnUpdate" CommandName="Update" CssClass="btn btn-success">
                                            <span class="fa fa-check"></span>
                                        </asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="btnCancel" CommandName="Cancel" CssClass="btn btn-dark">
                                            <span class="fa fa-window-close"></span>
                                        </asp:LinkButton>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
