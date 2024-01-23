<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Branch.aspx.cs" Inherits="Book_Keeping_System.Branch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
       
        function pageLoad() {
            //Search function for Branch List
            $('[id*=search-bar]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvBranchList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            //Search function for Supplier List
            $('[id*=supplier-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvUtilitySupplierList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
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

    <div class="container-fluid" style="padding-left:0;padding-right:0;">
        <asp:UpdatePanel runat="server" ID="upBranchList">
            <ContentTemplate>
                <asp:Panel runat="server" ID="panelBranchLists">
                    <div class="card" style="border:0;">
                        <%-- Header --%>
                        <div class="card-header bg-success-subtle" style="height:57px">
                            <div class="row d-flex align-items-center">
                                <div class="col-8">
                                    <b class="fa fa-building"></b>  <b>Branches Information</b>
                                </div>
                                <%-- Search Bar --%>
                                <div class="col-4">
                                    <div class="input-group">
                                        <input type="text" id="search-bar" placeholder="Search" 
                                            class="form-control form-control-sm" role="search"></input>
                                        <div class="btn-group">
                                            <asp:LinkButton runat="server" ID="lnkNew" CssClass="btn btn-sm btn-outline-success" OnClick="lnkNew_Click"><b class="fa fa-plus-circle"></b> New</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- Body --%>
                        <div class="card-body ms-5 me-5">
                            <%-- Branch List --%>
                            <asp:Panel runat="server" ID="panelGridViewLists" Height="600px" ScrollBars="Vertical">
                                <%-- Branch GridView --%>
                                <asp:GridView runat="server" ID="gvBranchList" GridLines="Horizontal" AutoGenerateColumns="false" CssClass="table table-responsive">
                                    <Columns>
                                        <%-- <asp:BoundField DataField="BranchAddress" HeaderText="Address" />
                                        <asp:BoundField DataField="BranchStatus" HeaderText="Status" />--%>
                                        <asp:BoundField DataField="BranchID" />
                                        <asp:BoundField DataField="BranchCode" />
                                        <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                        <%--<asp:BoundField DataField="Supervisor_Name" HeaderText="Supervisor" />--%>
                                        <asp:BoundField DataField="Company_Name"  HeaderText="Company"/>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-outline-primary btn-sm" OnClick="lnkEdit_Click"><b class="fa fa-pencil"></b> Edit</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                    </div>
                </asp:Panel>
                <%-- Branch Data Panel --%>
                <asp:Panel runat="server" ID="panelBranchInputForm" Visible="false">
                    <div class="card" style="border:0;">
                        <%-- Header --%>
                        <div class="card-header-tabs bg-success-subtle">
                            <ul class="nav nav-tabs ms-2" id="myTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-basic" 
                                        type="button" role="tab" aria-controls="tab-basic" aria-selected="true">
                                        Basic
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-utilities" 
                                        type="button" role="tab" aria-controls="tab-utilities" aria-selected="true">
                                        Default Utilities Provider
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-rental" 
                                        type="button" role="tab" aria-controls="tab-rental" aria-selected="false">
                                        Rental Information
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-sales"
                                        type="button" role="tab" aria-controls="tab-sales" aria-selected="false">
                                        Sales
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-expenses"
                                        type="button" role="tab" aria-controls="tab-expenses" aria-selected="false">
                                        Expenses
                                    </button>
                                </li>
                            </ul>
                        </div>
                            <%-- Body --%>
                            <div class="card-body ms-5 me-5 tab-content">
                                <div class="tab-pane fade show active" id="tab-basic" role="tabpanel">
                                    <asp:Panel runat="server" ID="pBasic">
                                        <%-- Branch Name --%>
                                        <div class="row mt-2">
                                            <div class="col">
                                                <div class="input-group">
                                                    <div class="form-floating small">
                                                        <asp:TextBox runat="server" ID="txtBranchName" CssClass="form-control" placeholder="Branch Name"></asp:TextBox>
                                                        <label for="txtBranchName">Branch Name</label>
                                                    </div>
                                                    <div class="input-group-text d-flex align-items-center">
                                                       Open <asp:CheckBox runat="server" ID="cbOpen"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- Branch Address --%>
                                        <div class="row mt-2">
                                            <div class="col">
                                                <div class="form-floating small">
                                                    <asp:TextBox runat="server" ID="txtBranch_Address" CssClass="form-control"
                                                        placeholder="Address"></asp:TextBox>
                                                    <label for="txtBranchName">Branch Address</label>
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
                                            <%-- Save & Back --%>
                                            <div class="col-4">
                                                <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn btn-outline-warning" OnClick="lnkBack_Click">
                                                    <b class="fa fa-arrow-circle-left"></b> Back
                                                </asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-outline-primary">
                                                    <b class="fa fa-save"></b> Save
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                                <div class="tab-pane fade" id="tab-utilities" role="tabpanel">
                                    <%-- New Provider Form --%>
                                    <asp:Panel runat="server" ID="pNewProvider" Visible="false">
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
                                    </asp:Panel>
                                    <%-- Provider List --%>
                                    <asp:Panel runat="server" ID="pProviderList" Visible="true">
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
                                                            <asp:BoundField DataField="ProviderName" HeaderText="Provider" />
                                                            <asp:BoundField DataField="AccountNumber" HeaderText="Account #" />
                                                            <asp:BoundField DataField="TIN" HeaderText="TIN" />
                                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks"/>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                                <div class="tab-pane fade" id="tab-rental" role="tabpanel">
                                    <%-- Rental Panel --%>
                                    <asp:Panel runat="server" ID="pRental">
                                        <div class="card-body">
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
                                               <asp:GridView runat="server" ID="gvBranchRentalList" CssClass="table table-responsive" AutoGenerateColumns="false">

                                               </asp:GridView>
                                           </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                                <div class="tab-pane fade" id="tab-sales" role="tabpanel">
                                    <%-- Sales Panel --%>
                                    <asp:Panel runat="server" ID="pBranchSales" CssClass="card">
                                        <div class="card-header">
                                            <div class="row">
                                                <div class="col-4 offset-8">
                                                    <asp:DropDownList runat="server" ID="ddSalesPeriod" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-6">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtBranchChickenSales" TextMode="Number" 
                                                            ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtBranchChickenSales.ClientID%>">Chicken</label>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtBranchAtsaraSales" TextMode="Number"
                                                            ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtBranchAtsaraSales.ClientID%>">Atsara</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                                <div class="tab-pane fade" id="tab-expenses" role="tabpanel">
                                    <asp:Panel runat="server" ID="pBranchExpenses" CssClass="card">
                                        <div class="card-header">
                                            <div class="row">
                                                <div class="col-8">
                                                    <input id="expense-search-box" class="form-control" />
                                                </div>
                                                <div class="col-4">
                                                    <asp:DropDownList runat="server" ID="ddExpensePeriod" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <asp:GridView runat="server" ID="gvBranchExpenses" CssClass="table table-responsive" 
                                                AutoGenerateColumns="false" GridLines="Horizontal">
                                                <Columns>
                                                    <%-- Supplier Name and Amount --%>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </asp:Panel>
                                </div>  
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>  
    </div>    
</asp:Content>
