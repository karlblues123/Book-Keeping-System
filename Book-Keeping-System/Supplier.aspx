<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Supplier.aspx.cs" Inherits="Book_Keeping_System.Supplier" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script type="text/javascript">
       
         function pageLoad() {
             //Search function
             $(function searchInput() {
                 $('[id*=search-bar]').off().on("keyup", function () {
                     var value = $(this).val().toLowerCase();
                     $('[id*=gvSupplierList] tr').filter(function () {
                         $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                     });
                 });
             });
         }
        
         function setSelectedSupplier(supplier) {
             $('#<%=hiddenSelectedSupplier.ClientID%>').val(supplier);
            bootstrap.Modal.getOrCreateInstance($('#new-supplier-modal')).toggle();
            __doPostBack('<%=upSupplier.ClientID%>', '');
         }


        ////On UpdatePanel Refresh
        //var prm = Sys.WebForms.PageRequestManager.getInstance();
        //if (prm != null) {
        //    prm.add_endRequest(function (sender, e) {
        //        if (sender._postBackSettings.panelsToUpdate != null) {


        //            //Search function
        //            $(function searchInput() {
        //                $('[id*=search-bar]').on("keyup", function () {
        //                    var value = $(this).val().toLowerCase();
        //                    $('[id*=gvSupplierList] tr').filter(function () {
        //                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        //                    });
        //                });
        //            });

        //        }
        //    });
        //};

    </script>
    <div class="container-fluid">
        <div class="m-2 h6">Supplier Data</div>
        <div class="card" style="max-height:85vh;">
            <div class="card-header">
                <div class="row d-flex align-items-center">
                    <div class="col-4">
                        <div class="input-group">
                            <%-- Search Textbox --%>
                            <input type="text" id="search-bar" placeholder="Search" class="form-control" 
                                role="search" autocomplete="off" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body overflow-y-auto">
                <%-- Supplier List GridView --%>                              
                <asp:GridView runat="server" ID="gvSupplierList" CssClass="table table-hover" AutoGenerateColumns="false" 
                    ShowHeader="true" GridLines="Horizontal" DataKeyNames="SupplierID">
                    <Columns>
                        <asp:BoundField DataField="Supplier_Name" HeaderText="Name" ItemStyle-Width="20%"/>
                        <asp:BoundField DataField="Supplier_Address" HeaderText="Address" ItemStyle-Width="50%" />
                        <asp:BoundField DataField="TIN" HeaderText="TIN" ItemStyle-Width="20%" />
                        <asp:TemplateField ItemStyle-Width="10%">
                            <ItemTemplate>
                                <button type="button" class="btn btn-primary" onclick="setSelectedSupplier(<%#Eval("SupplierID").ToString()%>);return false;">
                                    <span class="fa fa-search"></span>
                                </button>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <%-- Add button --%>
            <button type="button" class="btn btn-success position-fixed end-0 bottom-0 mb-5 me-5" onclick='setSelectedSupplier(<%=string.Empty%>);'>
                New Supplier <span class="fa fa-plus-circle"></span>
            </button>
        </div>
        <%-- Supplier Modal --%>
        <div class="modal fade" tabindex="-1" id="new-supplier-modal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6>Supplier Form</h6>
                        <button type="button" class="btn btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <asp:UpdatePanel runat="server" ID="upSupplier" ChildrenAsTriggers="false" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:HiddenField runat="server" ID="hiddenSelectedSupplier" OnValueChanged="hiddenSelectedSupplier_ValueChanged" />
                                <div class="row my-2">
                                    <div class="col-8">
                                        <div class="form-floating">
                                            <%-- Supplier Name --%>
                                            <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                                AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtSupplierName.ClientID%>">Name</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="input-group">
                                            <div class="form-floating">
                                                <%-- Supplier TIN --%>
                                                <asp:TextBox runat="server" ID="txtSupplierTIN" CssClass="form-control" 
                                                    AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtSupplierTIN.ClientID%>">TIN</label>
                                            </div>
                                            <div class="input-group-text d-flex align-items-center">
                                                VAT
                                                <asp:CheckBox runat="server" ID="cbVAT"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row my-2">
                                    <div class="col">
                                        <div class="form-floating">
                                            <%-- Supplier Address --%>
                                            <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                                AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtSupplierAddress.ClientID%>">Address</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row my-2">
                                    <div class="col-6">
                                        <div class="form-floating">
                                            <%-- Contact Number --%>
                                            <asp:TextBox runat="server" ID="txtContactNumber" CssClass="form-control" 
                                                AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtContactNumber.ClientID%>">Contact Number</label>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-floating">
                                            <%-- Contact Person --%>
                                            <asp:TextBox runat="server" ID="txtContactPerson" CssClass="form-control" 
                                                AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtContactPerson.ClientID%>">Contact Person</label>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="hiddenSelectedSupplier" EventName="ValueChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div class="modal-footer">
                        <%-- Save Button --%>
                        <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-success" OnClick="lnkSave_Click">
                            Save
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
