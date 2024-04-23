<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BranchExpenses.aspx.cs" Inherits="Book_Keeping_System.BranchExpenses" %>
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

        //Show toast
        //function ShowToast(msg) {
        //    document.getElementById('toast-message').textContent = msg;
        //    var toast = new bootstrap.Toast(document.getElementById('success-toast'));
        //    toast.show();
        //}

        //function ShowError(msg) {
        //    document.getElementById('error-message').textContent = msg;
        //    var toast = new bootstrap.Toast(document.getElementById('error-toast'));
        //    toast.show();
        //}

        //function EnableNavs() {
        //    var links = document.getElementById('form-pills').querySelectorAll('.nav-link');
        //    links.forEach(link => {
        //        link.classList.remove('disabled');
        //    });
        //}

        //window.onload = new function(){
        //    const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
        //    const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))

        //}

        <%--function CalculatePurchaseTotal() {
            var vatable = 0, nonvat = 0, vat = 0;
            if (document.getElementById('<%=txtPurchaseVATAmount.ClientID%>').value != null) {
                vatable = +Number.parseFloat(document.getElementById('<%=txtPurchaseVATAmount.ClientID%>').value).toFixed(2);
            }

            if (document.getElementById('<%=txtPurchaseNonVATAmount.ClientID%>').value != null) {
                nonvat = +Number.parseFloat(document.getElementById('<%=txtPurchaseNonVATAmount.ClientID%>').value).toFixed(2);
            }

            if (document.getElementById('<%=txtPurchaseVAT.ClientID%>').value != null) {
                vat = +Number.parseFloat(document.getElementById('<%=txtPurchaseVAT.ClientID%>').value).toFixed(2);
            }
            document.getElementById("<%=txtPurchaseTotal.ClientID%>").value = vatable + nonvat + vat;
        }

        function CalculateUtilityTotal() {
            var vatable = 0, nonvat = 0, vat = 0;
            if (document.getElementById('<%=txtUtilityVATAmount.ClientID%>').value != null) {
                vatable = +Number.parseFloat(document.getElementById('<%=txtUtilityVATAmount.ClientID%>').value).toFixed(2);
            }

            if (document.getElementById('<%=txtUtilityNonVATAmount.ClientID%>').value != null) {
                nonvat = +Number.parseFloat(document.getElementById('<%=txtUtilityNonVATAmount.ClientID%>').value).toFixed(2);
            }

            if (document.getElementById('<%=txtUtilityVAT.ClientID%>').value != null) {
                vat = +Number.parseFloat(document.getElementById('<%=txtUtilityVAT.ClientID%>').value).toFixed(2);
            }
            document.getElementById("<%=txtUtilityTotal.ClientID%>").value = vatable + nonvat + vat;
        }

        function CalculatePurchaseVAT() {
            var total = 0, vatable = 0;
            if (document.getElementById('<%=txtPurchaseTotal.ClientID%>').value != null) {
                total = +Number.parseFloat(document.getElementById('<%=txtPurchaseTotal.ClientID%>').value).toFixed(2);
                vatable = (total / 1.12).toFixed(2);
            }
            document.getElementById('<%=txtPurchaseVATAmount.ClientID%>').value = vatable;
            document.getElementById('<%=txtPurchaseVAT.ClientID%>').value = (total - vatable).toFixed(2);
        }

        function CalculateUtilityVAT() {
            var total = 0, vatable = 0;
            if (document.getElementById('<%=txtUtilityTotal.ClientID%>').value != null) {
                total = +Number.parseFloat(document.getElementById('<%=txtUtilityTotal.ClientID%>').value).toFixed(2);
                vatable = (total / 1.12).toFixed(2);
            }
            document.getElementById('<%=txtUtilityVATAmount.ClientID%>').value = vatable;
            document.getElementById('<%=txtUtilityVAT.ClientID%>').value = (total - vatable).toFixed(2);
        }--%>

        <%--function CalculateExpenses() {
            var charcoal = 0, foil = 0, fare = 0, grass = 0, lemon = 0, sili = 0, sauce = 0;
            var water = 0, meals = 0, fare = 0, packaging = 0, cleaning = 0, misc = 0, maint = 0;
            if (document.getElementById('<%=txtCharcoal.ClientID%>').value != null) {
               charcoal = document.getElementById('<%=txtCharcoal.ClientID%>').value;
           }
           if (document.getElementById('<%=txtFoil.ClientID%>').value != null) {
               foil = document.getElementById('<%=txtFoil.ClientID%>').value;
            }
            if (document.getElementById('<%=txtWater.ClientID%>').value != null) {
               water = document.getElementById('<%=txtWater.ClientID%>').value;
            }
            if (document.getElementById('<%=txtFare.ClientID%>').value != null) {
               fare = document.getElementById('<%=txtFare.ClientID%>').value;
            }
            if (document.getElementById('<%=txtLemongrass.ClientID%>').value != null) {
               grass = document.getElementById('<%=txtLemongrass.ClientID%>').value;
            }
            if (document.getElementById('<%=txtLemon.ClientID%>').value != null) {
               lemon = document.getElementById('<%=txtLemon.ClientID%>').value;
            }
            if (document.getElementById('<%=txtMeals.ClientID%>').value != null) {
               meals = document.getElementById('<%=txtMeals.ClientID%>').value;
            }
            if (document.getElementById('<%=txtSili.ClientID%>').value != null) {
               sili = document.getElementById('<%=txtSili.ClientID%>').value;
            }
            if (document.getElementById('<%=txtSauce.ClientID%>').value != null) {
               sauce = document.getElementById('<%=txtSauce.ClientID%>').value;
            }
            if (document.getElementById('<%=txtPackaging.ClientID%>').value != null) {
               packaging = document.getElementById('<%=txtPackaging.ClientID%>').value;
            }
            if (document.getElementById('<%=txtCleaning.ClientID%>').value != null) {
               cleaning = document.getElementById('<%=txtCleaning.ClientID%>').value;
            }
            if (document.getElementById('<%=txtMisc.ClientID%>').value != null) {
               misc = document.getElementById('<%=txtMisc.ClientID%>').value;
            }
            if (document.getElementById('<%=txtMaintenance.ClientID%>').value != null) {
               maint = document.getElementById('<%=txtMaintenance.ClientID%>').value;
            }
            document.getElementById('<%=txtSubtotal.ClientID%>').value = Number.parseInt(charcoal, 10) + Number.parseInt(foil, 10)
               + Number.parseInt(water, 10) + Number.parseInt(grass, 10) + Number.parseInt(lemon, 10)
               + Number.parseInt(sili, 10) + Number.parseInt(sauce, 10) + Number.parseInt(fare, 10) + Number.parseInt(meals, 10)
               + Number.parseInt(packaging, 10) + Number.parseInt(cleaning, 10) + Number.parseInt(misc, 10) + Number.parseInt(maint, 10);
       }--%>

        <%--function RetainSelectedTab() {
            if ($('#<%=hfMode.ClientID%>').val() === "util") {
                var trigger = bootstrap.Tab.getOrCreateInstance($('button[data-bs-target="#tab-utility"]'));
                trigger.show();
            }

            if ($('#<%=hfMode.ClientID%>').val() === "purchase") {
                var trigger = bootstrap.Tab.getOrCreateInstance($('button[data-bs-target="#tab-purchase"]'));
                trigger.show();
            }

            if ($('#<%=hfMode.ClientID%>').val() === "list") {
                var trigger = bootstrap.Tab.getOrCreateInstance($('button[data-bs-target="#tab-purchase-list"]'));
                trigger.show();
            }

            if ($('#<%=hfMode.ClientID%>').val() === "expenses") {
                var trigger = bootstrap.Tab.getOrCreateInstance($('button[data-bs-target="#tab-expenses"]'));
                trigger.show();
            }
        }--%>

        //function pageLoad() {
            ////Search function for Branch List
            //$('[id*=txtBranchSearch]').off().on("keyup", function () {
            //    var value = $(this).val().toLowerCase();
            //    $('[id*=gvBranchList] tr').filter(function () {
            //        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            //    });
            //});

            ////Search function for Supplier List
            //$('[id*=supplier-search]').off().on("keyup", function () {
            //    var value = $(this).val().toLowerCase();
            //    console.log(value);
            //    $('[id*=gvPurchaseSupplierList] tr').filter(function () {
            //        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            //    });
            //});

            <%--$('button[data-bs-target="#tab-utility"]').off().click(function (e) {
                e.preventDefault();
                var trigger = bootstrap.Tab.getOrCreateInstance($('button[data-bs-target="#tab-utility"]'));
                trigger.show();
                $('#<%=hfMode.ClientID%>').val("util");
            });

            $('button[data-bs-target="#tab-purchase"]').off().click(function (e) {
                e.preventDefault();
                var trigger = bootstrap.Tab.getOrCreateInstance($('button[data-bs-target="#tab-purchase"]'));
                trigger.show();
                $('#<%=hfMode.ClientID%>').val("purchase");
            });

            $('button[data-bs-target="#tab-purchase-list"]').off().click(function (e) {
                e.preventDefault();
                var trigger = bootstrap.Tab.getOrCreateInstance($('button[data-bs-target="#tab-purchase-list"]'));
                trigger.show();
                $('#<%=hfMode.ClientID%>').val("list");
            });

            $('button[data-bs-target="#tab-expenses"]').off().click(function (e) {
                e.preventDefault();
                var trigger = bootstrap.Tab.getOrCreateInstance($('button[data-bs-target="#tab-expenses"]'));
                trigger.show();
                $('#<%=hfMode.ClientID%>').val("expenses");
            });

            RetainSelectedTab();--%>
        //}
       function pageLoad() {
           //Search function for Branch List
           $('[id*=branch-search]').off().on("keyup", function () {
               var value = $(this).val().toLowerCase();
               $('[id*=gvBranchList] tr').filter(function () {
                   $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
               });
           });

           //Search function for Supplier List
           $('[id*=supplier-search]').off().on("keyup", function () {
               var value = $(this).val().toLowerCase();
               console.log(value);
               $('[id*=gvSupplierList] tr').filter(function () {
                   $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
               });
           });
       }

       // For Calendar Inputs
       <%--$(function setCalendarInput() {
           var dateToday = new Date();
           $('.calendarInput').datepicker({ maxDate: 0 });
       });


       $(function calculateVat() {

           //Getting all inputs in page
           var vatableAmount = document.getElementById("<%= txtUtilityVATAmount.ClientID %>");
            var vatAmount = document.getElementById("<%= txtUtilityVAT.ClientID %>");
            var totalAmount = document.getElementById("<%= txtUtilityTotal.ClientID %>");




            function calculateVatProcess() {



                //showVat.innerHTML = vatableAmount.toLocaleString("en-US");;
                var totalVat = parseFloat(vatableAmount.value) * .12;
                vatAmount.value = totalVat;
                totalAmount.value = parseFloat(vatableAmount.value) - totalVat;


            }

            //Events Input
            vatableAmount.addEventListener("input", calculateVatProcess);
            vatAmount.addEventListener("input", calculateVatProcess);
            totalAmount.addEventListener("input", calculateVatProcess);

        });

        //On UpdatePanel Refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {


                    //Search function
                    $(function searchInput() {

                        __doPostBack("<%=upPurchase.UniqueID%>", '');
                        $('[id*=txtBranchSearch]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            $('[id*=gvBranchList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });

                        $('[id*=supplier-search]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            console.log(value);
                            $('[id*=gvPurchaseSupplierList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });

                        });
                    });

                    // For Calendar Inputs
                    $(function setCalendarInput() {
                        var dateToday = new Date();
                        $('.calendarInput').datepicker({ maxDate: 0 });
                    });

                    $(function calculateVat() {

                        //Getting all inputs in page
                        var vatableAmount = document.getElementById("<%= txtUtilityVATAmount.ClientID %>");
                        var vatAmount = document.getElementById("<%= txtUtilityVAT.ClientID %>");
                        var totalAmount = document.getElementById("<%= txtUtilityTotal.ClientID %>");




                        function calculateVatProcess() {



                            //showVat.innerHTML = vatableAmount.toLocaleString("en-US");;
                            var totalVat = parseFloat(vatableAmount.value) * .12;
                            vatAmount.value = totalVat;
                            totalAmount.value = parseFloat(vatableAmount.value) - totalVat;


                        }

                        //Events Input
                        vatableAmount.addEventListener("input", calculateVatProcess);
                        vatAmount.addEventListener("input", calculateVatProcess);
                        totalAmount.addEventListener("input", calculateVatProcess);


                    });

                }
            });
        };--%>
    </script>

    <div class="container-fluid">
        <asp:UpdatePanel runat="server" ID="upForm" ChildrenAsTriggers="false" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row mt-3 mx-1">
                    <div class="col-4">
                        <div class="card" style="max-height:85vh;">
                            <div class="card-header">
                                <div class="row">
                                    <div class="input-group">
                                        <%-- Branch Search --%>
                                        <input type="text" id="branch-search" class="form-control" role="search" placeholder="Search branch" />
                                    </div>
                                </div>
                            </div>
                            <div class="card-body overflow-y-auto">
                                <%-- Branch List --%>
                                <asp:GridView runat="server" ID="gvBranchList" AutoGenerateColumns="false" CssClass="table table-responsive" 
                                    DataKeyNames="BranchID, BranchCode">
                                    <Columns>
                                        <%--<asp:BoundField DataField="BranchID" />
                                        <asp:BoundField DataField="BranchCode" />--%>
                                        <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-primary"
                                                    OnClick="lnkEdit_Click"><span class="fa fa-edit"></span></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <asp:HiddenField runat="server" ID="hiddenSelectedExpense" />
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-4">
                                        <div class="input-group">
                                            <%-- Selected Branch Controls --%>
                                            <asp:TextBox runat="server" ID="txtSelectedBranch" CssClass="form-control"
                                                ReadOnly="True" Text="No Branch Selected"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hiddenSelectedBranch" />
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#expense-modal">
                                                    <span class="fa fa-search"></span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-3 offset-5">
                                        <%-- Date Textbox --%>
                                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date" AutoCompleteType="Disabled"></asp:TextBox>
                                        <%-- Nav Pills --%>
                                        <%--<ul class="nav nav-pills nav-fill" id="form-pills" role="tablist">
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-purchase-list"
                                                    type="button" role="tab" aria-controls="tab-purchase-list" aria-selected="false">
                                                    Expenses / Purchase List</button>
                                            </li>

                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-utility"
                                                    type="button" role="tab" aria-controls="tab-sales" aria-selected="false">
                                                    Utility/Purchse Entry</button>
                                            </li>--%>
                                            <%--<li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-purchase" 
                                                    type="button" role="tab" aria-controls="tab-purchase" aria-selected="false">Purchase</button>
                                            </li>--%>

                                            <%--<li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-expenses"
                                                    type="button" role="tab" aria-controls="tab-expenses" aria-selected="false">
                                                    Expenses</button>
                                            </li>
                                        </ul>--%>
                                    </div>
                                    <%--<div class="col-3">
                                        Date 
                                        <asp:UpdatePanel runat="server" ID="upDate" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                            <Triggers>
                                            </Triggers>
                                            <ContentTemplate>
                                                <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>--%>
                                </div>
                            </div>
                            <div class="card-body">
                                <%--<div class="tab-pane fade" id="tab-utility">--%>
                            
                                            <%--<div class="row m-1">
                                                <div class="col-6">
                                                    <div class="form-floating">
                                                        <asp:DropDownList runat="server" ID="ddExpenseType" CssClass="dropdown form-control" AutoPostBack="true" OnSelectedIndexChanged="ddExpenseType_SelectedIndexChanged"></asp:DropDownList>
                                                        <label for="<%=ddExpenseType.ClientID%>">Select Expense Entry</label>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            <div class="row m-2">
                                                <%-- Supplier --%>
                                                <asp:HiddenField runat="server" ID="hiddenSelectedSupplier" />
                                                <div class="col-8">
                                                    <div class="input-group">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtSupplier" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                            <label for="<%=txtSupplier.ClientID%>">Supplier</label>
                                                        </div>
                                                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#supplier-modal">
                                                            <span class="fa fa-search"></span>
                                                        </button>
                                                    </div>
                                                    <%--<asp:Panel runat="server" ID="panelSupplierDropDown">


                                                        <div class="form-floating">
                                                            <asp:DropDownList runat="server" ID="ddUtilitySupplier" AutoPostBack="true"
                                                                CssClass="form-select" OnSelectedIndexChanged="ddUtilitySupplier_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                            <label for="<%=ddUtilitySupplier.ClientID%>">Supplier (Linked)</label>
                                                        </div>
                                                    </asp:Panel>
                                                    <asp:Panel runat="server" ID="panelSupplierNameText" Visible="false">
                                                        <div class="form-floating">

                                                            <asp:TextBox runat="server" ID="txtSupplierName1" CssClass="form-control"></asp:TextBox>
                                                            <label for="<%=txtSupplierName1.ClientID%>">Supplier</label>
                                                        </div>
                                                    </asp:Panel>--%>
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
                                            <%--<div class="row m-2">
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtAppliedDate" CssClass="form-control calendarInput"></asp:TextBox>
                                                        <label for="<%=txtAppliedDate.ClientID%>">Applied Date</label>
                                                    </div>
                                                </div>


                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityFrom" CssClass="form-control calendarInput"></asp:TextBox>
                                                        <label for="<%=txtUtilityFrom.ClientID%>">From</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityTo" CssClass="form-control calendarInput"></asp:TextBox>
                                                        <label for="<%=txtUtilityTo.ClientID%>">To</label>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            <%-- Amount & VAT --%>
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
                                                <%--<div class="col-6">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityParticulars" CssClass="form-control"
                                                            TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                        <label for="txtUtilityParticulars">Particulars</label>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityRemarks" CssClass="form-control"
                                                            TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                        <label for="txtUtilityParticulars">Remarks</label>
                                                    </div>
                                                </div>--%>
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
                                            <%-- Button --%>
                                            <%--<div class="row m-2">
                                                <div class="col-4">
                                                    <asp:LinkButton runat="server" ID="lnkRecordUtility" OnClick="lnkRecordUtility_Click" CssClass="btn btn-outline-success">Record</asp:LinkButton>
                                                    <asp:LinkButton runat="server" ID="lnkUtilityClear" OnClick="lnkUtilityClear_Click" CssClass="btn btn-outline-warning">Clear</asp:LinkButton>
                                                </div>
                                            </div>--%>
                                
                                <%--</div>--%>
                                <%-- Purchase Pane --%>
                                <%--<div class="tab-pane fade" id="tab-purchase">--%>
                                    <%--<asp:UpdatePanel runat="server" ID="upPurchase" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="lnkSupplierSave" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="lnkNewSupplier" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="lnkSupplierBack" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="lnkPurchaseClear" EventName="Click" />
                                        </Triggers>
                                        <ContentTemplate>--%>
                                            <%--<asp:Panel runat="server" ID="pPurchase" Visible="true">--%>
                                                <%-- Supplier --%>
                                                <%--<div class="row m-2">
                                                    <div class="col-8">
                                                        <div class="input-group">
                                                            <div class="form-floating">
                                                                <asp:TextBox runat="server" ID="txtPurchaseSupplier" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                <label for="<%=txtPurchaseSupplier.ClientID%>">Supplier</label>
                                                            </div>
                                                            <asp:LinkButton runat="server" ID="lnkNewSupplier"
                                                                CssClass="btn btn-primary d-flex align-items-center" OnClick="lnkNewSupplier_Click">
                                                                <b class="fa fa-search"></b>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                    <div class="col-4">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtPurchaseTIN" CssClass="form-control"></asp:TextBox>
                                                            <label for="<%=txtSupplierTIN.ClientID%>">TIN</label>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                <%-- Receipt Number --%>
                                                <%--<div class="row m-2">
                                                    <div class="col">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtPurchaseReceipt" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <label for="<%=txtPurchaseReceipt.ClientID%>">Receipt No.</label>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                <%-- Amount & VAT --%>
                                                <%--<div class="row m-2">
                                                    <div class="col-3">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtPurchaseVATAmount" CssClass="form-control"
                                                                TextMode="Number" Text="0" onchange="CalculatePurchaseTotal()"></asp:TextBox>
                                                            <label for="<%=txtPurchaseVATAmount.ClientID%>">VATable</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-3">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtPurchaseNonVATAmount" CssClass="form-control"
                                                                TextMode="Number" Text="0" onchange="CalculatePurchaseTotal()"></asp:TextBox>
                                                            <label for="<%=txtPurchaseNonVATAmount.ClientID%>">Non-VAT</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-3">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtPurchaseVAT" CssClass="form-control"
                                                                TextMode="Number" Text="0" onchange="CalculatePurchaseTotal()"></asp:TextBox>
                                                            <label for="<%=txtPurchaseVAT.ClientID%>">VAT</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-3">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtPurchaseTotal" CssClass="form-control"
                                                                TextMode="Number" Text="0" onchange="CalculatePurchaseVAT()"></asp:TextBox>
                                                            <label for="<%=txtPurchaseTotal.ClientID%>">Total</label>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                <%-- Particulars and Type --%>
                                                <%--<div class="row m-2">
                                                    <div class="col-8">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtPurchaseParticulars" CssClass="form-control"></asp:TextBox>
                                                            <label for="<%=txtPurchaseParticulars.ClientID%>">Particulars</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-4">
                                                        <div class="form-floating">
                                                            <asp:DropDownList runat="server" ID="txtPurchaseType" CssClass="form-select"></asp:DropDownList>
                                                            <label for="<%=txtPurchaseType.ClientID%>">Type</label>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                <%-- Button --%>
                                                <%--<div class="row m-2">
                                                    <div class="col-4">
                                                        <asp:LinkButton runat="server" ID="lnkRecordPurchase" CssClass="btn btn-outline-success">Record</asp:LinkButton>
                                                        <asp:LinkButton runat="server" ID="lnkPurchaseClear" CssClass="btn btn-outline-warning" OnClick="lnkPurchaseClear_Click">Clear</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </asp:Panel>--%>
                                            <%--<asp:Panel runat="server" ID="pSupplier">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <div class="row m-2">
                                                            <h6>New Supplier</h6>
                                                        </div>--%>
                                                        <%-- Supplier Name--%>
                                                        <%--<div class="row m-2">
                                                            <div class="col">
                                                                <div class="form-floating">
                                                                    <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control"
                                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                                    <label for="<%=txtSupplierName.ClientID%>">Name</label>
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <%-- Supplier Address --%>
                                                        <%--<div class="row m-2">
                                                            <div class="col">
                                                                <div class="form-floating">
                                                                    <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control"
                                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                                    <label for="<%=txtSupplierAddress.ClientID%>">Address</label>
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <%-- Supplier TIN --%>
                                                        <%--<div class="row m-2">
                                                            <div class="input-group">
                                                                <div class="form-floating">
                                                                    <asp:TextBox runat="server" ID="txtSupplierTIN" CssClass="form-control"
                                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                                    <label for="<%=txtSupplierTIN.ClientID%>">TIN</label>
                                                                </div>
                                                                <div class="input-group-text d-flex align-items-center">
                                                                    VAT
                                                                    <asp:CheckBox runat="server" ID="cbVAT" CssClass="form-check" />
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <%-- Supplier Type --%>
                                                        <%--<div class="row m-2">
                                                            <div class="col">
                                                                <div class="form-floating">
                                                                    <asp:DropDownList runat="server" ID="ddNewSupplierType" CssClass="form-select"></asp:DropDownList>
                                                                    <label for="<%=ddNewSupplierType.ClientID %>">Type</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row m-2">
                                                            <div class="col">
                                                                <asp:LinkButton runat="server" ID="lnkSupplierBack" CssClass="btn btn-outline-warning" OnClick="lnkSupplierBack_Click">Back</asp:LinkButton>
                                                                <asp:LinkButton runat="server" ID="lnkSupplierSave" CssClass="btn btn-outline-primary" OnClick="lnkSupplierSave_Click">Save</asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                    <%-- Supplier List --%>
                                                    <%--<div class="col-6">
                                                        <div class="card" style="padding-left: 0; padding-right: 0;">
                                                            <div class="card-header">
                                                                <div class="row">--%>
                                                                    <%-- Supplier Search Bar --%>
                                                                    <%--<div class="col-8">
                                                                        <input class="form-control" id="supplier-search" />
                                                                    </div>
                                                                    <div class="col-4">
                                                                        <asp:DropDownList runat="server" ID="ddSupplierType"
                                                                            CssClass="form-control">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="card-body" style="height: 300px; overflow-y: scroll;">
                                                                <asp:GridView runat="server" ID="gvPurchaseSupplierList" AutoGenerateColumns="false"
                                                                    CssClass="table table-responsive" OnRowDataBound="gvUtilitySupplierList_RowDataBound" OnRowCreated="gvUtilitySupplierList_RowDataBound">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="SupplierID" ItemStyle-Width="5%" />
                                                                        <asp:BoundField DataField="Supplier_Name" HeaderText="Name" ItemStyle-Width="40%" />
                                                                        <asp:BoundField DataField="TIN" HeaderText="TIN" ItemStyle-Width="35%" />
                                                                        <asp:TemplateField ItemStyle-Width="20%">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton runat="server" ID="lnkSupplierSelect"
                                                                                    CssClass="btn btn-sm btn-outline-primary" OnClick="lnkSupplierSelect_Click">
                                                                                    <b class="fa fa-check-circle"></b> Select
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>--%>
                                <%-- Purchase List Pane --%>
                                <%--<div class="tab-pane fade" id="tab-purchase-list">
                                    <asp:UpdatePanel runat="server" ID="upPurchaseList" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="row m-2">--%>
                                                <%-- Search Bar --%>
                                                <%--<div class="input-group">
                                                    <input class="form-control" id="search-bar" />
                                                    <button class="btn btn-primary">
                                                        <b class="fa fa-search"></b>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="row m-2">--%>
                                                <%-- List GridView --%>
                                                <%--<asp:GridView runat="server" ID="gvBranchExpensesRecordLists" AutoGenerateColumns="false"
                                                    CssClass="table table-responsive-md table-hover">
                                                    <Columns>
                                                        <asp:BoundField DataField="ExpenseRecordID" />
                                                        <asp:BoundField DataField="TransDateQuery" />
                                                        <asp:BoundField DataField="RcptNum" />
                                                        <asp:BoundField DataField="SupplierNameText" />
                                                        <asp:BoundField DataField="DateFrom" DataFormatString="{0:d}" />
                                                        <asp:BoundField DataField="DateTo" DataFormatString="{0:d}" />
                                                        <asp:BoundField DataField="Expenses_Desc" />
                                                        <asp:BoundField DataField="Particulars" />
                                                        <asp:BoundField DataField="TotalAmount" />
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:LinkButton runat="server" ID="lnkReviewExpense" CssClass="btn btn-primary btn-sm">
                                                                    <span class="fa fa-print"></span>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>

                                                </asp:GridView>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>--%>
                                <%-- Expenses Pane --%>
                                <%--<div class="tab-pane fade" id="tab-expenses">
                                    <asp:UpdatePanel runat="server" ID="upExpenses" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="lnkRecordExpenses" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <%-- Charcoal --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtCharcoal" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtCharcoal.ClientID%>">Charcoal</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Foil --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtFoil" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtFoil.ClientID%>">Foil</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Water --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtWater" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtWater.ClientID%>">Water</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">--%>
                                                    <%-- Fare --%>
                                                   <%-- <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtFare" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtFare.ClientID%>">Fare</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Meals --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMeals" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtMeals.ClientID%>">Meals</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Lemongrass --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtLemongrass" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtLemongrass.ClientID%>">Lemongrass</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">--%>
                                                    <%-- Lemon --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtLemon" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtLemon.ClientID%>">Lemon</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Sili --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSili" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtSili.ClientID%>">Sili</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Sauce --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSauce" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtSauce.ClientID%>">Sauce</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">--%>
                                                    <%-- Packaging --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtPackaging" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtPackaging.ClientID%>">Packaging</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Cleaning Tools --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtCleaning" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtCleaning.ClientID%>">Cleaning</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Miscellaneous --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMisc" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtMisc.ClientID%>">Misc.</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">--%>
                                                    <%-- Maintenance --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMaintenance" CssClass="form-control"
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtMaintenance.ClientID%>">Maintenance</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Subtotal --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSubtotal" CssClass="form-control"
                                                            TextMode="Number" ReadOnly="true" Text="0"></asp:TextBox>
                                                        <label for="<%=txtSubtotal.ClientID%>">Subtotal</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">--%>
                                                    <%-- Notes --%>
                                                    <%--<div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtNotes" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtNotes.ClientID%>">Notes</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-2">--%>
                                                    <%-- Record Expenses Button --%>
                                                    <%--<asp:LinkButton runat="server" ID="lnkRecordExpenses" CssClass="btn btn-outline-success"
                                                        OnClick="lnkRecordExpenses_Click">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddType" EventName="SelectedIndexChanged" />
                <asp:PostBackTrigger ControlID="lnkSubmit" />
                <asp:AsyncPostBackTrigger ControlID="lnkClear" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="cbIsCheque" EventName="CheckedChanged" />
            </Triggers>
        </asp:UpdatePanel>
        <button type="button" class="btn btn-success position-absolute bottom-0 end-0 m-5" 
            data-bs-toggle="modal" data-bs-target="#new-supplier-modal">
            New Supplier <span class="fa fa-plus-circle"></span>
        </button>
        <%-- Supplier List Modal --%>
        <div class="modal fade" tabindex="-1" id="supplier-modal">
            <div class="modal-dialog">
                <div class="modal-content" style="max-height:85vh;">
                    <div class="modal-header">
                        <%-- Search Textbox --%>
                        <input type="text" id="supplier-search" placeholder="Search Supplier" 
                            class="form-control" role="search" autocomplete="off" />
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
        <%-- Branch Expense List --%>
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
        <%-- Success Toast --%>
        <%--<div class="position-fixed bottom-0 end-0 p-3 " style="z-index: 11">
            <div class="toast text-bg-success" id="success-toast" role="status" aria-live="polite" aria-atomic="true" data-bs-delay="3000">
                <div class="toast-body">
                    <span id="toast-message"></span>
                    <button type="button" class="btn-close float-end" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>--%>
        <%-- Error Toast --%>
        <%--<div class="position-fixed bottom-0 end-0 p-3 " style="z-index: 11">
            <div class="toast hide text-bg-danger border-0" id="error-toast" role="status" aria-live="polite" aria-atomic="true" data-bs-delay="3000">
                <div class="toast-body">
                    <span id="error-message"></span>
                    <button type="button" class="btn-close float-end"
                        data-bs-dismiss="toast" aria-label="Close">
                    </button>
                </div>
            </div>
        </div>--%>
    </div>
</asp:Content>
