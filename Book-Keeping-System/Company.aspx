<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="Book_Keeping_System.Company" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <asp:Panel runat="server" ID="pList" CssClass="card mt-3" style="max-height:85vh;">
            <%-- Main Header --%>
            <div class="card-header">
                <div class="row d-flex align-items-center">
                    <div class="col-4">
                        <input type="text" class="form-control" id="company-search" role="search" placeholder="Search" autocomplete="off"/>  
                    </div>
                </div>
            </div>
            <%-- Body --%>
            <div class="card-body overflow-y-auto">
                <%-- GridView List --%>
                <asp:GridView runat="server" ID="gvCompanyList" AutoGenerateColumns="false" CssClass="table" DataKeyNames="CompanyCode">
                    <Columns>
                        <asp:BoundField DataField="Company_Name" HeaderText="Name" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="lnkView" CssClass="btn btn-primary" OnClick="lnkView_Click">
                                    <span class="fa fa-search"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div> 
        </asp:Panel>
        <asp:Panel runat="server" ID="pDetails" Visible="false" style="max-height:85vh;">
            <div class="row mt-2">
                <aside class="col-auto col-md-1 col-xl-1">
                    <div class="d-flex flex-column align-items-center">
                        <%-- Back Button --%>
                        <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn my-1" 
                            OnClick="lnkBack_Click"><span class="fa fa-arrow-left"></span></asp:LinkButton>
                        <%-- Tabs --%>
                        <ul class="nav nav-pills" id="form-pills" role="tablist">
                            <%-- Basic Tab --%>
                            <li class="nav-item my-1" role="presentation">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-basic"
                                    type="button" role="tab" aria-controls="tab-basic" aria-selected="true">
                                    <span class="fa fa-info-circle"></span> <span class="d-none d-xxl-inline">Basic</span>
                                </button>
                            </li>
                            <%-- Expense Tab --%>
                            <li class="nav-item my-1" role="presentation">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-expense"
                                    type="button" role="tab" aria-controls="tab-expense" aria-selected="false">
                                    <span class="fa fa-list-alt"></span> <span class="d-none d-xxl-inline">Expense</span>
                                </button>
                            </li>
                        </ul>
                    </div>
                </aside>
                <main class="col tab-content">
                    <%-- Basic Pane--%>
                    <div class="tab-pane fade show active" id="tab-basic">
                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-floating">
                                    <asp:TextBox runat="server" ID="txtCompanyName" CssClass="form-control"></asp:TextBox>
                                    <label for="<%=txtCompanyName.ClientID%>">Name</label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating">
                                    <asp:TextBox runat="server" ID="txtCompanyTIN" CssClass="form-control"></asp:TextBox>
                                    <label for="<%=txtCompanyTIN.ClientID%>">TIN</label>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-floating">
                                    <asp:TextBox runat="server" ID="txtCompanyAddress" CssClass="form-control"></asp:TextBox>
                                    <label for="<%=txtCompanyAddress.ClientID%>">Address</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Company Expenses Pane--%>
                    <div class="tab-pane fade" id="tab-expense">
                        <asp:UpdatePanel runat="server" ID="upExpense" ChildrenAsTriggers="false" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="row my-2">
                                    <div class="col-4">
                                        <%-- Search Textbox --%>
                                        <input type="text" id="expense-search" class="form-control" autocomplete="off" placeholder="Search" />
                                    </div>
                                    <div class="col-2">
                                        <%-- Month Filter Dropdown --%>
                                        <asp:DropDownList runat="server" ID="ddMonthFilter" CssClass="form-select h-100" 
                                            OnSelectedIndexChanged="ddMonthFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <div class="col-2">
                                        <%-- Year Filter Dropdown --%>
                                        <asp:DropDownList runat="server" ID="ddYearFilter" CssClass="form-select h-100" 
                                            OnSelectedIndexChanged="ddYearFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row my-2">
                                    <div class="col">
                                        <%-- Expenses List --%>
                                        <asp:HiddenField runat="server" ID="hiddenSelectedCompany" />
                                        <asp:GridView runat="server" ID="gvCompanyExpenses" CssClass="table table-responsive" AutoGenerateColumns="false"
                                            DataKeys="ID" EmptyDataText="No Expenses found." EmptyDataRowStyle-CssClass="text-center">
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
                                <asp:AsyncPostBackTrigger ControlID="ddMonthFilter" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddYearFilter" EventName="SelectedIndexChanged" />
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
                                            <%-- PO Number --%>
                                            <asp:TextBox runat="server" ID="txtPO" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtPO.ClientID%>">PO Number</label>
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
                                            <%-- Cheque Number --%>
                                            <asp:TextBox runat="server" ID="txtCheque" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            <label for="<%=txtCheque.ClientID%>">Cheque Number</label>
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
    </div>
    <script>
        //Search function
        function pageLoad() {
            $('[id*=company-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvCompanyList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            $('[id*=expense-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvCompanyExpenses] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

        }

        function setSelectedExpense(expense) {
            $('#<%=hiddenSelectedExpense.ClientID%>').val(expense);
            bootstrap.Modal.getOrCreateInstance($('#details-modal')).toggle();
            __doPostBack('<%=upExpense.ClientID%>', '');
        }
    </script> 
</asp:Content>
