<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Supplier.aspx.cs" Inherits="Book_Keeping_System.Supplier" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script type="text/javascript">
       
        //Search function
        $(function searchInput() {
            $('[id*=search-bar]').on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvSupplierList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });


        //On UpdatePanel Refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {


                    //Search function
                    $(function searchInput() {
                        $('[id*=search-bar]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            $('[id*=gvSupplierList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });

                }
            });
        };

    </script>
    <div class="container-fluid" style="padding-left:0;padding-right:0;">
        <asp:UpdatePanel runat="server" ID="upMain">
            <ContentTemplate>
                <asp:Panel runat="server" ID="pList" CssClass="card" style="border:none;">
                    <div class="card-header bg-info bg-opacity-25" style="height:60px;">
                        <div class="row d-flex align-items-center">
                            <div class="col-8">
                                <b class="fa fa-handshake-o"></b><b class="m-2">Suppliers Information</b>
                            </div>
                            <div class="col-4">
                                <div class="input-group">
                                    <%-- Search Textbox --%>
                                    <input type="text" id="search-bar" placeholder="Search" 
                                        class="form-control form-control-sm" role="search" />
                                    <%-- Add button --%>
                                    <asp:LinkButton runat="server" ID="lnkNewSupplier" CssClass="btn btn-sm btn-outline-success" OnClick="lnkNewSupplier_Click">
                                        <b class="fa fa-plus-circle"></b> New
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body ms-5 me-5">
                        <%-- Supplier List GridView --%>
                        <asp:Panel runat="server" ID="panelSupplierScroll" ScrollBars="Vertical" Height="500px">                                  
                            <asp:GridView runat="server" ID="gvSupplierList" CssClass="table table-hover small" AutoGenerateColumns="false" 
                                ShowHeader="true" GridLines="Horizontal" OnRowDataBound="gvSupplierList_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="SupplierID"/>
                                    <asp:BoundField DataField="Supplier_Name" HeaderText="Name" />
                                    <asp:BoundField DataField="Supplier_Address" HeaderText="Address" />
                                    <asp:BoundField DataField="TIN" HeaderText="TIN" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkEdit" 
                                                CssClass="btn btn-sm btn-outline-primary" OnClick="lnkEdit_Click">
                                                <b class="fa fa-pencil"></b> Edit
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:Panel> 
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="pForm" Visible="false" CssClass="card" style="border:none;">
                    <div class="card-header bg-info bg-opacity-25 d-flex align-items-center" style="height:60px;">
                        <b class="fa fa-edit"></b><b class="ms-2">Supplier Form</b>
                    </div>
                    <div class="card-body ms-5 me-5">
                        <%-- Supplier Name --%>
                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-floating">
                                    <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                        AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=txtSupplierName.ClientID%>">Name</label>
                                </div>
                            </div>
                        </div>
                        <%-- Supplier Address --%>
                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-floating">
                                    <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                        AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=txtSupplierAddress.ClientID%>">Address</label>
                                </div>
                            </div>
                        </div>
                        <%-- Supplier TIN --%>
                        <div class="row mt-2">
                            <div class="col-8">
                                <div class="input-group">
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtSupplierTIN" CssClass="form-control" 
                                            AutoCompleteType="Disabled"></asp:TextBox>
                                        <label for="<%=txtSupplierTIN.ClientID%>">TIN</label>
                                    </div>
                                    <div class="input-group-text d-flex align-items-center">
                                        VAT
                                        <asp:CheckBox runat="server" ID="cbVAT" CssClass="form-check"/>
                                    </div>
                                </div>
                            </div>
                            <%-- Supplier Type --%>
                            <div class="col-4">
                                <div class="form-floating">
                                    <asp:DropDownList runat="server" ID="ddSupplierType" CssClass="form-select"></asp:DropDownList>
                                    <label for="<%=ddSupplierType.ClientID%>">Type</label>
                                </div>
                            </div>
                        </div>
                        <%-- Save and Back Buttons --%>
                        <div class="row mt-2">
                            <div class="col-1">
                                <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn btn-outline-warning" 
                                    OnClick="lnkBack_Click">
                                    Back
                                </asp:LinkButton>
                            </div>
                            <div class="col-1">
                                <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-outline-primary" 
                                    OnClick="lnkSave_Click">
                                    Save
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
