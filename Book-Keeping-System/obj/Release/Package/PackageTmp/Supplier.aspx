<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Supplier.aspx.cs" Inherits="Book_Keeping_System.Supplier" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script type="text/javascript">
       
        //Search function
        $(function searchInput() {
            $('[id*=txtSearch]').on("keyup", function () {
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
                        $('[id*=txtSearch]').on("keyup", function () {
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


    <div class="container-fluid">
        <div class="card m-2">
            <div class="card-header bg-info bg-opacity-25">
              <b class="fa fa-handshake-o"></b>  <b>Suppliers Information</b>
            </div>
            <div class="card-body">
                <asp:UpdatePanel runat="server" ID="upMain">
                    <%--<Triggers>
                        <asp:AsyncPostBackTrigger ControlID="lnkNewSupplier" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="lnkBack" EventName="Click" />
                    </Triggers>--%>
                    <ContentTemplate>
                        <asp:Panel runat="server" ID="pList">
                            <div class="card">
                                <div class="card-header">
                                    <div class="input-group">
                                        <%-- Search Textbox --%>
                                        <asp:TextBox  runat="server" id="txtSearch" placeholder="Search Supplier" class="form-control" />
                                        <%-- Add button --%>
                                        <asp:LinkButton runat="server" ID="lnkNewSupplier" CssClass="btn btn-outline-success" OnClick="lnkNewSupplier_Click">
                                            <b class="fa fa-plus-circle"></b> New
                                        </asp:LinkButton>
                                    </div>
                                </div>
                                <div class="card-body">
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
                                                        Edit
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                        </asp:Panel> 
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
                            </div>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
