<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BranchSales.aspx.cs" Inherits="Book_Keeping_System.BranchSales" %>
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
    <div class="container-fluid" style="padding-left:0;padding-right:0;">
        <%-- Main Card --%>
        <div class="card" style="border:0;">
            <%-- Main Card Header --%>
            <div class="card-header bg-success-subtle">
                <b>Branch - Sales</b>
            </div>
            <%-- Main Card Body --%>
            <div class="card-body">
                <div class="row">
                    <div class="col-4">
                        <%-- Branch Card --%>
                        <div class="card">
                            <%-- Branch Dropdown --%>
                            <div class="card-header">
                                <div class="row">
                                    <div class="input-group">
                                        <%-- Search Textbox --%>
                                        <input type="text" id="search-bar" placeholder="Search Branch" 
                                            class="form-control" role="search" />
                                    </div>
                                </div>
                            </div>
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
                                                       OnClick="lnkEdit_Click">
                                                       <b class="fa fa-pencil"></b> Select
                                                   </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <%-- Form Card --%>
                        <div class="card">
                            <asp:UpdatePanel runat="server" ID="upSales" ChildrenAsTriggers="false" UpdateMode="Conditional">
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="lnkChickenRecordSale" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="lnkAtsaraRecordSale" EventName="Click" />
                                </Triggers>
                                <ContentTemplate>
                                <%-- Form Card Header --%>
                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-3">
                                            <asp:TextBox runat="server" ID="txtSelectedBranch" CssClass="form-control" ReadOnly="true" placeholder="No Branch Selected"></asp:TextBox>
                                        </div>
                                        <div class="col-3 offset-6">
                                            <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            <%-- Form Card Body --%>
                            <div class="card-body"> 
                                    <%-- Chicken Sales --%>
                                    <div class="row m-2">
                                        <h6 class="card-subtitle mb-2 text-muted">Chicken</h6>
                                        <div class="col-3">
                                            <%-- Quantity --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtChickenQuantity" CssClass="form-control" 
                                                    TextMode="Number" onchange="CalculateChickenSales()">0</asp:TextBox>
                                                <label for="<%=txtChickenQuantity.ClientID%>">Quantity</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <%-- Price --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtChickenPrice" CssClass="form-control" 
                                                    TextMode="Number" onchange="CalculateChickenSales()">0</asp:TextBox>
                                                <label for="<%=txtChickenPrice.ClientID%>">Price</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <%-- Total --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtChickenTotal" CssClass="form-control" 
                                                    TextMode="Number">0</asp:TextBox>
                                                <label for="<%=txtChickenTotal.ClientID%>">Total</label>
                                            </div>
                                        </div>
                                        <%-- Buttons --%>
                                        <div class="col-3">
                                            <asp:LinkButton runat="server" ID="lnkChickenRecordSale" CssClass="btn btn-outline-success" 
                                                OnClick="lnkRecordSale_Click">Record</asp:LinkButton>
                                        </div>
                                    </div>
                                    <%-- Atsara Sales --%>
                                    <div class="row m-2">
                                        <h6 class="card-subtitle mb-2 text-muted">Atsara</h6>
                                        <div class="col-3">
                                            <%-- Quantity --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtAtsaraQuantity" CssClass="form-control" 
                                                    TextMode="Number" onchange="CalculateAtsaraSales()">0</asp:TextBox>
                                                <label for="<%=txtAtsaraQuantity.ClientID%>">Quantity</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <%-- Price --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtAtsaraPrice" CssClass="form-control" 
                                                    TextMode="Number" onchange="CalculateAtsaraSales()">0</asp:TextBox>
                                                <label for="<%=txtAtsaraPrice.ClientID%>">Price</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <%-- Total --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtAtsaraTotal" CssClass="form-control" 
                                                    TextMode="Number">0</asp:TextBox>
                                                <label for="<%=txtAtsaraTotal.ClientID%>">Total</label>
                                            </div>
                                        </div>
                                        <%-- Button --%>
                                        <div class="col-3">
                                            <asp:LinkButton runat="server" ID="lnkAtsaraRecordSale" CssClass="btn btn-outline-success" 
                                                OnClick="lnkRecordSale_Click">Record</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
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
