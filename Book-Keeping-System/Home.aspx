<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Book_Keeping_System.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row m-2">
            <div class="col-4">
                <div class="card"></div>
            </div>
            <div class="col-4">
                <div class="card"></div>
            </div>
            <div class="col-4">
                <%-- Missing Sales --%>
                <asp:Panel runat="server" ID="pMissingSales" Visible="false">
                    <div class="card my-2" style="max-height:40vh;">
                        <div class="card-header bg-danger">
                            <h6>Missing Sales</h6>
                        </div>
                        <div class="card-body overflow-y-auto">
                            <%-- Branch List --%>
                            <asp:GridView runat="server" ID="gvNoSalesBranch" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                DataKeyNames="BranchCode" ShowHeader="false">
                                <Columns>
                                    <asp:BoundField DataField="Branch_Name" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </asp:Panel>
                <%-- Expiring Contracts --%>
                <asp:Panel runat="server" ID="pExpiringContracts">
                    <div class="card my-2" style="max-height:40vh;">
                        <div class="card-header bg-danger">
                            <h6>Expiring Contracts</h6>
                        </div>
                        <div class="card-body overflow-y-auto">
                            <asp:GridView runat="server" ID="gvExpiringContractBranch" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                DataKeyNames="BranchCode" ShowHeader="false">
                                <Columns>
                                    <asp:BoundField DataField="Branch_Name" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
