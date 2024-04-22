<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Book_Keeping_System.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row my-2">
            <div class="col-6 offset-3">
                <div class="card">
                    <div class="card-header">
                        <h6>Change Password</h6>
                    </div>
                    <div class="card-body">
                        <div class="row m-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- Current Password --%>
                                    <asp:TextBox runat="server" ID="txtCurrentPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <label for="<%=txtCurrentPassword.ClientID%>">Current Password</label>
                                </div>
                                
                            </div>
                        </div>
                        <div class="row m-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- Confirm Current Password --%>
                                    <asp:TextBox runat="server" ID="txtConfirmCurrent" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <label for="<%=txtConfirmCurrent.ClientID%>">Confirm Current Password</label>
                                </div>
                                
                            </div>
                        </div>
                        <div class="row m-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- New Password --%>
                                    <asp:TextBox runat="server" ID="txtNewPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <label for="<%=txtNewPassword.ClientID%>">New Password</label>
                                </div>
                                
                            </div>
                        </div>
                        <div class="row m-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- Confirm New Password --%>
                                    <asp:TextBox runat="server" ID="txtConfirmNew" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <label for="<%=txtConfirmNew.ClientID%>">Confirm New Password</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <%-- Submit --%>
                        <asp:LinkButton runat="server" ID="btnSubmit" CssClass="btn btn-success float-end" 
                            OnClick="btnSubmit_Click">Submit</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
