<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BranchMonthlyExpenses.aspx.cs" Inherits="Book_Keeping_System.BranchMonthlyExpenses" %>
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

        //Search function
        $(function searchInput() {
            $('[id*=txtBranchSearch]').on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvBranchList] tr').filter(function () {
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
                        $('[id*=txtBranchSearch]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            $('[id*=gvBranchList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });

                }
            });
        }
    </script>
    <div class="container-fluid" style="padding-left:0;padding-right:0;">
        <%-- Main Card --%>
        <div class="card" style="border:0;">
            <%-- Main Card Header --%>
            <div class="card-header bg-warning bg-opacity-25">
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
                                <div class="row">
                                    <div class="input-group">
                                        <span class="input-group-text"><b class="fa fa-building"></b></span>
                                        <asp:TextBox runat="server" ID="txtBranchSearch" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body" style="max-height:550px;overflow-y:scroll;">
                                <asp:Panel runat="server" ID="panelGridViewLists">
                                    <asp:GridView runat="server" ID="gvBranchList" GridLines="Horizontal" AutoGenerateColumns="false" CssClass="table table-responsive small">
                                        <Columns>
                                            <asp:BoundField DataField="BranchCode" />
                                            <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                   <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-outline-primary btn-sm"><b class="fa fa-pencil"></b> Select</asp:LinkButton>
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
                            <%-- Form Card Header --%>
                            <div class="card-header">
                                <div class="row justify-content-end">
                                    <div class="col-5">
                                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%-- Form Card Body --%>
                            <div class="card-body">
                                <div class="row m-2">
                                    <div class="col-5">
                                        <div class="form-floating">
                                            <asp:TextBox runat="server" ID="txtSelectedBranch" CssClass="form-control" Text="No Branch Selected"></asp:TextBox>
                                            <label for="<%=txtSelectedBranch.ClientID%>">Selected Branch</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-2">
                                    <%-- TODO Sales --%>
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
