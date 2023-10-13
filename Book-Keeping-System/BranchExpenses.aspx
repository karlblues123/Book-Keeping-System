<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BranchExpenses.aspx.cs" Inherits="Book_Keeping_System.BranchExpenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">

        //Show toast
        function ShowToast(msg) {
            document.getElementById('toast-message').textContent = msg;
            var toast = new bootstrap.Toast(document.getElementById('success-toast'));
            toast.show();
        }

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

        window.onload = new function(){
            const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
            const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))

        }

        function CalculatePurchaseTotal() {
            var vatable = 0, nonvat = 0, vat = 0;
            if (document.getElementById('<%=txtPurchaseVATAmount.ClientID%>').value != null) {
                vatable = + Number.parseFloat(document.getElementById('<%=txtPurchaseVATAmount.ClientID%>').value).toFixed(2);
            }
                
            if (document.getElementById('<%=txtPurchaseNonVATAmount.ClientID%>').value != null) {
                nonvat = + Number.parseFloat(document.getElementById('<%=txtPurchaseNonVATAmount.ClientID%>').value).toFixed(2);
            }
                
            if (document.getElementById('<%=txtPurchaseVAT.ClientID%>').value != null) {
                vat = + Number.parseFloat(document.getElementById('<%=txtPurchaseVAT.ClientID%>').value).toFixed(2);
            }
            document.getElementById("<%=txtPurchaseTotal.ClientID%>").value = vatable + nonvat + vat;
        }

        function CalculateExpenses() {
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
                + Number.parseInt(packaging, 10) + Number.parseInt(cleaning, 10) + Number.parseInt(misc, 10) + Number.parseInt(maint,10);
        }

        //Search function
        $(function searchInput() {
            $('[id*=txtBranchSearch]').on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvBranchList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });


        $(function calculateVat() {

            //Getting all inputs in page
            var vatableAmount = document.getElementById("<%= txtUtilityVATAmount.ClientID %>");
            var vatAmount = document.getElementById("<%= txtUtilityVAT.ClientID %>");
            var totalAmount = document.getElementById("<%= txtUtilityTotal.ClientID %>");

            var valVatableAmount = parseFloat(vatableAmount);
            var valVatAmount = parseFloat(valVatableAmount * .12);
            var valTotalAmount = parseFloat(valVatableAmount - valVatAmount);




        })

        //On UpdatePanel Refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {


                    //Search function
                    $(function searchInput() {
                        $('[id*=txtBranchSearch]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            $('[id*=gvBranchList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });

                }
            });
        };
    </script>
    <div class="container-fluid" style="padding-left:0;padding-right:0;">
        <%-- Main Card --%>
        <div class="card" style="border:0;">
            <%-- Main Card Header --%>
            <div class="card-header bg-warning bg-opacity-25">
                Branch - Expenses
            </div>
            <%-- Main Card Body --%>
            <div class="card-body">
                <div class="row">
                    <div class="col-4">
                        <%-- Branch Card --%>
                        <div class="card">
                            <%-- Branch Search --%>
                            <div class="card-header">
                                <div class="row">
                                    <div class="input-group">
                                        <span class="input-group-text"><b class="fa fa-building"></b></span>
                                        <asp:TextBox runat="server" ID="txtBranchSearch" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%-- Branch List --%>
                            <div class="card-body" style="max-height:550px;overflow-y:scroll;">
                                <asp:Panel runat="server" ID="panelGridViewLists">
                                    <asp:GridView runat="server" ID="gvBranchList" GridLines="Horizontal" AutoGenerateColumns="false" CssClass="table table-responsive small">
                                        <Columns>
                                            <asp:BoundField DataField="BranchID" />
                                            <asp:BoundField DataField="BranchCode" />
                                            <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                   <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-outline-primary btn-sm" 
                                                       OnClick="lnkEdit_Click"><b class="fa fa-pencil"></b> Select</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <%-- Form --%>
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-3">
                                        <asp:TextBox runat="server" ID="txtSelectedBranch" CssClass="form-control"
                                            ReadOnly="True" Text="No Selected Branch"></asp:TextBox>
                                    </div>
                                    <div class="col-6">
                                        <%-- Nav Pills --%>
                                        <ul class="nav nav-pills" id="form-pills" role="tablist">
                                            <li class="nav-item">
                                                <button class="nav-link disabled" data-bs-toggle="pill" data-bs-target="#tab-utility" 
                                                    type="button" role="tab" aria-controls="tab-sales" aria-selected="false">Utility</button>
                                            </li>
                                            <li class="nav-item">
                                                <button class="nav-link disabled" data-bs-toggle="pill" data-bs-target="#tab-purchase" 
                                                    type="button" role="tab" aria-controls="tab-purchase" aria-selected="false">Purchase</button>
                                            </li>
                                            <li class="nav-item">
                                                <button class="nav-link disabled" data-bs-toggle="pill" data-bs-target="#tab-purchase-list" 
                                                    type="button" role="tab" aria-controls="tab-purchase-list" aria-selected="false">Purchase List</button>
                                            </li>
                                            <li class="nav-item">
                                                <button class="nav-link disabled" data-bs-toggle="pill" data-bs-target="#tab-expenses" 
                                                    type="button" role="tab" aria-controls="tab-expenses" aria-selected="false">Expenses</button>
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
                            <div class="card-body tab-content">
                                <%-- Sales Pane --%>
                                <div class="tab-pane fade" id="tab-utility">
                                    <asp:UpdatePanel runat="server" ID="upUtility" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <%-- Branch Name --%>
                                            <div class="row m-2">
                                                <div class="col-8">
                                                    <div class="form-floating">
                                                        <asp:DropDownList runat="server" ID="ddUtilitySupplier" AutoPostBack="true"
                                                            CssClass="form-select" OnSelectedIndexChanged="ddUtilitySupplier_SelectedIndexChanged"></asp:DropDownList>
                                                        <label for="<%=ddUtilitySupplier.ClientID%>">Supplier</label>
                                                    </div>
                                                    
                                                </div>
                                                  <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityTIN" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                        <label for="<%=txtUtilityTIN.ClientID%>">TIN</label>
                                                    </div>
                                                </div>

                                            </div>
                                            <%-- TIN 
                                            <div class="row m-2">
                                              
                                            </div>--%>
                                            <%-- Receipt Number --%>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityReceipt" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtUtilityReceipt.ClientID%>">Receipt Number</label>
                                                    </div>
                                                </div>

                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityFrom" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                        <label for="<%=txtUtilityFrom.ClientID%>">From</label>
                                                    </div>
                                                </div>
                                                 <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityTo" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                        <label for="<%=txtUtilityTo.ClientID%>">To</label>
                                                    </div>
                                                </div>
                                               
                                                
                                            </div>
                                            <%-- Amount & VAT --%>
                                            <div class="row m-2">
                                                <div class="col-3">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityVATAmount" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtUtilityVATAmount.ClientID%>">VATable</label>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityNonVATAmount" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtUtilityNonVATAmount.ClientID%>">NonVAT</label>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityVAT" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtUtilityVAT.ClientID%>">VAT</label>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtUtilityTotal" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtUtilityTotal.ClientID%>">Total</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Coverage and Type --%>
                                            <div class="row m-2">
                                                
                                               
                                            </div>
                                            <%-- Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkRecordUtility" OnClick="lnkRecordUtility_Click" CssClass="btn btn-outline-success">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Purchase Pane --%>
                                <div class="tab-pane fade" id="tab-purchase">
                                    <asp:UpdatePanel runat="server" ID="upPurchase" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="lnkSupplierSave" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="lnkNewSupplier" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="lnkSupplierBack" EventName="Click" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <asp:Panel runat="server" ID="pPurchase" Visible="true">
                                                <%-- Supplier --%>
                                                <div class="row m-2">
                                                    <div class="input-group">
                                                        <div class="form-floating">
                                                            <asp:DropDownList runat="server" ID="ddPurchaseSupplier" CssClass="form-select"></asp:DropDownList>
                                                            <label for="<%=ddPurchaseSupplier.ClientID%>">Supplier</label>
                                                        </div>
                                                        <asp:LinkButton runat="server" ID="lnkNewSupplier" 
                                                            CssClass="btn btn-primary d-flex align-items-center" OnClick="lnkNewSupplier_Click">
                                                            <b class="fa fa-plus-circle"></b>
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                                <%-- TIN --%>
                                                <div class="row m-2">
                                                    <div class="col">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtSupplierTIN" CssClass="form-control"></asp:TextBox>
                                                            <label for="<%=txtSupplierTIN.ClientID%>">TIN</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%-- Receipt Number --%>
                                                <div class="row m-2">
                                                    <div class="col">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtPurchaseReceipt" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <label for="<%=txtPurchaseReceipt.ClientID%>">Receipt No.</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%-- Amount & VAT --%>
                                                <div class="row m-2">
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
                                                                TextMode="Number" Text="0" onchange="CalculatePurchaseTotal()"></asp:TextBox>
                                                            <label for="<%=txtPurchaseTotal.ClientID%>">Total</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%-- Particulars and Type --%>
                                                <div class="row m-2">
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
                                               </div>
                                                <%-- Button --%>
                                                <div class="row m-2">
                                                    <div class="col-2">
                                                        <asp:LinkButton runat="server" ID="lnkRecordPurchase" CssClass="btn btn-outline-success">Record</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <asp:Panel runat="server" ID="pSupplier" Visible="false">
                                                <div class="row m-2">
                                                    <h6>New Supplier</h6>
                                                </div>
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
                                                            <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control" 
                                                                AutoCompleteType="Disabled"></asp:TextBox>
                                                            <label for="<%=txtSupplierTIN.ClientID%>">TIN</label>
                                                        </div>
                                                        <div class="input-group-text d-flex align-items-center">
                                                            VAT
                                                            <asp:CheckBox runat="server" ID="cbVAT" CssClass="form-check"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row m-2">
                                                    <div class="col-1">
                                                        <asp:LinkButton runat="server" ID="lnkSupplierBack" CssClass="btn btn-outline-warning" OnClick="lnkSupplierBack_Click">Back</asp:LinkButton>
                                                    </div>
                                                    <div class="col-1">
                                                        <asp:LinkButton runat="server" ID="lnkSupplierSave" CssClass="btn btn-outline-primary" OnClick="lnkSupplierSave_Click">Save</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Purchase List Pane --%>
                                <div class="tab-pane fade" id="tab-purchase-list">
                                    <asp:UpdatePanel runat="server" ID="upPurchaseList" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="row m-2">
                                                <%-- Search Bar --%>
                                                <div class="input-group">
                                                    <input class="form-control" id="search-bar" />
                                                    <button class="btn btn-primary">
                                                        <b class="fa fa-search"></b>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <%-- List GridView --%>
                                                <asp:GridView runat="server" ID="gvPurchaseList" AutoGenerateColumns="false" 
                                                    CssClass="table"></asp:GridView>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Expenses Pane --%>
                                <div class="tab-pane fade" id="tab-expenses">
                                    <asp:UpdatePanel runat="server" ID="upExpenses" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="lnkRecordExpenses" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <%-- Charcoal --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtCharcoal" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtCharcoal.ClientID%>">Charcoal</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Foil --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtFoil" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtFoil.ClientID%>">Foil</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Water --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtWater" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtWater.ClientID%>">Water</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <%-- Fare --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtFare" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtFare.ClientID%>">Fare</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Meals --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMeals" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtMeals.ClientID%>">Meals</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Lemongrass --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtLemongrass" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtLemongrass.ClientID%>">Lemongrass</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <%-- Lemon --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtLemon" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtLemon.ClientID%>">Lemon</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Sili --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSili" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtSili.ClientID%>">Sili</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Sauce --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSauce" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtSauce.ClientID%>">Sauce</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <%-- Packaging --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtPackaging" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtPackaging.ClientID%>">Packaging</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Cleaning Tools --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtCleaning" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtCleaning.ClientID%>">Cleaning</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Miscellaneous --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMisc" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtMisc.ClientID%>">Misc.</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <%-- Maintenance --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtMaintenance" CssClass="form-control" 
                                                            TextMode="Number" onchange="CalculateExpenses()" Text="0"></asp:TextBox>
                                                        <label for="<%=txtMaintenance.ClientID%>">Maintenance</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Subtotal --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSubtotal" CssClass="form-control" 
                                                            TextMode="Number" ReadOnly="true" Text="0"></asp:TextBox>
                                                        <label for="<%=txtSubtotal.ClientID%>">Subtotal</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Notes --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtNotes" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtNotes.ClientID%>">Notes</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <%-- Record Expenses Button --%>
                                                    <asp:LinkButton runat="server" ID="lnkRecordExpenses" CssClass="btn btn-outline-success" 
                                                        OnClick="lnkRecordExpenses_Click">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

         
        </div>
        <%-- Success Toast --%>
        <div class="position-fixed bottom-0 end-0 p-3 " style="z-index: 11">
            <div class="toast text-bg-success" id="success-toast" role="alert" aria-live="assertive" aria-atomic="true">
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
    </div>
</asp:Content>
