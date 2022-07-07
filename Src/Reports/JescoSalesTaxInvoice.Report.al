report 50100 "Jesco Sales-Tax Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layout Reports Rdls\JescoSalesTaxInvoice.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Posted Sales Invoice';
            CalcFields = Amount, "Amount Including VAT";

            //**********************Customer Details*************************
            column(Page_Lbl; PageLbl) { }
            column(Cust_Name; Cust.Name) { }
            column(Cust_add1; Cust.Address) { }
            column(Cust_add2; Cust."Address 2") { }
            column(Cust_Post_Code; Cust."Post Code") { }
            column(Cust_Country; CountryRegion.Name) { } //Cust."Country/Region Code") { }
            column(Cust_VatRegNo; Cust."VAT Registration No.") { }
            //**********************Customer Details*************************
            //**********************Header Details*************************
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_Date; "Document Date") { }
            column(External_Document_No_; "External Document No.") { }
            column(Order_No_; "Order No.") { }
            column(Order_Date; "Order Date") { }
            //**********************Header Details*************************
            //**********************Footer Details*************************
            column(CompInfo_Name; CompanyInfo.Name) { }
            column(CompInfoAdd1; CompanyInfo.Address) { }
            column(CompInfo_Postcode; CompanyInfo."Post Code") { }
            column(Comp_add2; CompanyInfo."Address 2") { }
            column(CompInfo_city; CompanyInfo.City) { }
            column(CompInfo_Coountry; CompanyInfo."Country/Region Code") { }
            column(CompInfo_Phone; CompanyInfo."Phone No.") { }
            column(CompInfo_Fax; CompanyInfo."Fax No.") { }
            column(CompInfo_Email; CompanyInfo."E-Mail") { }
            column(CompInfo_Home; CompanyInfo."Home Page") { }
            column(CompInfo_Picture; CompanyInfo.Picture) { }
            //**********************Footer Details*************************
            column(Currency_Code; CurrencyCode) { }
            column(WorkDescriptionG; WorkDescriptionG) { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(Shipment_Method_Code; TransportMethodG.Description) { }//ShipmentMethodG.Description) { }
            column(User_ID; "User ID") { }
            column(TotalVATAmountInWords; TotalVATAmountInWords) { }
            column(TotalAmountInWords; TotalAmountInWords) { }
            column(Our_Reference; "Our Reference") { }
            column(LC_No; "LC No") { }
            column(Payment_Terms_Code; PaymentTerms.Description) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Address_2; "Bill-to Address 2") { }
            column(Bill_to_City; "Bill-to City") { }
            column(Bill_to_County; "Bill-to County") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code") { }
            column(SetListRowVisibility; SetListRowVisibility) { }
            column(Issueing_Bank; "Issueing Bank") { }
            column(SalesLCY; AmountLCY) { }
            column(VatEnteriesAmount; VatEnteriesAmount) { }
            column(ShippingVisible; ShippingVisible) { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(SrNo; SrNo) { }
                column(Type_Line; Format(Type)) { }
                column(Document_No_; "Document No.") { }
                column(Line_No_; "Line No.") { }
                column(Prepayment_Line; "Prepayment Line") { }
                column(Type_LineNumber; Format(Type.AsInteger())) { }
                column(Quantity; Quantity) { }
                column(Description; Description) { }
                column(Unit_Price; Rate) { }//"Unit Price") { }
                column(Line_Amount; LineAmount) { }
                column(VAT__; "VAT %") { }
                column(Line_Discount_Amount; "Inv. Discount Amount") { }//"Line Discount Amount") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(Taxpayable; Taxpayable) { }
                column(Amt; Amt) { }
                column(ShipmentDocNo; SalesShipmentLine."Document No.") { }
                column(TotalAmt; TotalAmt) { }
                column(TotalInvAmt; TotalInvAmt) { }
                column(TotalLineAmt; TotalLineAmt) { }
                column(TotalInvDiscAmt; TotalInvDiscAmt) { }
                column(TotalTaxPayable; TotalTaxPayable) { }
                column(TotalAmtIncVat; TotalAmtIncVat) { }

                trigger OnAfterGetRecord()
                begin
                    Clear(Taxpayable);
                    Clear(Amt);
                    if Type <> Type::" " then begin
                        if Quantity <> 0 then
                            SrNo += 1;
                    end;

                    //Amt := Quantity * "Unit Price";//7MAY2021
                    Clear(Amt);
                    Clear(LineAmount);
                    Clear(Rate);
                    //if "Sales Invoice Header"."Prices Including VAT" then begin
                    Amt := "Sales Invoice Line".Amount + "Line Discount Amount";
                    LineAmount := "Sales Invoice Line".Amount;
                    if "Sales Invoice Line".Quantity <> 0 then
                        Rate := Amt / "Sales Invoice Line".Quantity
                    else
                        Rate := "Sales Invoice Line"."Unit Price";
                    //end else begin
                    //     Rate := "Sales Invoice Line"."Unit Price";
                    //     Amt := "Sales Invoice Line"."Amount Including VAT";
                    //     LineAmount := "Sales Invoice Line"."Amount Including VAT";
                    // end;

                    Taxpayable := "Amount Including VAT" - Amount;
                    SalesShipmentLine.SetRange("Order No.", "Sales Invoice Line"."Order No.");
                    if SalesShipmentLine.FindFirst() then;

                    TotalAmt += Amount;
                    TotalInvAmt += "Sales Invoice Line".Amount + "Line Discount Amount";
                    TotalLineAmt += LineAmount;
                    TotalInvDiscAmt += "Inv. Discount Amount";
                    TotalTaxPayable += Taxpayable;
                    TotalAmtIncVat += "Amount Including VAT";
                end;
            }

            trigger OnAfterGetRecord()
            Var
                SalesInvLineL: Record "Sales Invoice Line";
                VatEntryL: Record "VAT Entry";
            begin
                Clear(TotalVatAmt);
                Clear(ShipmentMethodG);
                Clear(TransportMethodG);
                Clear(CurrencyCode);
                SrNo := 0;
                if Cust.Get("Sell-to Customer No.") then;
                if ShipmentMethodG.Get("Sales Invoice Header"."Shipment Method Code") then;
                if TransportMethodG.Get("Sales Invoice Header"."Transport Method") then;

                Clear(WorkDescriptionG);
                WorkDescriptionG := GetWorkDescription();

                TotalVatAmt := "Amount Including VAT" - Amount;
                if TotalVatAmt <> 0 then begin
                    Clear(DecimalValue);
                    Clear(DecimalValueInWords);
                    DecimalValue := ROUND(TotalVatAmt) MOD 1 * 100;
                    MyAmountInWords.InitTextVariable();
                    MyAmountInWords.FormatNoText(DecimalValueInWords, DecimalValue, '');
                    IF DecimalValueInWords[1] = '' THEN DecimalValueInWords[1] := 'ZERO';
                    MyAmountInWords.FormatNoText(TotalVATAmountWords, TotalVatAmt, '');
                    TotalVATAmountInWords := TotalVATAmountWords[1] + ' AND ' + DecimalValueInWords[1] + ' ONLY';
                end;
                CalcFields("Amount Including VAT");
                if "Amount Including VAT" <> 0 then begin
                    Clear(DecimalValue);
                    Clear(DecimalValueInWords);
                    DecimalValue := ROUND("Amount Including VAT") MOD 1 * 100;
                    MyAmountInWords.InitTextVariable();
                    MyAmountInWords.FormatNoText(DecimalValueInWords, DecimalValue, '');
                    IF DecimalValueInWords[1] = '' THEN DecimalValueInWords[1] := 'ZERO';
                    MyAmountInWords.FormatNoText(TotalVATAmountWords, "Amount Including VAT", '');
                    TotalAmountInWords := TotalVATAmountWords[1] + ' AND ' + DecimalValueInWords[1] + ' ONLY';
                end;
                if PaymentTerms.Get("Sales Invoice Header"."Payment Terms Code") then;

                SalesInvLineL.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLineL.SetRange("Prepayment Line", true);
                if SalesInvLineL.FindFirst() then
                    SetListRowVisibility := true;

                if "Sales Invoice Header"."Currency Code" <> '' then
                    CurrencyCode := "Sales Invoice Header"."Currency Code"
                else
                    CurrencyCode := GLsetupL."LCY Code";

                AmountLCY := 0;
                CustLedgEntry.SetCurrentKey("Document No.");
                CustLedgEntry.SetRange("Document No.", "No.");
                CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
                CustLedgEntry.SetRange("Customer No.", "Bill-to Customer No.");
                if CustLedgEntry.FindFirst then begin
                    CustLedgEntry.CalcFields("Amount (LCY)");
                    if CurrencyCode <> 'AED' then
                        AmountLCY := CustLedgEntry."Amount (LCY)";
                end;
                Clear(CountryRegion);
                if CountryRegion.Get(Cust."Country/Region Code") then;

                Clear(VatEntryL);
                VatEnteriesAmount := 0;
                VatEntryL.SetRange("Document No.", "No.");
                if VatEntryL.FindSet() then
                    repeat
                        VatEnteriesAmount += VatEntryL.Amount;
                    until VatEntryL.Next() = 0;
            end;

            trigger OnPreDataItem()
            begin
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(ShippingVisible; ShippingVisible)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Address';
                    }
                }
            }
        }
    }
    labels
    {
        TaxInvLbl = 'TAX INVOICE';
        CustLbl = 'Customer :';
        PoBoxLbl = 'Po Box -';
        TRNLbl = 'TRN :';
        SlnoLbl = 'SL No';
        TRLbl = 'TRN';
        TaxInvnoLbl = 'Tax Invoice No';
        DateofInvLbl = 'Date of Invoice';
        DateofSuppLbl = 'Date of Supply';
        JobLbl = 'Job No';
        LpoRefLbl = 'LPO Ref No';
        LpoDateLbl = 'LPO Date';
        DNLbl = 'DN No';
        MRFLbl = 'MRF No';
        PreparedLbl = 'Prepared By';
        TotalAmtInLbl = 'TOTAL AMOUNT IN';
        BankDetailsLbl = 'Bank Details';
        HeadOffLbl = 'Head Office';
        Officelbl = 'Office no:';
        POlbl = 'P.O. Box:';
        PhnoneLbl = 'Phone:';
        FaxLbl = 'Fax:';
        EmailLbl = 'E-mail:';
        Weblbl = 'Web:';

    }
    trigger OnInitReport()
    begin
        if GLsetupL.Get() then;
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get;
    end;

    var
        GLsetupL: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        MyAmountInWords: Report "My Amount In Words";
        TotalVatAmt: Decimal;
        DecimalValue: Decimal;
        DecimalValueInWords: ARRAY[2] OF Text;
        TotalVATAmountWords: ARRAY[2] OF Text;
        TotalAmountInclVATWords: ARRAY[2] OF Text;
        TotalVATAmountInWords: Text;
        TotalAmountInWords: Text;
        Taxpayable: Decimal;
        Amt: Decimal;
        SrNo: Integer;
        ShipmentMethodG: Record "Shipment Method";
        TransportMethodG: Record "Transport Method";
        PageLbl: Label 'Page';
        SalesShipmentLine: Record "Sales Shipment Line";
        WorkDescriptionG: Text;
        LineAmount: Decimal;
        Rate: Decimal;
        PaymentTerms: Record "Payment Terms";
        TotalAmt: Decimal;
        TotalLineAmt: Decimal;
        TotalTaxPayable: Decimal;
        TotalAmtIncVat: Decimal;
        SetListRowVisibility: Boolean;
        CurrencyCode: Text;
        CustLedgEntry: Record "Cust. Ledger Entry";
        AmountLCY: Decimal;
        TotalInvAmt: Decimal;
        TotalInvDiscAmt: Decimal;
        CountryRegion: Record "Country/Region";
        VatEnteriesAmount: Decimal;
        ShippingVisible: Boolean;
}
