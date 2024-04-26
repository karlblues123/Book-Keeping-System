<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CompanyExpenses.aspx.cs" Inherits="Book_Keeping_System.CompanyExpenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">

        function CalculateTotal() {
            var vatable = 0, nonvat = 0, vat = 0;
            if (document.getElementById('<%=txtVATAmount.ClientID%>').value != null) {
                vatable = + Number.parseFloat(document.getElementById('<%=txtVATAmount.ClientID%>').value).toFixed(2);
            }
                
            if (document.getElementById('<%=txtNonVATAmount.ClientID%>').value != null) {
                nonvat = + Number.parseFloat(document.getElementById('<%=txtNonVATAmount.ClientID%>').value).toFixed(2);
            }
                
            if (document.getElementById('<%=txtVAT.ClientID%>').value != null) {
                vat = + Number.parseFloat(document.getElementById('<%=txtVAT.ClientID%>').value).toFixed(2);
            }
            document.getElementById("<%=txtTotal.ClientID%>").value = vatable + nonvat + vat;
        }

        function closeExpensesModal() {
            bootstrap.Modal.getOrCreateInstance($('#expense-modal')).toggle();
        }

        <%--function CalculateUtilityVAT() {
            var total = 0, vatable = 0;
            if (document.getElementById('<%=txtTotal.ClientID%>').value != null) {
                total = +Number.parseFloat(document.getElementById('<%=txtTotal.ClientID%>').value).toFixed(2);
                vatable = (total / 1.12).toFixed(2);
            }
            document.getElementById('<%=txtVATAmount.ClientID%>').value = vatable;
            document.getElementById('<%=txtVAT.ClientID%>').value = (total - vatable).toFixed(2);
        }--%>


        //Search function
        function pageLoad() {
            $('[id*=supplier-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvSupplierList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            $('[id*=company-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvCompany] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            $('[id*=expense-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvExpenses] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

        }
            
    </script>
    <div class="container-fluid">
        <div class="m-2 h6">Company Expenses</div>
        <asp:UpdatePanel runat="server" ID="upForm" ChildrenAsTriggers="false" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row">
                    <div class="col-4">
                        <div class="card" style="max-height:85vh;">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col">
                                        <%-- Search Textbox --%>
                                        <input type="text" id="company-search" placeholder="Search Company" 
                                        class="form-control" role="search" autocomplete="off" />
                                    </div>
                                </div>
                            </div>
                            <div class="card-body overflow-y-auto">
                                <%-- Company GridView --%>
                                <asp:GridView runat="server" ID="gvCompany" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                    DataKeyNames="CompanyID">
                                    <Columns>
                                        <asp:BoundField DataField="Company_Name" HeaderText="Company" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lnkSelectCompany" CssClass="btn btn-primary" 
                                                    OnClick="lnkSelectCompany_Click">
                                                    <span class="fa fa-edit"></span>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <%-- Selected Expense Hiddenfield --%>
                        <asp:HiddenField runat="server" ID="hiddenSelectedExpense" />
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-4">
                                        <div class="input-group">
                                            <%-- Selected Company Controls --%>
                                            <asp:TextBox runat="server" ID="txtSelectedCompany" CssClass="form-control" ReadOnly="true" 
                                                Text="No Company Selected"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hiddenSelectedCompany" />
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#expense-modal">
                                                <span class="fa fa-search"></span>
                                            </button>
                                        </div>
                                        
                                    </div>
                                    <div class="col-3 offset-5">
                                        <%-- Date --%>
                                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control h-100" TextMode="Date"></asp:TextBox>
                                        <%--<ul class="nav nav-pills" id="form-pills" role="tablist">
                                            <%-- Tab Link Form
                                            <li id="nav-utility" class="nav-item" role="presentation">
                                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-form" 
                                                    type="button" role="tab" aria-controls="tab-form" aria-selected="false">
                                                    Form
                                                </button>
                                            </li>
                                            <%-- Tab Link List
                                            <li id="nav-misc" class="nav-item" role="presentation">
                                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-list" 
                                                    type="button" role="tab" aria-controls="tab-list" aria-selected="false">
                                                    List
                                                </button>
                                            </li>
                                            <%-- Tab Link New Supplier
                                            <li id="nav-new" class="nav-item" role="presentation">
                                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-new-supplier" 
                                                    type="button" role="tab" aria-controls="tab-new-supplier" aria-selected="false">
                                                    New Supplier
                                                </button>
                                            </li>
                                        </ul>--%>
                                    </div>
                                </div>  
                            </div>
                            <%-- Main Card Body --%>
                            <div class="card-body">   
                                <div class="row m-2">
                                    <%-- Supplier --%>
                                    <div class="col-8">
                                        <asp:HiddenField runat="server" ID="hiddenSelectedSupplier" />
                                        <div class="input-group">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtSupplier" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                <label for="<%=txtSupplier.ClientID%>">Supplier</label>
                                            </div>
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#supplier-modal">
                                                <span class="fa fa-search"></span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- TIN --%>
                                            <asp:TextBox runat="server" ID="txtTIN" CssClass="form-control" 
                                                AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtTIN.ClientID%>">TIN</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-2">
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- Invoice Number --%>
                                            <asp:TextBox runat="server" ID="txtInvoice" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtInvoice.ClientID%>">Receipt Number</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- PO Number --%>
                                            <asp:TextBox runat="server" ID="txtPO" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtPO.ClientID%>">PO Number</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- Expense Type --%>
                                            <asp:DropDownList runat="server" ID="ddType" CssClass="form-select" 
                                                AutoPostBack="true" OnSelectedIndexChanged="ddType_SelectedIndexChanged"></asp:DropDownList>
                                            <label for="<%=ddType.ClientID%>">Type</label>
                                        </div>
                                    </div>
                                </div>
                                <%-- Utility Line --%>
                                <div class="row m-2">
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtUtilityFrom" CssClass="form-control" 
                                                AutoCompleteType="Disabled" TextMode="Date" Enabled="false"></asp:TextBox>
                                            <label for="<%=txtUtilityFrom.ClientID%>">From</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtUtilityTo" CssClass="form-control" 
                                                AutoCompleteType="Disabled" TextMode="Date" Enabled="false"></asp:TextBox>
                                            <label for="<%=txtUtilityTo.ClientID%>">To</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtAccountNumber" CssClass="form-control" AutoCompleteType="Disabled" 
                                                Enabled="false"></asp:TextBox>
                                            <label for="<%=txtAccountNumber.ClientID%>">Account Number</label>
                                        </div>
                                    </div>
                                </div>
                                <%-- Amount and VAT--%>
                                <div class="row m-2">
                                    <div class="col-3">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtVATAmount" CssClass="form-control" 
                                                TextMode="Number" Text="0" onchange="CalculateTotal();" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtVATAmount.ClientID%>">VATable</label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtNonVATAmount" CssClass="form-control"
                                                TextMode="Number" Text="0" onchange="CalculateTotal();" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtNonVATAmount.ClientID%>">Non-VAT</label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtVAT" CssClass="form-control" 
                                                TextMode="Number" Text="0" onchange="CalculateTotal();" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtVAT.ClientID%>">VAT</label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtTotal" CssClass="form-control" 
                                                TextMode="Number" Text="0" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtTotal.ClientID%>">Total</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-2">
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- Amount Tendered --%>
                                            <asp:TextBox runat="server" ID="txtTendered" CssClass="form-control" TextMode="Number" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtTendered.ClientID%>">Amount Tendered</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- Cheque Number --%>
                                            <asp:TextBox runat="server" ID="txtCheque" CssClass="form-control" Enabled="false" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtCheque.ClientID%>">Cheque Number</label>
                                        </div>
                                    </div>
                                    <div class="col-2 d-flex">
                                        <%-- Cheque Combobox --%>
                                        <asp:CheckBox runat="server" ID="cbIsCheque" CssClass="align-self-center" Text="Cheque?" TextAlign="Right" 
                                            OnCheckedChanged="cbIsCheque_CheckedChanged" AutoPostBack="true" />
                                    </div>
                                </div>
                                <div class="row m-2">
                                    <div class="col-8">
                                        <div class="form-floating">
                                            <%-- Remarks --%>
                                            <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                                            <label for="<%=txtRemarks.ClientID%>">Remarks</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <%-- Submit Button --%>
                                        <asp:LinkButton runat="server" ID="lnkSubmit" CssClass="btn btn-success" OnClick="lnkSubmit_Click">
                                            Submit
                                        </asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="lnkClear" CssClass="btn btn-warning" OnClick="lnkClear_Click">
                                            Clear
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                                    <%--New Supplier Pane
                                    <div class="tab-pane fade" id="tab-new-supplier">
                                        <%-- Supplier Name & TIN
                                        <div class="row m-2">
                                            <div class="col-8">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                    <label for="<%=txtSupplierName.ClientID%>">Name</label>
                                                </div>
                                            </div>
                                            <div class="col-4">
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
                                        </div>
                                        <%-- Supplier Address and Type
                                        <div class="row m-2">
                                            <div class="col-8">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                    <label for="<%=txtSupplierAddress.ClientID%>">Address</label>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="form-floating">
                                                    <asp:DropDownList runat="server" ID="ddSupplierType" CssClass="form-select"></asp:DropDownList>
                                                    <label for="<%=ddSupplierType.ClientID%>">Type</label>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- Save Button
                                        <div class="row m-2">
                                            <div class="col-4">
                                                <asp:LinkButton runat="server" ID="lnkSupplierSave" CssClass="btn btn-outline-success">Save</asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lnkSupplierClear" CssClass="btn btn-outline-warning">Clear</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div> --%>
                                <%-- Miscellaneous Pane
                                <div class="tab-pane fade" id="tab-misc">
                                    <div class="row">
                                        <div class="col">
                                            <div class="row m-2">
                                                <%-- Supplier
                                                <div class="col-8">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscSupplier" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                        <label for="<%=txtMiscSupplier.ClientID%>">Supplier</label>
                                                    </div>
                                                </div>
                                                <%-- TIN
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscTIN" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                        <label for="<%=txtMiscTIN.ClientID%>">TIN</label>
                                                    </div>
                                                </div> 
                                            </div>
                                            <%-- PO Number and Receipt Number
                                            <div class="row m-2">
                                                <div class="col-6">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscPO" CssClass="form-control"
                                                            AutoCompleteType="Disabled"></asp:TextBox>
                                                        <label for="<%=txtMiscPO.ClientID%>">PO No.</label>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscReceipt" CssClass="form-control"
                                                            AutoCompleteType="Disabled"></asp:TextBox>
                                                        <label for="<%=txtMiscReceipt.ClientID%>">Receipt No.</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Amount & VAT
                                            <div class="row m-2">
                                                <div class="col-3">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscVATAmount" CssClass="form-control" 
                                                            TextMode="Number" Text="0" onchange="CalculateMiscTotal()"></asp:TextBox>
                                                        <label for="<%=txtMiscVATAmount.ClientID%>">VATable</span>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscNonVATAmount" CssClass="form-control"
                                                            TextMode="Number" Text="0" onchange="CalculateMiscTotal()"></asp:TextBox>
                                                        <label for="<%=txtMiscNonVATAmount.ClientID%>">Non-VAT</label>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscVAT" CssClass="form-control"
                                                            TextMode="Number" Text="0" onchange="CalculateMiscTotal()"></asp:TextBox>
                                                        <label for="<%=txtMiscVAT.ClientID%>">VAT</label>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscTotal" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateMiscVAT()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtMiscTotal.ClientID%>">Total</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Particulars
                                            <div class="row m-2">
                                                <div class="col">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMiscParticulars" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtMiscParticulars.ClientID%>">Particulars</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <asp:LinkButton runat="server" ID="lnkMiscSubmit" CssClass="btn btn-outline-success" 
                                                        OnClick="lnkMiscSubmit_Click">Submit</asp:LinkButton>
                                                    <asp:LinkButton runat="server" ID="lnkMiscClear" CssClass="btn btn-outline-warning" 
                                                        OnClick="lnkMiscClear_Click">Clear</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                --%>  
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-success position-absolute bottom-0 end-0 m-5" 
                    data-bs-toggle="modal" data-bs-target="#new-supplier-modal">
                    New Supplier <span class="fa fa-plus-circle"></span>
                </button>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddType" EventName="SelectedIndexChanged" />
                <asp:PostBackTrigger ControlID="lnkSubmit" />
                <asp:AsyncPostBackTrigger ControlID="cbIsCheque" EventName="CheckedChanged" />
                <asp:AsyncPostBackTrigger ControlID="lnkClear" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <%-- Supplier List Modal --%>
        <div class="modal fade" tabindex="-1" id="supplier-modal">
            <div class="modal-dialog">
                <div class="modal-content" style="max-height:85vh;">
                    <div class="modal-header">
                        <%-- Search Textbox --%>
                        <input type="text" id="supplier-search" placeholder="Search Supplier" class="form-control" 
                            role="search" autocomplete="off" />
                    </div>
                    <div class="modal-body overflow-y-auto">
                        <%-- Supplier List --%>
                        <asp:GridView runat="server" ID="gvSupplierList" CssClass="table" AutoGenerateColumns="false" 
                            ShowHeader="true" GridLines="Horizontal" DataKeyNames="SupplierID">
                            <Columns>
                                <asp:BoundField DataField="Supplier_Name" HeaderText="Name" ItemStyle-Width="40%"/>
                                <asp:BoundField DataField="TIN" HeaderText="TIN" ItemStyle-Width="40%" />
                                <asp:TemplateField ItemStyle-Width="20%">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkSupplierSelect" 
                                            CssClass="btn btn-sm btn-primary" OnClick="lnkSupplierSelect_Click">
                                            <b class="fa fa-check-circle"></b> Select
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-dark" data-bs-dismiss="modal" aria-label="Close" type="button">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <%-- New Supplier Modal --%>
        <div class="modal fade" tabindex="-1" id="new-supplier-modal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6>New Supplier</h6>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                    </div>
                    <div class="modal-body">
                        <div class="row my-2">
                            <div class="col-8">
                                <div class="form-floating">
                                    <%-- Supplier Name --%>
                                    <asp:TextBox runat="server" ID="txtNewSupplierName" CssClass="form-control" 
                                        AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=txtNewSupplierName.ClientID%>">Name</label>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="input-group">
                                    <div class="form-floating">
                                        <%-- Supplier TIN --%>
                                        <asp:TextBox runat="server" ID="txtNewSupplierTIN" CssClass="form-control" 
                                            AutoCompleteType="Disabled"></asp:TextBox>
                                        <label for="<%=txtNewSupplierTIN.ClientID%>">TIN</label>
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
                                    <asp:TextBox runat="server" ID="txtNewSupplierAddress" CssClass="form-control" 
                                        AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=txtNewSupplierAddress.ClientID%>">Address</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <%-- New Supplier Submit Button --%>
                        <asp:LinkButton runat="server" ID="btnNewSupplierSubmit" CssClass="btn btn-success" OnClick="btnNewSupplierSubmit_Click">
                            Submit
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <%-- Company Expense List --%>
        <div class="modal fade" id="expense-modal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <asp:UpdatePanel runat="server" ID="upExpenses" ChildrenAsTriggers="false" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="modal-header">
                                <input type="text" class="form-control w-25" id="expense-search" placeholder="Search" />
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <asp:GridView runat="server" ID="gvExpenses" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                    DataKeyNames="ID" EmptyDataText="No Expenses found." EmptyDataRowStyle-CssClass="text-center">
                                    <Columns>
                                        <asp:BoundField DataField="Supplier_Name" HeaderText="Supplier" ItemStyle-Width="40%" />
                                        <asp:BoundField DataField="TypeName" HeaderText="Type" ItemStyle-Width="20%" />
                                        <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:N2}" ItemStyle-Width="20%" />
                                        <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:M/d/yyyy}" ItemStyle-Width="15%" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="btnSelectExpense" CssClass="btn btn-primary" OnClick="btnSelectExpense_Click">
                                                    <span class="fa fa-edit"></span>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>  
            </div>
        </div>
    </div>
</asp:Content>
