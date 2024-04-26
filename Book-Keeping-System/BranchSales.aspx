<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BranchSales.aspx.cs" Inherits="Book_Keeping_System.BranchSales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        //function ShowToast(msg) {
        //    document.getElementById('toast-message').textContent = msg;
        //    var toast = new bootstrap.Toast(document.getElementById('success-toast'));
        //    toast.show();
        //};

        //function ShowError(msg) {
        //    document.getElementById('error-message').textContent = msg;
        //    var toast = new bootstrap.Toast(document.getElementById('error-toast'));
        //    toast.show();
        //}

        function pageLoad() {
            //Search function
            $(function searchInput() {
                $('[id*=search-bar]').off().on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $('[id*=gvBranchList] tr').filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
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
        //                    $('[id*=gvBranchList] tr').filter(function () {
        //                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        //                    });
        //                });
        //            });

        //        }
        //    });
        //}

        //Client-side calculate the sales of chicken
        function CalculateChickenSales() {
            var qty = 0, sales = 0;
            if (document.getElementById('<%=txtChickenQuantity.ClientID%>').value != null) {
                qty = document.getElementById('<%=txtChickenQuantity.ClientID%>').value;
            }
            if (document.getElementById('<%=txtChickenPrice.ClientID%>').value != null) {
                sales = document.getElementById('<%=txtChickenPrice.ClientID%>').value;
            }
            document.getElementById('<%=txtChickenTotal.ClientID%>').value = qty * sales;
        }

        //Client-side calculate the sales of atsara
        function CalculateAtsaraSales() {
            var qty = 0, sales = 0;
            if (document.getElementById('<%=txtAtsaraQuantity.ClientID%>').value != null) {
                qty = document.getElementById('<%=txtAtsaraQuantity.ClientID%>').value;
            }
            if (document.getElementById('<%=txtAtsaraPrice.ClientID%>').value != null) {
                sales = document.getElementById('<%=txtAtsaraPrice.ClientID%>').value;
            }
            document.getElementById('<%=txtAtsaraTotal.ClientID%>').value = qty * sales;
        }
    </script>
    <div class="container-fluid">
        <div class="m-2 h6">Branch Sales</div>
        <div class="row">
            <div class="col-4">
                <%-- Branch Card --%>
                <div class="card" style="max-height:85vh;">
                    <%-- Branch Dropdown --%>
                    <div class="card-header">
                        <div class="row">
                            <div class="input-group">
                                <%-- Search Textbox --%>
                                <input type="text" id="search-bar" placeholder="Search Branch" class="form-control" role="search" 
                                    autocomplete="off" />
                            </div>
                        </div>
                    </div>
                    <div class="card-body overflow-y-auto">
                        <asp:GridView runat="server" ID="gvBranchList" AutoGenerateColumns="false" CssClass="table table-responsive" 
                            DataKeyNames="BranchCode">
                            <Columns>
                                <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-primary" 
                                            OnClick="lnkEdit_Click" TabIndex="-1">
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
                <%-- Form Card --%>
                <div class="card" style="max-height:85vh;">
                    <asp:UpdatePanel runat="server" ID="upSales" ChildrenAsTriggers="false" UpdateMode="Conditional">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="lnkSaveSales" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="txtDate" EventName="TextChanged" />
                        </Triggers>
                        <ContentTemplate>
                        <%-- Form Card Header --%>
                        <div class="card-header">
                            <div class="row">
                                <div class="col-3">
                                    <asp:TextBox runat="server" ID="txtSelectedBranch" CssClass="form-control" ReadOnly="true" 
                                        placeholder="No Branch Selected" TabIndex="-1"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hiddenSelectedBranch" />
                                </div>
                                <div class="col-3 offset-6">
                                    <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date" 
                                        OnTextChanged="txtDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <%-- Form Card Body --%>
                        <div class="card-body"> 
                            <%-- Invoice Numbers --%>
                            <div class="row m-2">
                                <h6 class="card-subtitle mb-2 text-muted">Invoice Number</h6>
                                <div class="col-3">
                                    <%-- Starting Invoice --%>
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtInvoiceStart" CssClass="form-control"></asp:TextBox>
                                        <label for="<%=txtInvoiceStart.ClientID %>">Starting Invoice</label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <%-- Ending Invoice --%>
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtInvoiceEnd" CssClass="form-control"></asp:TextBox>
                                        <label for="<%=txtInvoiceEnd.ClientID %>">Ending Invoice</label>
                                    </div>
                                </div>
                            </div>
                            <%-- Chicken Sales --%>
                            <div class="row m-2">
                                <h6 class="card-subtitle mb-2 text-muted">Chicken</h6>
                                <div class="col-3">
                                    <%-- Quantity --%>
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtChickenQuantity" CssClass="form-control" 
                                            TextMode="Number" onchange="CalculateChickenSales()" TabIndex="0">0</asp:TextBox>
                                        <label for="<%=txtChickenQuantity.ClientID%>">Quantity</label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <%-- Price --%>
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtChickenPrice" CssClass="form-control" 
                                            TextMode="Number" onchange="CalculateChickenSales()" TabIndex="0">0</asp:TextBox>
                                        <label for="<%=txtChickenPrice.ClientID%>">Price</label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <%-- Total --%>
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtChickenTotal" CssClass="form-control" 
                                            TextMode="Number" TabIndex="0">0</asp:TextBox>
                                        <label for="<%=txtChickenTotal.ClientID%>">Total</label>
                                    </div>
                                </div>
                            </div>
                            <%-- Atsara Sales --%>
                            <div class="row m-2">
                                <h6 class="card-subtitle mb-2 text-muted">Atsara</h6>
                                <div class="col-3">
                                    <%-- Quantity --%>
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtAtsaraQuantity" CssClass="form-control" 
                                            TextMode="Number" onchange="CalculateAtsaraSales()" TabIndex="0">0</asp:TextBox>
                                        <label for="<%=txtAtsaraQuantity.ClientID%>">Quantity</label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <%-- Price --%>
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtAtsaraPrice" CssClass="form-control" 
                                            TextMode="Number" onchange="CalculateAtsaraSales()" TabIndex="0">0</asp:TextBox>
                                        <label for="<%=txtAtsaraPrice.ClientID%>">Price</label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <%-- Total --%>
                                    <div class="form-floating">
                                        <asp:TextBox runat="server" ID="txtAtsaraTotal" CssClass="form-control" 
                                            TextMode="Number" TabIndex="0">0</asp:TextBox>
                                        <label for="<%=txtAtsaraTotal.ClientID%>">Total</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <%-- Save --%>
                            <asp:LinkButton runat="server" ID="lnkSaveSales" CssClass="btn btn-success" OnClick="lnkSaveSales_Click">
                                Save
                            </asp:LinkButton>
                        </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div> 
    </div>
</asp:Content>
