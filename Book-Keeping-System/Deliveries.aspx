<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Deliveries.aspx.cs" Inherits="Book_Keeping_System.Deliveries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-8">
                <div class="card m-2">
                    <%-- Header --%>
                    <div class="card-header" style="background-color:powderblue">
                        Deliveries
                    </div>
                    <%-- Body --%>
                    <div class="card-body">
                        <div class="card">
                            <div class="card-header">
                                
                            </div>
                            <div class="card-body">
                                <%-- Day List --%>
                                <asp:GridView runat="server" ID="gvBranchList" AutoGenerateColumns="false" CssClass="table">
                                    <Columns>
                                        <asp:BoundField DataField="Day" HeaderText="Day" DataFormatString="{0:dd}"></asp:BoundField>
                                        <asp:BoundField DataField="DailyTotal" HeaderText="Total"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-primary float-end d-flex justify-content-center" 
                                                    OnClick="lnkEdit_Click" data-bs-toggle="modal" data-bs-target="#formModal">
                                                    <object type="image/svg+xml" data="css/feather/edit.svg"></object>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-3 m-2">
                <div class="card">
                    <div class="card-header">
                        Branch
                    </div>
                    <div class="card-body">
                        <%-- Branch List --%>
                        <div class="row m-2">
                            <asp:DropDownList runat="server" ID="ddBranchList" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <%-- Month List --%>
                        <div class="row m-2">
                            <asp:DropDownList runat="server" ID="ddMonthList" CssClass="form-control" 
                                DataTextField="MonthTextField" DataValueField="MonthValueField"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="card-footer">
                        <asp:LinkButton runat="server" ID="txtSelect" CssClass="btn btn-primary" OnClick="txtSelect_Click">Select</asp:LinkButton>
                    </div>
                </div>   
            </div>
        </div>
        <div class="modal fade" tabindex="-1" id="formModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <%-- Daily Sales --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Daily Sales</span>
                            <asp:TextBox runat="server" ID="txtDailySales" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Sawsawan --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Sawsawan</span>
                            <asp:TextBox runat="server" ID="txtSawsawan" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Kalamansi --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Kalamansi</span>
                            <asp:TextBox runat="server" ID="txtKalamansi" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Sili --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Sili</span>
                            <asp:TextBox runat="server" ID="txtSili" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Fare --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Fare</span>
                            <asp:TextBox runat="server" ID="txtFare" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Tiny P.labo --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Tiny P.labo</span>
                            <asp:TextBox runat="server" ID="txtPLabo" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Brown Supot --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Brown Supot</span>
                            <asp:TextBox runat="server" ID="txtBrownSupot" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Tanglad --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Tanglad</span>
                            <asp:TextBox runat="server" ID="txtTanglad" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Sabon & Steel Wool --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Sabon & SteelWool</span>
                            <asp:TextBox runat="server" ID="txtSabonSteelWool" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Green Bag --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Green Bag</span>
                            <asp:TextBox runat="server" ID="txtGreenBag" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Walis & Mop --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Walis & Mop</span>
                            <asp:TextBox runat="server" ID="txtWalisMop" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Rags & Foam --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Rags & Foam</span>
                            <asp:TextBox runat="server" ID="txtRagsFoam" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Kitchen Utensils --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Kitchen Utensils</span>
                            <asp:TextBox runat="server" ID="txtKitchenUtensils" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Other --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Other</span>
                            <asp:TextBox runat="server" ID="txtOther" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Uling --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Uling</span>
                            <asp:TextBox runat="server" ID="txtUling" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                        <%-- Foil --%>
                        <div class="mb-2 input-group">
                            <span class="input-group-text">Foil</span>
                            <asp:TextBox runat="server" ID="txtFoil" CssClass="form-control" 
                             AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
