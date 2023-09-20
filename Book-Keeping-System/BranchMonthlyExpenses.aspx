<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BranchMonthlyExpenses.aspx.cs" Inherits="Book_Keeping_System.BranchMonthlyExpenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
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
    </script>
    <div class="container-fluid">
        <%-- Main Card --%>
        <div class="card m-2">
            <%-- Main Card Header --%>
            <div class="card-header">
                Branch - Monthly Expenses
            </div>
            <%-- Main Card Body --%>
            <div class="card-body">
                <div class="row">
                    <div class="col-4">
                        <%-- Branch Card --%>
                        <div class="card">
                            <%-- Branch Dropdown --%>
                            <div class="card-header">
                                <div class="row m-2">
                                    <div class="input-group">
                                        <span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg></span>
                                        <asp:TextBox runat="server" ID="txtBranchSearch" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%-- Branch Select Button --%>
                            <div class="card-body">
                                <asp:GridView runat="server" ID="gvBranchList" AutoGenerateColumns="false" CssClass="table">
                                    <Columns>
                                        <asp:BoundField DataField="BranchCode" />
                                        <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-primary">Edit</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <%-- Form Card --%>
                        <div class="card">
                            <%-- Form Card Header --%>
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-7">
                                        <ul class="nav nav-pills" id="form-pills" role="tablist">
                                            <%-- Electricity Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-electricity" 
                                                    type="button" role="tab" aria-controls="tab-electricity" aria-selected="false">Electricity</button>
                                            </li>
                                            <%-- Water Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-water" 
                                                    type="button" role="tab" aria-controls="tab-water" aria-selected="false">Water</button>
                                            </li>
                                            <%-- Rental Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-rental" 
                                                    type="button" role="tab" aria-controls="tab-rental" aria-selected="false">Rental</button>
                                            </li>
                                            <%-- Misc. Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-misc" 
                                                    type="button" role="tab" aria-controls="tab-miscs" aria-selected="false">Misc.</button>
                                            </li>
                                            <%-- New Supplier Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-new-supplier" 
                                                    type="button" role="tab" aria-controls="tab-new-supplier" aria-selected="false">New Supplier</button>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-5">
                                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%-- Form Card Body --%>
                            <div class="card-body tab-content">
                                <%-- Electricity Bill Form --%>
                                <div class="tab-pane fade" id="tab-electricity" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upElectricity" UpdateMode="Conditional" 
                                        ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <%-- Supplier --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Supplier</span>
                                                    <asp:DropDownList runat="server" ID="ddElecSupplier" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <%-- TIN --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">TIN</span>
                                                    <asp:TextBox runat="server" ID="txtElecTIN" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Receipt Number --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Receipt No.</span>
                                                    <asp:TextBox runat="server" ID="txtElecReceipt" CssClass="form-control"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Coverage --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">From</span>
                                                    <asp:TextBox runat="server" ID="txtElecFrom" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                    <span class="input-group-text">To</span>
                                                    <asp:TextBox runat="server" ID="txtElecTo" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Amount and VAT--%>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VATable</span>
                                                        <asp:TextBox runat="server" ID="txtElectricVATAmount" 
                                                            CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Non-VAT</span>
                                                        <asp:TextBox runat="server" ID="txtElectricNonVATAmount"
                                                            CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VAT</span>
                                                        <asp:TextBox runat="server" ID="txtElectricVAT" 
                                                            CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Record Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkElectricRecord" 
                                                        CssClass="btn btn-success" OnClick="Show_Toast">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Water Bill Form --%>
                                <div class="tab-pane fade" id="tab-water" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upWater" UpdateMode="Conditional" 
                                        ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <%-- Supplier --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Supplier</span>
                                                    <asp:DropDownList runat="server" ID="ddWaterSupplier" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <%-- TIN --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">TIN</span>
                                                    <asp:TextBox runat="server" ID="txtWaterTIN" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Receipt Number --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Receipt No.</span>
                                                    <asp:TextBox runat="server" ID="txtWaterReceipt" CssClass="form-control"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Coverage --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">From</span>
                                                    <asp:TextBox runat="server" ID="txtWaterFrom" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                    <span class="input-group-text">To</span>
                                                    <asp:TextBox runat="server" ID="txtWaterTo" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Amount and VAT --%>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VATable</span>
                                                        <asp:TextBox runat="server" ID="txtWaterVATAmount" CssClass="form-control" 
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Non-VAT</span>
                                                        <asp:TextBox runat="server" ID="txtWarerNonVATAmount"
                                                            CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VAT</span>
                                                        <asp:TextBox runat="server" ID="txtWaterVAT" CssClass="form-control" 
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Record Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkWaterRecord" CssClass="btn btn-success" 
                                                        OnClick="Show_Toast">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Rental Form --%>
                                <div class="tab-pane fade" id="tab-rental" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upRental" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Rental</span>
                                                    <asp:TextBox runat="server" ID="txtRental" CssClass="form-control" 
                                                        TextMode="Number"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-6">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Check Number</span>
                                                        <asp:TextBox runat="server" ID="txtRentalCheck" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Check Amount</span>
                                                        <asp:TextBox runat="server" ID="txtCheckAmount" CssClass="form-control" 
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Record Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkRentalRecord" CssClass="btn btn-success" 
                                                        OnClick="Show_Toast">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Misc Form --%>
                                <div class="tab-pane fade" id="tab-misc" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upMisc" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Amount</span>
                                                    <asp:TextBox runat="server" ID="txtMiscAmount" CssClass="form-control" 
                                                        TextMode="Number"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Label</span>
                                                    <asp:TextBox runat="server" ID="txtMiscLabel" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Record Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkMiscRecord" CssClass="btn btn-success" 
                                                        OnClick="Show_Toast">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- New Supplier Form --%>
                                <div class="tab-pane fade" id="tab-new-supplier" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upNewSupplier" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <Triggers></Triggers>
                                        <ContentTemplate>
                                            <%-- Supplier Name --%>
                                            <div class="input-group m-2">
                                                <span class="input-group-text">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-2"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path></svg>
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
                                            <div class="input-group m-2">
                                                <asp:LinkButton runat="server" ID="lnkSupplierSave" CssClass="btn btn-primary">Save</asp:LinkButton>
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
            <div id="success-toast" class="toast hide text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-body">
                  <span id="toast-message"></span><button type="button" class="btn-close float-end" 
                      data-bs-dismiss="toast" aria-label="Close"></button>
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
