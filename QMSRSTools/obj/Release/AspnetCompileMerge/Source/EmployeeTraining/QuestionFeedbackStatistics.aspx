<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="QuestionFeedbackStatistics.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.QuestionFeedbackStatistics" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div id="viewer" class="reportviewer">
           <rsweb:reportviewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%">
                <LocalReport ReportEmbeddedResource="QMSRSTools.Reports.FeedbackStatistics.rdlc">
                     <DataSources>
                         <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                     </DataSources>
                </LocalReport>
            </rsweb:reportviewer>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="QMSRSTools.AdminToolsDataSetTableAdapters.FeedbackStatisticsTableAdapter">
            </asp:ObjectDataSource>
    </div>
</asp:Content>
