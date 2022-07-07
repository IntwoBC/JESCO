report 50115 "Jesco Stock Ageing"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layout Reports Rdls\JescoStockAgeingNew.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(TodayFormatted; Format(Today, 0, 4)) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(ItemAgeCompositionQtyCaption; ItemAgeCompositionQtyCaptionLbl) { }
            column(PageNoCaption; PageNoCaptionLbl) { }
            column(HeaderText1; HeaderText[1]) { }
            column(HeaderText2; HeaderText[2]) { }
            column(HeaderText3; HeaderText[3]) { }
            column(HeaderText4; HeaderText[4]) { }
            column(PrintLine; PrintLine) { }
            dataitem(Item; Item)
            {
                DataItemTableView = SORTING("No.") WHERE(Type = CONST(Inventory));
                RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
                column(TblCptnItemFilter; TableCaption + ': ' + ItemFilter) { }
                column(ItemFilter; ItemFilter) { }
                column(ItemNo_; "No.") { }
                column(Description; Description) { }
                column(Inventory; Inventory) { }
                column(Unit_Cost; UnitCostAmt)
                { }
                column(InvtQty1_ItemLedgEntry; InvtQty[1]) { DecimalPlaces = 0 : 2; }
                column(InvtQty2_ItemLedgEntry; InvtQty[2]) { DecimalPlaces = 0 : 2; }
                column(InvtQty3_ItemLedgEntry; InvtQty[3]) { DecimalPlaces = 0 : 2; }
                column(InvtQty4_ItemLedgEntry; InvtQty[4]) { DecimalPlaces = 0 : 2; }
                column(InvtValue1_ItemLedgEntry; InvtValue[1]) { AutoFormatType = 1; }
                column(InvtValue2_ItemLedgEntry; InvtValue[2]) { AutoFormatType = 1; }
                column(InvtValue3_ItemLedgEntry; InvtValue[3]) { AutoFormatType = 1; }
                column(InvtValue4_ItemLedgEntry; InvtValue[4]) { AutoFormatType = 1; }
                column(TotalInvtValue; TotalInvtValue) { }


                trigger OnAfterGetRecord()
                var
                    ItemLedgEntry: Record "Item Ledger Entry";
                begin
                    CalcFields(Inventory);
                    Clear(InvtQty);
                    Clear(InvtValue);
                    Clear(UnitCostAmt);
                    Clear(TotalInvtValue);
                    Clear(InvtValue);
                    Clear(TotalInvtQty);
                    for i := 1 to ArrayLen(PeriodEndDate) do begin
                        Clear(ItemLedgEntry);
                        ItemLedgEntry.SetFilter("Posting Date", '%1..%2', PeriodStartDate[i], PeriodEndDate[i]);
                        //ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Purchase);
                        //ItemLedgEntry.SetRange("Document Type", ItemLedgEntry."Document Type"::"Purchase Receipt");
                        ItemLedgEntry.SetRange("Item No.", Item."No.");
                        if ItemLedgEntry.FindSet() then begin
                            repeat
                                ItemLedgEntry.CalcFields("Cost Amount (Actual)");
                                InvtQty[i] += ItemLedgEntry.Quantity;
                                InvtValue[i] += ItemLedgEntry."Cost Amount (Actual)";
                                TotalInvtQty += ItemLedgEntry.Quantity;
                                TotalInvtValue += ItemLedgEntry."Cost Amount (Actual)";
                            until ItemLedgEntry.Next() = 0;
                            if TotalInvtQty <> 0 then
                                UnitCostAmt := TotalInvtValue / TotalInvtQty;
                        end;
                    end;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged As Of';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(Agingby; AgingBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aging by';
                        OptionCaption = 'Posting Date';
                        ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        visible = false;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
                    }

                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            HeadingType := HeadingType::"Number of Days";
            if EndingDate = 0D then
                EndingDate := WorkDate;
            if Format(PeriodLength) = '' then
                Evaluate(PeriodLength, '<1M>');
        end;
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CalcDates;
        CreateHeadings;
        ItemFilter := Item.GetFilters;
        Clear(PrintLine);
        if HeadingType = HeadingType::"Number of Days" then
            PrintLine := true
        else
            PrintLine := false;
    end;

    var
        ItemFilter: Text;
        EndingDate: Date;
        AgingBy: Option "Posting Date";
        PeriodLength: DateFormula;
        HeadingType: Option "Date Interval","Number of Days";
        PrintLine: Boolean;
        i: Integer;
        TotalInvtQty: Decimal;
        InvtQty: array[4] of Decimal;
        PeriodStartDate: array[4] of Date;
        PeriodEndDate: array[4] of Date;
        HeaderText: array[4] of Text[30];
        PageNoCaptionLbl: Label 'Page';
        Text001: Label 'Before';
        Text002: Label 'days';
        Text003: Label 'Above';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        Text032Txt: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        ItemAgeCompositionQtyCaptionLbl: Label 'Item Age Composition - Quantity';
        CompanyInfo: Record "Company Information";
        InvtValue: array[4] of Decimal;
        TotalInvtValue: Decimal;
        UnitCostAmt: Decimal;

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        if not Evaluate(PeriodLength2, StrSubstNo(Text032Txt, PeriodLength)) then
            Error(EnterDateFormulaErr);
        PeriodEndDate[1] := EndingDate;

        //implementing 0-60, 61-180, 180-365, 365 -start
        PeriodStartDate[1] := CalcDate('-60D', EndingDate + 1);
        PeriodEndDate[2] := PeriodStartDate[1] - 1;
        PeriodStartDate[2] := CalcDate('-120D', PeriodEndDate[2] + 1);
        PeriodEndDate[3] := PeriodStartDate[2] - 1;
        PeriodStartDate[3] := CalcDate('-185D', PeriodEndDate[3] + 1);
        PeriodEndDate[4] := PeriodStartDate[3] - 1;
        //PeriodStartDate[4] := CalcDate('-365D', PeriodEndDate[4] + 1);
        PeriodStartDate[4] := 0D;
        //end

        /* commented to implement 0-60, 61-180, 180-365, 365 
         PeriodStartDate[1] := CalcDate(PeriodLength2, EndingDate + 1);
         for i := 2 to ArrayLen(PeriodEndDate) do begin
             PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
             if (i = 6) OR (i = 7) then
                 PeriodStartDate[i] := CalcDate('-7M', PeriodEndDate[i] + 1)
             else
                 PeriodStartDate[i] := CalcDate(PeriodLength2, PeriodEndDate[i] + 1);
         end;*/

        // for i := 6 to ArrayLen(PeriodEndDate) do
        //     PeriodStartDate[i] := 0D;

        // for i := 6 to ArrayLen(PeriodEndDate) do begin
        //     PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
        //     PeriodStartDate[i] := CalcDate('-7M', PeriodEndDate[i] + 1);
        // end;
        //PeriodStartDate[i] := 0D;

        for i := 1 to ArrayLen(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                Error(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        i := 1;
        while i < ArrayLen(PeriodEndDate) do begin
            if HeadingType = HeadingType::"Date Interval" then
                HeaderText[i] := StrSubstNo('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            else
                HeaderText[i] :=
                  StrSubstNo('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        if HeadingType = HeadingType::"Date Interval" then
            HeaderText[i] := StrSubstNo('%1 %2', Text001, PeriodStartDate[i - 1])
        else
            HeaderText[i] := StrSubstNo('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewHeadingType: Option)
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        HeadingType := NewHeadingType;
    end;
}