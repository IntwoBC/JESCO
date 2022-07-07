report 50113 "Revenue/Invoiced Sales Report"
{
    ApplicationArea = All;
    Caption = 'Revenue/Invoiced Sales Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layout Reports Rdls\Revenue_InvoicedSales.rdl';

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            //DataItemTableView = sorting(Name) order(ascending);

            column(Logo; RecCompanyInformation.Picture) { }
            column(ReportCaption; ReportCaption) { }
            column(AsOfDate; AsOfDate) { }
            column(CurrentYear; CurrentYear) { }
            column(Jan; Jan) { }
            column(Feb; Feb) { }
            column(Mar; Mar) { }
            column(APR; APR) { }
            column(May; May) { }
            column(Jun; Jun) { }
            column(JUL; JUL) { }
            column(Aug; Aug) { }
            column(Sep; Sep) { }
            column(Oct; Oct) { }
            column(Nov; Nov) { }
            column(Dec; Dec) { }
            //variables--start
            column(AdditionalBalanceCaption; AdditionalBalanceCaption) { }

            column(JanAmt; YearlyAndMonthlyAmt[1]) { }
            column(FebAmt; YearlyAndMonthlyAmt[2]) { }
            column(MarAmt; YearlyAndMonthlyAmt[3]) { }
            column(AprAmt; YearlyAndMonthlyAmt[4]) { }
            column(MayAmt; YearlyAndMonthlyAmt[5]) { }
            column(JunAmt; YearlyAndMonthlyAmt[6]) { }
            column(JulAmt; YearlyAndMonthlyAmt[7]) { }
            column(AugAmt; YearlyAndMonthlyAmt[8]) { }
            column(SepAmt; YearlyAndMonthlyAmt[9]) { }
            column(OctAmt; YearlyAndMonthlyAmt[10]) { }
            column(NovAmt; YearlyAndMonthlyAmt[11]) { }
            column(DecAmt; YearlyAndMonthlyAmt[12]) { }
            column(CompanyWiseTotalAmount; CompanyWiseTotalAmount) { }

            column(Display_Name; CountryName.Name) { }

            trigger OnAfterGetRecord()
            var
                RecCompanyInfo: Record "Company Information";
                AdditionalCurrency: Code[10];
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                CurrencyFactor: Decimal;
                i: Integer;
            begin

                if not RecCompanyInformation."Sales Order Booking Report" then
                    CurrReport.Skip();


                GLSetup.GET;
                AdditionalCurrency := GLSetup."Additional Reporting Currency";

                if not CheckList.Contains("Sell-to Country/Region Code") then
                    CheckList.Add("Sell-to Country/Region Code")
                else
                    if CheckList.Contains("Sell-to Country/Region Code") then
                        CurrReport.Skip();


                if CountryName.Get("Sell-to Country/Region Code") then;
                Clear(YearlyAndMonthlyAmt);// clearing for each company as this will store data per comp
                Clear(CompanyWiseTotalAmount); // it will store total sales for one company - total of years and months for 1 company
                for i := 1 to ArrayLen(YearlyAndMonthlyAmt) do begin
                    Clear(RecSalesInvHeader);
                    //RecSalesInvHeader.ChangeCompany(Company.Name);
                    RecSalesInvHeader.SetRange("Sell-to Country/Region Code", Header."Sell-to Country/Region Code");
                    //RecSalesInvHeader.SetRange("Document Type", RecSalesInvHeader."Document Type"::Order);    
                    case i of
                        1:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(1));
                        2:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(2));
                        3:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(3));
                        4:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(4));
                        5:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(5));
                        6:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(6));
                        7:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(7));
                        8:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(8));
                        9:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(9));
                        10:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(10));
                        11:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(11));
                        12:
                            RecSalesInvHeader.SetFilter("Posting Date", GetDateFilterFromMonth(12));

                    end;
                    if RecSalesInvHeader.FindSet() then begin
                        repeat
                            RecSalesInvHeader.CalcFields("Amount Including VAT", "Remaining Amount");
                            if RecSalesInvHeader."Currency Factor" <> 0 then
                                CurrencyFactor := RecSalesInvHeader."Currency Factor"
                            else
                                CurrencyFactor := 1;

                            if AdditionalCurrency <> '' then begin
                                Clear(CurrencyExchangeRate);
                                AdditionalBalanceCaption := AdditionalCurrency;
                                YearlyAndMonthlyAmt[i] += CurrencyExchangeRate.ExchangeAmount(Round(RecSalesInvHeader."Amount Including VAT" / CurrencyFactor, 0.01, '>'), GLSetup."LCY Code", GLSetup."Additional Reporting Currency", RecSalesInvHeader."Posting Date");
                            end else begin
                                AdditionalBalanceCaption := GLSetup."LCY Code";
                                YearlyAndMonthlyAmt[i] += Round(RecSalesInvHeader."Amount Including VAT" / CurrencyFactor, 0.01, '>');
                            end;

                        // YearlyAndMonthlyAmt[i] += Round(((RecSalesInvHeader."Remaining Amount" / CurrencyFactor) / ExchangeRate), 0.01, '>');

                        until RecSalesInvHeader.Next() = 0;
                        CompanyWiseTotalAmount += YearlyAndMonthlyAmt[i];
                    end;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetCurrentKey("Sell-to Country/Region Code");
                SetFilter("Sell-to Country/Region Code", '<>%1', '');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(AsOfDate; AsOfDate)
                    {
                        ApplicationArea = All;
                        caption = 'As of Date';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        if AsOfDate = 0D then
            Error('As of Date must have a value.');
        CurrentYear := FORMAT(Date2DMY(AsOfDate, 3));

        RecCompanyInformation.GET;
        RecCompanyInformation.CalcFields(Picture);
    end;


    local procedure GetDateFilterFromMonth(Month: Integer): Text
    var
        Year: Integer;
    begin
        Evaluate(Year, CurrentYear);
        exit(Format(CalcDate('-CM', DMY2Date(1, Month, Year))) + '..' + Format(CalcDate('CM', DMY2Date(1, Month, Year))));
    end;

    var
        RecSalesInvHeader: Record "Sales Invoice Header";
        Jan: Label 'Jan';
        Feb: Label 'Feb';
        Mar: label 'March';
        APR: Label 'April';
        May: Label 'May';
        Jun: label 'June';
        JUL: Label 'July';
        Aug: Label 'August';
        Sep: label 'September';
        Oct: Label 'October';
        Nov: Label 'November';
        Dec: label 'December';
        CurrentYear: Text;
        AsOfDate: Date;
        ReportCaption: Label 'Revenue/Invoiced Sales Report';
        RecCompanyInformation: Record "Company Information";
        YearlyAndMonthlyAmt: array[12] of Decimal;
        GLSetup: Record "General Ledger Setup";
        AdditionalBalanceCaption: Text;
        CompanyWiseTotalAmount: Decimal;
        CheckList: List of [Text];
        CountryName: Record "Country/Region";
}
