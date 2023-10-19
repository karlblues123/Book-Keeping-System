﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CompanyExpenses.aspx.cs" Inherits="Book_Keeping_System.CompanyExpenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function ShowToast(msg) {
            document.getElementById('toast-message').textContent = msg;
            var toast = new bootstrap.Toast(document.getElementById('success-toast'));
            toast.show();
        };

        function ShowError(msg) {
            document.getElementById('error-message').textContent = msg;
            var toast = new bootstrap.Toast(document.getElementById('error-toast'));
            toast.show();
        }

        function EnableNavs() {
            var links = document.getElementById('form-pills').querySelectorAll('.nav-link');
            links.forEach(link => {
                link.classList.remove('disabled');
            });
        }

        function CalculateUtilityTotal() {
            var vatable = 0, nonvat = 0, vat = 0;
            if (document.getElementById('<%=txtUtilityVATAmount.ClientID%>').value != null) {
                vatable = + Number.parseFloat(document.getElementById('<%=txtUtilityVATAmount.ClientID%>').value).toFixed(2);
            }
                
            if (document.getElementById('<%=txtUtilityNonVATAmount.ClientID%>').value != null) {
                nonvat = + Number.parseFloat(document.getElementById('<%=txtUtilityNonVATAmount.ClientID%>').value).toFixed(2);
            }
                
            if (document.getElementById('<%=txtUtilityVAT.ClientID%>').value != null) {
                vat = + Number.parseFloat(document.getElementById('<%=txtUtilityVAT.ClientID%>').value).toFixed(2);
            }
            document.getElementById("<%=txtUtilityTotal.ClientID%>").value = vatable + nonvat + vat;
        }

        function CalculateMiscTotal() {
            var vatable = 0, nonvat = 0, vat = 0;
            if (document.getElementById('<%=txtMiscVATAmount.ClientID%>').value != null) {
                vatable = + Number.parseFloat(document.getElementById('<%=txtMiscVATAmount.ClientID%>').value).toFixed(2);
            }
                
            if (document.getElementById('<%=txtMiscNonVATAmount.ClientID%>').value != null) {
                nonvat = + Number.parseFloat(document.getElementById('<%=txtMiscNonVATAmount.ClientID%>').value).toFixed(2);
            }
                
            if (document.getElementById('<%=txtMiscVAT.ClientID%>').value != null) {
                vat = + Number.parseFloat(document.getElementById('<%=txtMiscVAT.ClientID%>').value).toFixed(2);
            }
            document.getElementById("<%=txtMiscTotal.ClientID%>").value = vatable + nonvat + vat;
        }

        function CalculateUtilityVAT() {
            var total = 0, vatable = 0;
            if (document.getElementById('<%=txtUtilityTotal.ClientID%>').value != null) {
                total = +Number.parseFloat(document.getElementById('<%=txtUtilityTotal.ClientID%>').value).toFixed(2);
                vatable = (total / 1.12).toFixed(2);
            }
            document.getElementById('<%=txtUtilityVATAmount.ClientID%>').value = vatable;
            document.getElementById('<%=txtUtilityVAT.ClientID%>').value = (total - vatable).toFixed(2);
        }

        function CalculateMiscVAT() {
            var total = 0, vatable = 0;
            if (document.getElementById('<%=txtMiscTotal.ClientID%>').value != null) {
                total = +Number.parseFloat(document.getElementById('<%=txtMiscTotal.ClientID%>').value).toFixed(2);
                vatable = (total / 1.12).toFixed(2);
            }
            document.getElementById('<%=txtMiscVATAmount.ClientID%>').value = vatable;
            document.getElementById('<%=txtMiscVAT.ClientID%>').value = (total - vatable).toFixed(2);
        }

        //Search function
        $(function searchInput() {
            $('[id*=utility-search-bar]').on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvUtilitySupplierList] tr').filter(function () {
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
                        $('[id*=utility-search-bar]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            $('[id*=gvUtilitySupplierList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });

                }
            });
        };

        //Search function
        $(function searchInput() {
            $('[id*=misc-search-bar]').on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvMiscSupplierList] tr').filter(function () {
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
                        $('[id*=misc-search-bar]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            $('[id*=gvMiscSupplierList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });

                }
            });
        };
    </script>
    <div class="containter-fluid">
        <%-- Main Card --%>
        <div class="card" style="border:none">
            <%-- Main Card Header --%>
            <div class="card-header bg-success-subtle">
                <div class="row">
                    <div class="col-3">
                        <div class="input-group">
                            <span class="input-group-text"><b class="fa fa-briefcase"></b></span>
                            <%-- Company Dropdown List --%>
                            <asp:DropDownList runat="server" ID="ddCompanyList" CssClass="form-control" 
                                OnSelectedIndexChanged="ddCompanyList_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-6">
                        <ul class="nav nav-pills" id="form-pills" role="tablist">
                            <%-- Tab Link Utility --%>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link disabled" data-bs-toggle="tab" data-bs-target="#tab-utility"
                                    type="button" role="tab" aria-controls="tab-utility" aria-selected="false">
                                    Utility
                                </button>
                            </li>
                            <%-- Tab Link Miscellaneous --%>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link disabled" data-bs-toggle="tab" data-bs-target="#tab-misc" 
                                    type="button" role="tab" aria-controls="tab-misc" aria-selected="false">
                                    Miscellaneous
                                </button>
                            </li>
                            <%-- Tab Link New Supplier --%>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link disabled" data-bs-toggle="tab" data-bs-target="#tab-new-supplier" 
                                    type="button" role="tab" aria-controls="tab-new-supplier" aria-selected="false">
                                    New Supplier
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="col-3">
                        <%-- Date --%>
                        <asp:UpdatePanel runat="server" ID="upDate" UpdateMode="Conditional" ChildrenAsTriggers="false">
                            <Triggers>     
                            </Triggers>
                            <ContentTemplate>
                                <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
            <%-- Main Card Body --%>
            <div class="card-body mt-2 tab-content">
                <%-- Utility Pane --%>
                <div class="tab-pane fade" id="tab-utility">
                    <asp:UpdatePanel runat="server" ID="upUtility" UpdateMode="Conditional" ChildrenAsTriggers="false">
                        <Triggers>
                        </Triggers>
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-4">
                                    <div class="card">
                                        <div class="card-header">
                                            <div class="row">
                                                <div class="col">
                                                    <%-- Search Textbox --%>
                                                    <input type="text" id="utility-search-bar" placeholder="Search" 
                                                        class="form-control form-control-sm" role="search" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body" style="height:550px;overflow-y:scroll;">
                                            <asp:GridView runat="server" ID="gvUtilitySupplierList" CssClass="table table-hover small" AutoGenerateColumns="false" 
                                                ShowHeader="true" GridLines="Horizontal" OnRowDataBound="gvSupplierList_RowDataBound">
                                                <Columns>
                                                    <asp:BoundField DataField="SupplierID" ItemStyle-Width="5%"/>
                                                    <asp:BoundField DataField="Supplier_Name" HeaderText="Name" ItemStyle-Width="40%"/>
                                                    <asp:BoundField DataField="TIN" HeaderText="TIN" ItemStyle-Width="35%" />
                                                    <asp:TemplateField ItemStyle-Width="20%">
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="lnkEdit" 
                                                                CssClass="btn btn-sm btn-outline-primary">
                                                                <b class="fa fa-check-circle"></b> Select
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-8">
                                    <div class="row m-2">
                                        <%-- Supplier --%>
                                        <div class="col-8">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilitySupplier" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                <label for="<%=txtUtilitySupplier.ClientID%>">Supplier</label>
                                            </div>
                                        </div>
                                        <%-- TIN --%>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilityTIN" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                <label for="<%=txtUtilityTIN.ClientID%>">TIN</label>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Receipt Number --%>
                                    <div class="row m-2">
                                        <div class="col-8">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilityReceipt" CssClass="form-control"
                                                    AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtUtilityReceipt.ClientID%>">Receipt Number</label>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <asp:DropDownList runat="server" ID="ddUtilityType" CssClass="form-select"></asp:DropDownList>
                                                <label for="<%=ddUtilityType.ClientID%>">Type</label>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Coverage --%>
                                    <div class="row m-2">
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilityFrom" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                <label for="<%=txtUtilityFrom.ClientID%>">From</label>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilityTo" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                <label for="<%=txtUtilityTo.ClientID%>">To</label>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Amount and VAT--%>
                                    <div class="row m-2">
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilityVATAmount" CssClass="form-control" 
                                                    TextMode="Number" onchange="CalculateUtilityTotal()" Text="0"></asp:TextBox>
                                                <label for="<%=txtUtilityVATAmount.ClientID%>">VATable</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilityNonVATAmount" CssClass="form-control"
                                                    TextMode="Number" onchange="CalculateUtilityTotal()" Text="0"></asp:TextBox>
                                                <label for="<%=txtUtilityNonVATAmount.ClientID%>">Non-VAT</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilityVAT" CssClass="form-control" 
                                                    TextMode="Number" onchange="CalculateUtilityTotal()" Text="0"></asp:TextBox>
                                                <label for="<%=txtUtilityVAT.ClientID%>">VAT</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtUtilityTotal" CssClass="form-control" 
                                                    TextMode="Number" onchange="CalculateUtilityVAT()" Text="0"></asp:TextBox>
                                                <label for="<%=txtUtilityTotal.ClientID%>">Total</label>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Submit Button --%>
                                    <div class="row m-2">
                                        <div class="col-2">
                                            <asp:LinkButton runat="server" ID="lnkUtilitySubmit" 
                                                CssClass="btn btn-outline-success" OnClick="lnkUtilitySubmit_Click">
                                                Submit
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <%-- Miscellaneous Pane --%>
                <div class="tab-pane fade" id="tab-misc">
                    <asp:UpdatePanel runat="server" ID="upMisc" UpdateMode="Conditional" ChildrenAsTriggers="false">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-4">
                                    <div class="card">
                                        <div class="card-header">
                                            <input type="text" id="misc-search-bar" placeholder="Search" 
                                                        class="form-control form-control-sm" role="search" />
                                        </div>
                                        <div class="card-body" style="height:550px;overflow-y:scroll">
                                            <asp:GridView runat="server" ID="gvMiscSupplierList" CssClass="table table-hover small" AutoGenerateColumns="false" 
                                                ShowHeader="true" GridLines="Horizontal">
                                                <Columns>
                                                    <asp:BoundField DataField="SupplierID" ItemStyle-Width="5%"/>
                                                    <asp:BoundField DataField="Supplier_Name" HeaderText="Name" ItemStyle-Width="40%"/>
                                                    <asp:BoundField DataField="TIN" HeaderText="TIN" ItemStyle-Width="35%" />
                                                    <asp:TemplateField ItemStyle-Width="20%">
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="lnkEdit" 
                                                                CssClass="btn btn-sm btn-outline-primary">
                                                                <b class="fa fa-check-circle"></b> Select
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-8">
                                    <div class="row m-2">
                                        <%-- Supplier --%>
                                        <div class="col-8">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtMiscSupplier" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=txtMiscSupplier.ClientID%>">Supplier</label>
                                            </div>
                                        </div>
                                        <%-- TIN --%>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtMiscTIN" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=txtMiscTIN.ClientID%>">TIN</label>
                                            </div>
                                        </div> 
                                    </div>
                                    <%-- PO Number and Receipt Number --%>
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
                                    <%-- Amount & VAT --%>
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
                                    <%-- Particulars --%>
                                    <div class="row m-2">
                                        <div class="col">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtMiscParticulars" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=txtMiscParticulars.ClientID%>">Particulars</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row m-2">
                                        <div class="col-2">
                                            <asp:LinkButton runat="server" ID="lnkMiscSubmit" CssClass="btn btn-outline-success" 
                                                OnClick="lnkMiscSubmit_Click">Submit</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <%--New Supplier Pane--%>
                <div class="tab-pane fade" id="tab-new-supplier">
                    <asp:UpdatePanel runat="server" ID="upNewSupplier" UpdateMode="Conditional" ChildrenAsTriggers="false">
                        <Triggers>
                        </Triggers>
                        <ContentTemplate>
                            <%-- Supplier Name --%>
                            <div class="row m-2">
                                <div class="col">
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                            AutoCompleteType="Disabled"></asp:TextBox>
                                        <label for="<%=txtSupplierName.ClientID%>">Name</label>
                                    </div>
                                </div>
                            </div>
                            <%-- Supplier Address --%>
                            <div class="row m-2">
                                <div class="col">
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                            AutoCompleteType="Disabled"></asp:TextBox>
                                        <label for="<%=txtSupplierAddress.ClientID%>">Address</label>
                                    </div>
                                </div>
                            </div>
                            <%-- Supplier TIN --%>
                            <div class="row m-2">
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
                            <%-- Save Button --%>
                            <div class="row m-2">
                                <div class="col-2">
                                    <asp:LinkButton runat="server" ID="lnkSupplierSave" CssClass="btn btn-outline-success" 
                                        OnClick="lnkSupplierSave_Click">Save</asp:LinkButton>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div> 
            </div>
        </div>
    </div>
    <%-- Success Toast --%>
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="success-toast" class="toast hide text-bg-success" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-body">
                <span id="toast-message"></span><button type="button" class="btn-close float-end" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <%-- Error Toast --%>
    <div class="position-fixed bottom-0 end-0 p-3 " style="z-index: 11">
        <div class="toast hide text-bg-danger border-0" id="error-toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-body">
                <span id="error-message"></span><button type="button" class="btn-close float-end" 
                    data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
</asp:Content>
