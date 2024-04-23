<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Branch.aspx.cs" Inherits="Book_Keeping_System.Branch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
       
        function pageLoad() {
            //Search function for Branch List
            $('[id*=branch-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvBranchList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            $('[id*=expense-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvBranchExpenses] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }

        function setSelectedExpense(expense) {
            $('#<%=hiddenSelectedExpense.ClientID%>').val(expense);
            bootstrap.Modal.getOrCreateInstance($('#details-modal')).toggle();
            __doPostBack('<%=upExpense.ClientID%>', '');
        }

        function setContractRemarks(remarks) {
            $('#contract-remark').val(remarks);
            bootstrap.Modal.getOrCreateInstance($('#contract-modal')).toggle();
        }

        function closeSupplierModal() {
            bootstrap.Modal.getOrCreateInstance($('#supplier-modal')).toggle();
        }

        ////Search function
        //$(function searchInput() {
        //    $('[id*=search-bar]').on("keyup", function () {
        //        var value = $(this).val().toLowerCase();
        //        $('[id*=gvBranchList] tr').filter(function () {
        //            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        //        });
        //    });

        //    $('[id*=supplier-search]').on("keyup", function () {
        //        var value = $(this).val().toLowerCase();
        //        $('[id*=gvUtilitySupplierList] tr').filter(function () {
        //            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        //        });
        //    });
        //});


        ////On UpdatePanel Refresh
        //var prm = Sys.WebForms.PageRequestManager.getInstance();
        //if (prm != null) {
        //    prm.add_endRequest(function (sender, e) {
        //        if (sender._postBackSettings.panelsToUpdate != null) {


        //            //Search function
        //            $(function searchInput() {
        //                $('[id*=search-bar]').on("keyup", function () {
        //                    var value = $(this).val().toLowerCase();
        //                    $('[id*=gvBranchList] tr').filter(function () {
        //                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        //                    });
        //                });

        //                $('[id*=supplier-search]').on("keyup", function () {
        //                    var value = $(this).val().toLowerCase();
        //                    $('[id*=gvUtilitySupplierList] tr').filter(function () {
        //                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        //                    });
        //                });
        //            });
        //        }
        //    });
        //};

    </script>
    <div class="container-fluid">
        <h6 class="m-2">Branch Data</h6>
        <asp:Panel runat="server" ID="panelBranchLists">
            <div class="card" style="max-height:85vh;">
                <%-- Header --%>
                <div class="card-header">
                    <div class="row">
                        <%-- Search Bar --%>
                        <div class="col-4">
                            <input type="text" id="branch-search" placeholder="Search" class="form-control" role="search" autocomplete="off" />
                        </div>
                    </div>
                </div>
                <%-- Body --%>
                <div class="card-body overflow-y-auto">
                    <%-- Branch GridView --%>
                    <asp:GridView runat="server" ID="gvBranchList" GridLines="Horizontal" AutoGenerateColumns="false" 
                        CssClass="table table-responsive" DataKeyNames="BranchID,BranchCode">
                        <Columns>
                            <%-- <asp:BoundField DataField="BranchAddress" HeaderText="Address" />
                            <asp:BoundField DataField="BranchStatus" HeaderText="Status" />--%>
                            <asp:BoundField DataField="Branch_Name" HeaderText="Branch" ItemStyle-Width="30%" />
                            <%--<asp:BoundField DataField="Supervisor_Name" HeaderText="Supervisor" />--%>
                            <asp:BoundField DataField="Company_Name"  HeaderText="Company" ItemStyle-Width="30%"/>
                            <asp:BoundField DataField="IsActive" HeaderText="Active" ItemStyle-Width="20%" />
                            <asp:TemplateField ItemStyle-Width="20%">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-primary" OnClick="lnkEdit_Click">
                                        <span class="fa fa-search"></span>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <asp:LinkButton runat="server" ID="lnkNew" CssClass="btn btn-success position-fixed end-0 bottom-0 mb-5 me-5" 
                OnClick="lnkNew_Click">New Branch <span class="fa fa-plus-circle"></span></asp:LinkButton>
        </asp:Panel>
        <%-- Branch Data Panel --%>
        <asp:Panel runat="server" ID="pBranchInputForm" Visible="false">
            <div class="row">
                <%-- Sidebar Pills --%>
                <aside class="col-auto col-md-1 col-xl-1">
                    <div class="d-flex flex-column align-items-center">
                        <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn" OnClick="lnkBack_Click">
                            <span class="fa fa-arrow-left"></span>
                        </asp:LinkButton>
                        <ul class="nav nav-pills ms-2 <%if (string.IsNullOrWhiteSpace(this.txtBranchCode.Text)) Response.Write("visually-hidden"); %>" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" data-bs-toggle="pill" data-bs-target="#tab-basic" 
                                    type="button" role="tab" aria-controls="tab-basic" aria-selected="true">
                                    <span class="fa fa-info-circle"></span> <span class="d-none d-xxl-inline">Basic</span>
                                </button>
                            </li>
                            <%--<li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-utilities" 
                                    type="button" role="tab" aria-controls="tab-utilities" aria-selected="true">
                                    Default Utilities Provider
                                </button>
                            </li>--%>
                            <%--<li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-rental" 
                                    type="button" role="tab" aria-controls="tab-rental" aria-selected="false">
                                    Rental Information
                                </button>
                            </li>--%>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-sales"
                                    type="button" role="tab" aria-controls="tab-sales" aria-selected="false">
                                    <span class="fa fa-money"></span> <span class="d-none d-xxl-inline">Sales</span>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-expenses"
                                    type="button" role="tab" aria-controls="tab-expenses" aria-selected="false">
                                    <span class="fa fa-list-alt"></span> <span class="d-none d-xxl-inline">Expenses</span>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-rental" type="button" 
                                    role="tab" aria-controls="tab-rental" aria-selected="false">
                                    <span class="fa fa-building"></span> <span class="d-none d-xxl-inline">Rental</span>
                                </button>
                            </li>
                        </ul>
                    </div>
                </aside>
                <%-- Main Content --%>
                <main class="col tab-content">
                    <div class="tab-pane fade show active" id="tab-basic" role="tabpanel">
                        <div class="row mt-2">
                            <div class="col-8">
                                <div class="input-group">
                                    <div class="form-floating">
                                        <%-- Branch Name --%>
                                        <asp:TextBox runat="server" ID="txtBranchName" CssClass="form-control" placeholder="Branch Name" 
                                            AutoCompleteType="Disabled"></asp:TextBox>
                                        <label for="<%=txtBranchName.ClientID%>">Branch Name</label>
                                    </div>
                                    <div class="input-group-text d-flex align-items-center">
                                        Open <asp:CheckBox runat="server" ID="cbOpen"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="form-floating">
                                    <%-- Branch TIN --%>
                                    <asp:TextBox runat="server" ID="txtBranchTIN" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=txtBranchTIN.ClientID%>">TIN</label>
                                </div>
                            </div>
                        </div>
                        <%-- Branch Address --%>
                        <div class="row mt-2">
                            <div class="col-2">
                                <div class="form-floating">
                                    <asp:TextBox runat="server" ID="txtBranchCode" CssClass="form-control" placeholder="Code" 
                                        AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=this.txtBranchCode.ClientID%>">Branch Code</label>
                                </div>
                            </div>
                            <div class="col-10">
                                <div class="form-floating small">
                                    <asp:TextBox runat="server" ID="txtBranch_Address" CssClass="form-control"
                                        placeholder="Address" AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=this.txtBranch_Address.ClientID%>">Branch Address</label>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <%-- Supervisor --%>
                            <div class="col-6">
                                <div class="form-floating">
                                    <asp:DropDownList runat="server" ID="ddSupervisorLists" CssClass="form-select" aria-label="Floating label select example"></asp:DropDownList>
                                    <label for="ddSupervisorLists">Supervisor</label>
                                </div>
                            </div>
                            <%-- Company --%>
                            <div class="col-6">
                                <div class="form-floating">
                                    <asp:DropDownList runat="server" ID="ddCompanyLists" CssClass="form-select" aria-label="Floating label select example"></asp:DropDownList>
                                    <label for="ddCompanyLists">Company</label>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <%-- Save --%>
                            <div class="col-4">
                                <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-primary" OnClick="lnkSave_Click">
                                    <b class="fa fa-save"></b> Save
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <%--<div class="tab-pane fade" id="tab-utilities" role="tabpanel">--%>
                        <%-- New Provider Form --%>
                        <%--<asp:Panel runat="server" ID="pNewProvider" Visible="false">
                            <div class="row mt-2">
                                <div class="col-6">
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtProvider" CssClass="form-control"
                                            placeholder="Provider"></asp:TextBox>
                                        <label for="txtProvider">Provider</label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtProviderAcctNumber" CssClass="form-control"
                                            placeholder="Account Number"></asp:TextBox>
                                        <label for="txtProviderAcctNumber">Account Number</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-6">
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtTIN" CssClass="form-control"
                                            placeholder="TIN Number"></asp:TextBox>
                                        <label for="txtTIN">TIN Number</label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control"
                                            placeholder="Remarks"></asp:TextBox>
                                        <label for="txtRemarks">Remarks</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="card" style="padding-left:0;padding-right:0;">
                                    <div class="card-header">
                                        <div class="row">
                                            <div class="col-8">
                                                <input class="form-control" id="supplier-search" role="search"/>
                                            </div>
                                            <div class="col-4">
                                                <asp:DropDownList runat="server" ID="ddSupplierType" 
                                                    CssClass="form-control"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body" style="overflow:scroll;height:300px;">
                                        <asp:GridView runat="server" ID="gvUtilitySupplierList" AutoGenerateColumns="false" 
                                            CssClass="table table-responsive" OnRowCreated="gvUtilitySupplierList_RowCreated" OnRowDataBound="gvUtilitySupplierList_RowCreated">
                                            <Columns>
                                                <asp:BoundField DataField="SupplierID" ItemStyle-Width="5%"/>
                                                <asp:BoundField DataField="Supplier_Name" HeaderText="Name" ItemStyle-Width="40%"/>
                                                <asp:BoundField DataField="TIN" HeaderText="TIN" ItemStyle-Width="35%" />
                                                <asp:TemplateField ItemStyle-Width="20%">
                                                    <ItemTemplate>
                                                        <asp:LinkButton runat="server" ID="lnkUtilitySelect" 
                                                            CssClass="btn btn-sm btn-outline-primary" OnClick="lnkUtilitySelect_Click">
                                                            <b class="fa fa-check-circle"></b> Select
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-4">
                                    <asp:LinkButton runat="server" ID="lnkProviderBack" CssClass="btn btn-outline-warning" 
                                        OnClick="lnkProviderBack_Click">Back</asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="lnkSaveProvider" OnClick="lnkSaveProvider_Click" CssClass="btn btn-outline-primary">
                                        <b class="fa fa-save"></b> Save
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </asp:Panel>--%>
                        <%-- Provider List --%>
                        <%--<asp:Panel runat="server" ID="pProviderList" Visible="true">
                            <div class="row m-2">
                                <div class="card" style="padding-left:0;padding-right:0;">
                                    <div class="card-header">
                                        <div class="row">
                                            <div class="col-9">
                                                List of Assigned Provider
                                            </div>
                                            <div class="col-3">
                                                <asp:LinkButton runat="server" ID="lnkAddNewProvider" OnClick="lnkAddNewProvider_Click" CssClass="btn btn-outline-primary btn-sm">
                                                    New Provider
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <asp:GridView runat="server" ID="gvBranchDefaultUtilities" AutoGenerateColumns="false" CssClass="table table-responsive table-light">
                                            <Columns>
                                                <asp:BoundField DataField="SupplierName" HeaderText="Supplier" />
                                                <asp:BoundField DataField="AccountNumber" HeaderText="Account #" />
                                                <asp:BoundField DataField="TIN" HeaderText="TIN" />
                                                <asp:BoundField DataField="Remarks" HeaderText="Remarks"/>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>--%>
                    <%--<div class="tab-pane fade" id="tab-rental" role="tabpanel">
                        <asp:Panel runat="server" ID="pRental">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="row m-2">
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtBranchRentalAmount" TextMode="Number" 
                                                        CssClass="form-control"></asp:TextBox>
                                                    <label for="<%=txtBranchRentalAmount.ClientID%>">Amount</label>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtBranchEWT" TextMode="Number" 
                                                        CssClass="form-control"></asp:TextBox>
                                                    <label for="<%=txtBranchEWT%>">EWT</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row m-2">
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtRentalFrom" TextMode="Date"
                                                        CssClass="form-control"></asp:TextBox>
                                                    <label for="<%=txtRentalFrom.ClientID%>">From</label>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtRentalTo" TextMode="Date"
                                                        CssClass="form-control"></asp:TextBox>
                                                    <label for="<%=txtRentalTo.ClientID%>">To</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row m-2">
                                            <div class="col-4">
                                                <asp:DropDownList runat="server" ID="ddRentalPaymentType" CssClass="form-control"></asp:DropDownList>
                                            </div>
                                            <div class="col-8">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtChequeNumber" CssClass="form-control"></asp:TextBox>
                                                    <label for="<%=txtRentalTo.ClientID%>">Number</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row m-2">
                                            <div class="col-8">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtLessor" CssClass="form-control"></asp:TextBox>
                                                    <label for="<%=txtRentalTo.ClientID%>">Lessor</label>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <asp:LinkButton runat="server" ID="lnkRentalSave" CssClass="btn btn-outline-success">Save</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <asp:Label runat="server" ID="lblNoRentalTransaction">No Rental Transaction found</asp:Label>
                                        <asp:GridView runat="server" ID="gvBranchRentalList" CssClass="table table-responsive" AutoGenerateColumns="false">

                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>--%>
                    <%-- Sales Pane --%>
                    <div class="tab-pane fade" id="tab-sales" role="tabpanel">
                        <asp:UpdatePanel runat="server" ID="upSales" ChildrenAsTriggers="false" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="row my-2">
                                    <div class="col-2">
                                        <%-- Month Dropdown Filter --%>
                                        <asp:DropDownList runat="server" ID="ddSalesMonthFilter" CssClass="form-select h-100" 
                                            OnSelectedIndexChanged="ddSalesMonthFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <div class="col-2">
                                        <%-- Year Dropdown Filter --%>
                                        <asp:DropDownList runat="server" ID="ddSalesYearFilter" CssClass="form-select h-100" 
                                            OnSelectedIndexChanged="ddSalesYearFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="container-fluid overflow-y-auto" style="max-height:80vh;">
                                            <%-- Sales GridView --%>
                                            <asp:GridView runat="server" ID="gvBranchSales" AutoGenerateColumns="false" CssClass="table table-responsive overflow-y-auto" 
                                                OnRowCreated="gvBranchSales_RowCreated" OnRowDataBound="gvBranchSales_RowDataBound" ShowFooter="true" 
                                                EmptyDataText="No Sales found." EmptyDataRowStyle-CssClass="text-center">
                                                <Columns>
                                                    <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-Width="20%" DataFormatString="{0:M/d/yyyy}" />
                                                    <asp:TemplateField HeaderText="Invoice" ItemStyle-Width="40%">
                                                        <ItemTemplate>
                                                            <p><%#Eval("StartingInvoice")%> - <%#Eval("EndingInvoice")%></p>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Chicken" ItemStyle-Width="20%">
                                                        <ItemTemplate>
                                                            <%#Eval("ChickenTotal","{0:N2}")%>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label runat="server" ID="lblChickenOverallTotal"></asp:Label>
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Atsara" ItemStyle-Width="20%" >
                                                        <ItemTemplate>
                                                            <%#Eval("AtsaraTotal","{0:N2}")%>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label runat="server" ID="lblAtsaraOverallTotal"></asp:Label>
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                             <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddSalesMonthFilter" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddSalesYearFilter" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="gvBranchSales" EventName="RowCreated" />
                                <asp:AsyncPostBackTrigger ControlID="gvBranchSales" EventName="RowDataBound" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <%-- Expenses Pane --%>
                    <div class="tab-pane fade" id="tab-expenses" role="tabpanel">
                        <asp:UpdatePanel runat="server" ID="upExpense" ChildrenAsTriggers="false" UpdateMode="Conditional">
                            <ContentTemplate>   
                                <div class="row my-2">
                                    <div class="col-4">
                                        <input id="expense-search" class="form-control" autocomplete="off" type="text" role="search" />
                                    </div>
                                    <div class="col-2">
                                        <%-- Month Dropdown Filter --%>
                                        <asp:DropDownList runat="server" ID="ddExpenseMonthFilter" CssClass="form-select h-100" 
                                            OnSelectedIndexChanged="ddExpenseMonthFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <div class="col-2">
                                        <%-- Year Dropdown Filter --%>
                                        <asp:DropDownList runat="server" ID="ddExpenseYearFilter" CssClass="form-select h-100" 
                                            OnSelectedIndexChanged="ddExpenseYearFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                </div> 
                                <div class="row">
                                    <div class="col">
                                        <asp:GridView runat="server" ID="gvBranchExpenses" CssClass="table table-responsive" 
                                            AutoGenerateColumns="false" DataKeyNames="ID" EmptyDataText="No Expenses found." 
                                            EmptyDataRowStyle-CssClass="text-center">
                                            <Columns>
                                                <asp:BoundField DataField="Supplier_Name" HeaderText="Supplier" ItemStyle-Width="40%" />
                                                <asp:BoundField DataField="TypeName" HeaderText="Type" ItemStyle-Width="20%" />
                                                <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:N2}" ItemStyle-Width="20%" />
                                                <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:M/d/yyyy}" ItemStyle-Width="15%" />
                                                <asp:TemplateField ItemStyle-Width="5%">
                                                    <ItemTemplate>
                                                        <button type="button" class="btn btn-primary" onclick="setSelectedExpense(<%#Eval("ID").ToString()%>);return false;">
                                                            <span class="fa fa-search"></span>
                                                        </button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddExpenseMonthFilter" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddExpenseYearFilter" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <%-- Rental Pane --%>
                    <div class="tab-pane fade" id="tab-rental" role="tabpanel">
                        <asp:UpdatePanel runat="server" ID="upRental" ChildrenAsTriggers="false" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel runat="server" ID="pContractList" Visible="true">
                                    <div class="row my-2">
                                        <div class="col">
                                            <div class="container-fluid" style="max-height:85vh;">
                                                <%-- Contract List --%>
                                                <asp:GridView runat="server" ID="gvRentalContract" AutoGenerateColumns="false" CssClass="table table-responsive" 
                                                    DataKeyNames="ID" EmptyDataText="No contracts found." EmptyDataRowStyle-CssClass="text-center">
                                                    <Columns>
                                                        <asp:BoundField DataField="Supplier_Name" HeaderText="Lessor" />
                                                        <asp:BoundField DataField="TIN" HeaderText="TIN" />
                                                        <asp:TemplateField HeaderText="Coverage">
                                                            <ItemTemplate>
                                                                <%#Eval("FromDate","{0:M/d/yyyy}")%> - <%#Eval("ToDate","{0:M/d/yyyy}")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <button type="button" class="btn btn-primary" 
                                                                    onclick="setContractRemarks(<%#Eval("Remarks").ToString()%>)">
                                                                    <span class="fa fa-search"></span>
                                                                </button>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <%-- New Contract Button --%>
                                                <asp:LinkButton runat="server" ID="btnNewContract" 
                                                    CssClass="btn btn-success position-fixed end-0 bottom-0 mb-5 me-5" OnClick="btnNewContract_Click">
                                                    New Contract <span class="fa fa-plus-circle"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel runat="server" ID="pContractForm" Visible="false">
                                    <div class="row my-2">
                                        <div class="col-8">
                                            <asp:HiddenField runat="server" ID="hiddenSelectedLessor" />
                                            <div class="input-group">
                                                <div class="form-floating">
                                                    <%-- Lessor --%>
                                                    <asp:TextBox runat="server" ID="txtLessor" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                    <label for="<%=txtLessor.ClientID%>">Lessor</label>
                                                </div>
                                                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#supplier-modal">
                                                    <span class="fa fa-search"></span>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <%-- TIN --%>
                                                <asp:TextBox runat="server" ID="txtLessorTIN" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                <label for="<%=txtLessorTIN.ClientID%>">TIN</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-8">
                                            <div class="form-floating">
                                                <%-- Lessee --%>
                                                <asp:TextBox runat="server" ID="txtLessee" CssClass="form-control" 
                                                    AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtLessee.ClientID%>">Lessee</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <%-- From Date --%>
                                                <asp:TextBox runat="server" ID="txtFromContract" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                <label for="<%=txtFromContract.ClientID%>">From</label>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <%-- To Date --%>
                                                <asp:TextBox runat="server" ID="txtToContract" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                <label for="<%=txtToContract.ClientID%>">To</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-8">
                                            <div class="form-floating">
                                                <%-- Remarks --%>
                                                <asp:TextBox runat="server" ID="txtContractRemarks" CssClass="form-control" 
                                                    TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtContractRemarks.ClientID%>">Remarks</label>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <%-- Save and Cancel Buttons --%>
                                            <asp:LinkButton runat="server" ID="btnSaveNewContract" CssClass="btn btn-success" 
                                                OnClick="btnSaveNewContract_Click">Save</asp:LinkButton>
                                            <asp:LinkButton runat="server" ID="btnCancelNewContract" CssClass="btn btn-dark" 
                                                OnClick="btnCancelNewContract_Click">Cancel</asp:LinkButton>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnNewContract" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCancelNewContract" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnSaveNewContract" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </main>
            </div>
        </asp:Panel>
        <%-- Expense Details Modal --%>
        <div class="modal fade" tabindex="-1" id="details-modal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="btn-close" onclick="setSelectedExpense('');return false;" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:UpdatePanel runat="server" ID="upDetails" ChildrenAsTriggers="false" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="row m-2">
                                    <%-- Supplier --%>
                                    <div class="col-8">
                                        <asp:HiddenField runat="server" ID="hiddenSelectedExpense" OnValueChanged="hiddenSelectedExpense_ValueChanged" />
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtSupplier" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtSupplier.ClientID%>">Supplier</label>
                                        </div>
                                    </div>
                                    <%-- TIN --%>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtTIN" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtTIN.ClientID%>">TIN</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-2">
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- Invoice Number --%>
                                            <asp:TextBox runat="server" ID="txtInvoice" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtInvoice.ClientID%>">Receipt Number</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- Expense Type --%>
                                            <asp:TextBox runat="server" ID="txtType" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtType.ClientID%>">Type</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-2">
                                    <%-- Utility Line --%>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtUtilityFrom" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtUtilityFrom.ClientID%>">From</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtUtilityTo" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtUtilityTo.ClientID%>">To</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtAccountNumber" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtAccountNumber.ClientID%>">Account Number</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-2">
                                    <%-- Amount Line --%>
                                    <div class="col-3">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtVATAmount" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtVATAmount.ClientID%>">VATable</label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtNonVATAmount" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtNonVATAmount.ClientID%>">Non-VAT</label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtVAT" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtVAT.ClientID%>">VAT</label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtTotal" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtTotal.ClientID%>">Total</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-2">
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- Amount Tendered --%>
                                            <asp:TextBox runat="server" ID="txtTendered" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtTendered.ClientID%>">Amount Tendered</label>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-floating">
                                            <%-- Remarks --%>
                                            <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtRemarks.ClientID%>">Remarks</label>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="hiddenSelectedExpense" EventName="ValueChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton runat="server" ID="btnExpenseEdit" CssClass="btn btn-success" OnClick="btnExpenseEdit_Click">
                            Edit
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <%-- Supplier Modal --%>
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
                        <asp:GridView runat="server" ID="gvSupplierList" CssClass="table table-hover small" AutoGenerateColumns="false" 
                            DataKeyNames="SupplierID">
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
        <%-- Contract Modal --%>
        <div class="modal fade" tabindex="-1" id="contract-modal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6>Remarks</h6>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="contract-remark"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>    
</asp:Content>
