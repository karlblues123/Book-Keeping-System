<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="AuditLogs.aspx.cs" Inherits="Book_Keeping_System.Scripts.AuditLogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function pageLoad() {
            //Search function for Branch List
            $('[id*=log-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvLogs] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

        }
    </script>
    <div class="container-fluid">
        <div class="m-2 h6">Audit Logs</div>
        <div class="row">
            <div class="col">
                <div class="card" style="max-height:80vh;">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-4">
                                <%-- Search --%>
                                <input type="text" id="log-search" class="form-control" placeholder="Search" />
                            </div>
                        </div>
                    </div>
                    <div class="card-body overflow-y-auto">
                        <%-- Log List --%>
                        <asp:GridView runat="server" ID="gvLogs" CssClass="table table-responsive" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="Module" HeaderText="Module" ItemStyle-Width="25%" />
                                <asp:BoundField DataField="UserCode" HeaderText="Username" ItemStyle-Width="25%" />
                                <asp:BoundField DataField="Actions" HeaderText="Action" ItemStyle-Width="25%" />
                                <asp:BoundField DataField="DU" HeaderText="Date and Time" ItemStyle-Width="25%" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
