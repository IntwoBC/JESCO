report 50112 "Sales Order Booking Report"
{
    ApplicationArea = All;
    Caption = 'Sales Order Booking Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layout Reports Rdls\SalesOrderBooking.rdl';
    //ExcelLayout = '.\Layout Reports Rdls\SalesOrderBooking.xlsx';
    dataset
    {

        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type") order(ascending);

            column(Logo; RecCompanyInformation.Picture) { }
            column(ReportCaption; ReportCaption) { }
            column(AsOfDate; AsOfDate) { }
            column(BacklogYear1; BacklogYear1) { }
            column(BacklogYear2; BacklogYear2) { }
            column(BacklogYear3; BacklogYear3) { }
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
            column(BacklogYear1Amt; YearlyAndMonthlyAmt[1]) { }
            column(BacklogYear2Amt; YearlyAndMonthlyAmt[2]) { }
            column(BacklogYear3Amt; YearlyAndMonthlyAmt[3]) { }
            column(JanAmt; YearlyAndMonthlyAmt[4]) { }
            column(FebAmt; YearlyAndMonthlyAmt[5]) { }
            column(MarAmt; YearlyAndMonthlyAmt[6]) { }
            column(AprAmt; YearlyAndMonthlyAmt[7]) { }
            column(MayAmt; YearlyAndMonthlyAmt[8]) { }
            column(JunAmt; YearlyAndMonthlyAmt[9]) { }
            column(JulAmt; YearlyAndMonthlyAmt[10]) { }
            column(AugAmt; YearlyAndMonthlyAmt[11]) { }
            column(SepAmt; YearlyAndMonthlyAmt[12]) { }
            column(OctAmt; YearlyAndMonthlyAmt[13]) { }
            column(NovAmt; YearlyAndMonthlyAmt[14]) { }
            column(DecAmt; YearlyAndMonthlyAmt[15]) { }
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

                if not CheckList.Contains("Sell-to Country/Region Code") then
                    CheckList.Add("Sell-to Country/Region Code")
                else
                    if CheckList.Contains("Sell-to Country/Region Code") then
                        CurrReport.Skip();


                GLSetup.GET;
                AdditionalCurrency := GLSetup."Additional Reporting Currency";

                if CountryName.Get("Sell-to Country/Region Code") then;
                Clear(YearlyAndMonthlyAmt);// clearing for each company as this will store data per comp
                Clear(CompanyWiseTotalAmount); // it will store total sales for one Country - total of years and months for 1 company
                for i := 1 to ArrayLen(YearlyAndMonthlyAmt) do begin
                    Clear(RecSalesHeader);
                    RecSalesHeader.SetRange("Sell-to Country/Region Code", "Sales Header"."Sell-to Country/Region Code");
                    RecSalesHeader.SetRange("Document Type", RecSalesHeader."Document Type"::Order);
                    case i of
                        1:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromYear(BacklogYear1));
                        2:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromYear(BacklogYear2));
                        3:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromYear(BacklogYear3));
                        4:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(1));
                        5:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(2));
                        6:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(3));
                        7:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(4));
                        8:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(5));
                        9:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(6));
                        10:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(7));
                        11:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(8));
                        12:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(9));
                        13:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(10));
                        14:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(11));
                        15:
                            RecSalesHeader.SetFilter("Posting Date", GetDateFilterFromMonth(12));
                    end;
                    if RecSalesHeader.FindSet() then begin
                        repeat

                            RecSalesHeader.CalcFields("Amount Including VAT");
                            if RecSalesHeader."Currency Factor" <> 0 then
                                CurrencyFactor := RecSalesHeader."Currency Factor"
                            else
                                CurrencyFactor := 1;

                            if AdditionalCurrency <> '' then begin
                                Clear(CurrencyExchangeRate);
                                AdditionalBalanceCaption := AdditionalCurrency;
                                YearlyAndMonthlyAmt[i] += CurrencyExchangeRate.ExchangeAmount(Round(RecSalesHeader."Amount Including VAT" / CurrencyFactor, 0.01, '>'), GLSetup."LCY Code", GLSetup."Additional Reporting Currency", RecSalesHeader."Posting Date");
                            end else begin
                                AdditionalBalanceCaption := GLSetup."LCY Code";
                                YearlyAndMonthlyAmt[i] += Round(RecSalesHeader."Amount Including VAT" / CurrencyFactor, 0.01, '>');
                            end;


                        //YearlyAndMonthlyAmt[i] += Round(((RecSalesHeader."Amount Including VAT" / CurrencyFactor) * ExchangeRate), 0.01, '>');

                        until RecSalesHeader.Next() = 0;

                        if i > 3 then
                            CompanyWiseTotalAmount += YearlyAndMonthlyAmt[i];
                    end;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetCurrentKey("Document Type", "Sell-to Country/Region Code");
                SetFilter("Document Type", Format("Document Type"::Order));
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
        BacklogYear1 := Format(Date2DMY(AsOfDate, 3) - 1);
        BacklogYear2 := Format(Date2DMY(AsOfDate, 3) - 2);
        BacklogYear3 := Format(Date2DMY(AsOfDate, 3) - 3);

        RecCompanyInformation.GET;
        RecCompanyInformation.CalcFields(Picture);
    end;

    local procedure GetDateFilterFromYear(YearP: text): Text
    var
        Year: Integer;
    begin
        Evaluate(Year, YearP);
        exit(FORMAT(DMY2Date(1, 1, Year)) + '..' + Format(DMY2Date(31, 12, Year)));
    end;

    local procedure GetDateFilterFromMonth(Month: Integer): Text
    var
        Year: Integer;
    begin
        Evaluate(Year, CurrentYear);
        exit(Format(CalcDate('-CM', DMY2Date(1, Month, Year))) + '..' + Format(CalcDate('CM', DMY2Date(1, Month, Year))));
    end;

    var
        RecSalesHeader: Record "Sales Header";
        ExcelBuffer: Record "Excel Buffer" temporary;
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
        BacklogYear1, BacklogYear2, BacklogYear3, CurrentYear : Text;
        AsOfDate: Date;
        ReportCaption: Label 'Sales / Order Booking Report';
        RecCompanyInformation: Record "Company Information";
        YearlyAndMonthlyAmt: array[15] of Decimal;
        GLSetup: Record "General Ledger Setup";
        AdditionalBalanceCaption: Text;
        CompanyWiseTotalAmount: Decimal;
        CheckList: List of [Text];
        CountryName: Record "Country/Region";
}
